<template>
<div>
  <h3 class="title is-3">
    <span class="space-right">LESSON{{ questionData.questions[0].lesson }}</span>
    <span class="space-right">{{ questionType }}</span>
    <span class="space-right">{{ questionBefore.toUpperCase() }} to {{ questionAfter.toUpperCase() }}</span>
  </h3>
  <question
    v-if="currentQuestion"
    :current-question="currentQuestion"
    :current-index="currentIndex"
    :question-length="questionLength"
    @next-question="nextQuestion($event)"
  ></question>
  <result
    v-if="!currentQuestion"
  ></result>
</div>
</template>

<script>
import Question from './question'
import Result from './result'

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
      yourAnswers: [],
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
      this.yourAnswers.push(ans)
      if (this.currentIndex < this.questionLength) {
        this.currentIndex += 1
      }
    }
  }
}
</script>

<style scoped>
.space-right {
  margin-right: 20px;
}
</style>