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
      <button class="button is-fullwidth" @click="playVoice">EXERCISE</button>
      <!-- <audio :src="audioSrc" autoplay></audio> -->
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
      },
      audio: new Audio(),
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
    playVoice: function() {
      // const sendData = {
      //   "input":{
      //     "text":"Android is a mobile operating system developed by Google, based on the Linux kernel and designed primarily for touchscreen mobile devices such as smartphones and tablets."
      //   },
      //   "voice":{
      //     "languageCode":"en-gb",
      //     "name":"en-GB-Standard-A",
      //     "ssmlGender":"FEMALE"
      //   },
      //   "audioConfig":{
      //     "audioEncoding":"MP3"
      //   }
      // }
      // fetch('https://texttospeech.googleapis.com/v1/text:synthesize', {
      //     method: 'POST',
      //     headers: {
      //       'Content-Type': 'application/json',
      //     },
      //     body: JSON.stringify(sendData),
      //   })
      fetch('/speechs.json')
        .then(response => {
          return response.json()
        })
        .then(data => {
          console.log(data.voice_data)
          this.audio.src = data.voice_data
          this.audio.load()
          this.audio.addEventListener('loadedmetadata', () => {
            console.log(this.audio)
            this.audio.play()
          })
          this.audio.addEventListener('ended', () => {
            this.audio = new Audio()
            console.log(this.audio)
          })
          // const voice = new Audio('/output.mp3')
          // voice.play()
        })
        .catch(error => {
          console.log(error)
        })
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