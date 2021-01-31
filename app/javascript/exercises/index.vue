<template>
<div class="container">
  <div class="columns">
    <div class="column is-one-fifth left-menu">
      <a class="button is-fullwidth" href="/users/sign_out" data-method="delete">ログアウト</a>
      <button class="button is-fullwidth" @click="goToPost">投稿ページ</button>
      <button class="button is-fullwidth" @click="goToHome">学習ホーム</button>
      <button class="button is-fullwidth" @click="goToTerm">登録単語一覧</button>
    </div>
    <div class="column">
      <exercise-table
        v-if="isDoing.isTable"
        :lesson-count="lessonCount"
        @do-exercise="doExercise($event)"
      ></exercise-table>
      <exercise-area
        v-if="isDoing.isExercise"
        :question-data="questionData"
      ></exercise-area>
      <term-index
        v-if="isDoing.isTerm"
        :lesson-count="lessonCount"
      ></term-index>
    </div>
  </div>
</div>
</template>

<script>
import Table from './table'
import Exercise from './exercise'
import Term from './term'

export default {
  components: {
    'exercise-table': Table,
    'exercise-area': Exercise,
    'term-index': Term,
  },
  data() {
    return {
      questionData: {},
      lessonCount: 45,
      isDoing: {
        isTable: true,
        isExercise: false,
        isTerm: false,
      }
    }
  },
  methods: {
    goToPost: function() {
      window.location.href = '/posts'
    },
    goToHome: function() {
      this.isDoing.isTable = true
      this.isDoing.isExercise = false
      this.isDoing.isTerm = false

      this.questionData = {}
    },
    goToTerm: function() {
      this.isDoing.isTable = false
      this.isDoing.isExercise = false
      this.isDoing.isTerm = true

      this.questionData = {}
    },
    doExercise: function(questionDataParams) {
      this.questionData.display = questionDataParams.display
      this.getQuestions(questionDataParams)
    },
    getQuestions: function(questionDataParams) {
      const exercisePath = `exercises/${questionDataParams.lesson}/${questionDataParams.type}.json`
      fetch(exercisePath)
        .then(response => {
          return response.json()
        })
        .then(data => {
          this.questionData.questions = data
          this.getScores(questionDataParams)
        })
        .catch(error => {
          console.log(error)
        })
    },
    getScores: function(questionDataParams) {
      const scorePath = `exercises/${questionDataParams.lesson}/${questionDataParams.type}/${questionDataParams.display}.json`
      fetch(scorePath)
        .then(response => {
          return response.json()
        })
        .then(data => {
          this.questionData.scores = data
          this.goToExercise()
        })
        .catch(error => {
          console.log(error)
        })
    },
    goToExercise: function() {
      this.isDoing.isTable = false
      this.isDoing.isExercise = true
    }
  }
}
</script>