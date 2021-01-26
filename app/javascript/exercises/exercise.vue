<template>
<div>
  <h3 class="title is-3">
    <!-- <span class="space-right">LESSON{{ questionData.questions[0].lesson }}</span> -->
    <span class="space-right">{{ questionType }}</span>
    <span class="space-right">{{ questionBefore.toUpperCase() }} to {{ questionAfter.toUpperCase() }}</span>
  </h3>
  <question
    v-if="!isResult"
    :current-question="currentQuestion"
    :current-index="currentIndex"
    :question-length="questionLength"
    @next-question="nextQuestion($event)"
  ></question>
  <result
    v-if="isResult"
    :your-results="yourResults"
  ></result>
</div>
</template>

<script>
import Question from './question'
import Result from './result'
import { csrfToken } from "@rails/ujs"

const resultFigure = { 0: '○', 1: '△', 2: '×'}
const displayNumber = { 'english': 0, 'japanese': 1}

export default {
  components: {
    'question': Question,
    'result': Result,
  },
  props: {
    questionData: Object,
  },
  data() {
    return {
      currentIndex: 0,
      yourResults: [],
      isResult: false
    }
  },
  computed: {
    questionType: function() {
      if(this.questionData.questions[0].word_id === 0) {
        return 'SENTENCES'
      } else {
        return 'WORDS'
      }
    },
    questionBefore: function() {
      return this.questionData.display
    },
    questionAfter: function() {
      if(this.questionData.display === 'english') {
        return 'japanese'
      } else {
        return 'english'
      }
    },
    currentQuestion: function() {
      return {
        text: this.questionData.questions[this.currentIndex][this.questionBefore],
        answer: this.questionData.questions[this.currentIndex][this.questionAfter]
      }
    },
    questionLength: function() {
      return this.questionData.questions.length
    }
  },
  methods: {
    nextQuestion: function(ans) {
      const result = {}
      result.yourAnswer = resultFigure[ans]
      result.questionText = this.currentQuestion.text
      result.questionAnswer = this.currentQuestion.answer
      this.yourResults.push(result)

      this.saveAnswer(ans)

      this.currentIndex += 1
      if (this.currentIndex === this.questionLength) {
        this.isResult = true
      }
    },
    saveAnswer: function(ans) {
      const DISPLAY = this.questionData.display
      const path = `exercises/${this.questionData.questions[this.currentIndex].id}`
      const formData = new FormData()
      formData.append('exercise[e_j]', displayNumber[DISPLAY])
      formData.append('exercise[score]', ans)
      fetch(path, {
          method: 'PUT',
          headers: {
            'X-CSRF-Token': csrfToken(),
          },
          body: formData
        })
    },
  }
}
</script>

<style scoped>
.space-right {
  margin-right: 20px;
}
</style>