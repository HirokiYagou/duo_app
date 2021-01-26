<template>
<div>
  <div class="box">
    <div class="columns">
      <div
        class="column is-1"
        v-for="(score, index) in currentQuestion.scores"
        :key="index"
      >
        <p class="is-size-4">{{ { 0: '○', 1: '△', 2: '×' }[score.score] }}</p>
      </div>
      <div class="column">
        <p class="is-size-5 has-text-right">{{ currentIndex + 1 }} / {{ questionLength }}</p>
      </div>
    </div>
    <p class="is-size-4 has-text-weight-medium">{{ currentQuestion.text }}</p>
  </div>
  <div class="box" v-show="isShowAnswer">
    <p class="is-size-5">Answer</p>
    <p class="is-size-4 has-text-weight-medium">{{ currentQuestion.answer }}</p>
  </div>
  <div class="box">
    <form @submit.prevent="showAnswer">
      <label class="label">Your Answer</label>
      <div class="columns">
        <div class="column is-10">
          <textarea
          v-model="writtenAnswer"
          class="textarea is-medium"
          name="answer"
          id="answer"
          rows="2" 
          cols="30"
          placeholder="write your answer, if ENGLISH"
          autofocus
        ></textarea>
        </div>
        <div class="column is-2"><button class="button is-fullwidth">CHECK</button></div>
      </div>
    </form>
  </div>
  <div class="container columns" v-show="isShowAnswer">
    <div class="column">
      <button class="button is-fullwidth is-success" @click="doNextQuestion(0)">○</button>
    </div>
    <div class="column">
      <button class="button is-fullwidth is-warning" @click="doNextQuestion(1)">△</button>
    </div>
    <div class="column">
      <button class="button is-fullwidth is-danger" @click="doNextQuestion(2)">×</button>
    </div>
  </div>
</div>
</template>

<script>
export default {
  props: {
    currentQuestion: Object,
    currentIndex: Number,
    questionLength: Number,
  },
  data() {
    return {
      writtenAnswer: '',
      isShowAnswer: false,
    }
  },
  methods: {
    showAnswer: function() {
      this.isShowAnswer = true
    },
    doNextQuestion: function(ans) {
      this.$emit('next-question', ans)
      this.isShowAnswer = false
      this.writtenAnswer = ''
    }
  }
}
</script>

<style scoped>
.textarea {
  resize: none;
}
</style>