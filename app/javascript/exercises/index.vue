<template>
<div class="container">
  <div class="columns">
    <div class="column is-one-fifth left-menu">
      <nav-bar
        :current-user-name="currentUser.name"
        @do-set-user="doSetUserExercises"
      ></nav-bar>
      <button class="button is-fullwidth is-light is-info" @click="goToTerm">Terms Index</button>
      <button class="button is-fullwidth is-info" @click="goToHome">EXERCISE</button>
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
import nav_barVue from '../shared/nav_bar.vue'

export default {
  components: {
    'nav-bar': nav_barVue,
    'exercise-table': Table,
    'exercise-area': Exercise,
    'term-index': Term,
  },
  data() {
    return {
      currentUser: {},
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
    fetchCurrentUser: function() {
      fetch('/exercises.json')
        .then(response => {
          return response.json()
        })
        .then(data => {
          this.currentUser = data.currentuser
        })
        .catch(error => {
          console.log(error)
        })
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
    },
    doSetUserExercises: function() {
      
    }
  },
  created: function() {
    this.fetchCurrentUser()
  }
}
</script>