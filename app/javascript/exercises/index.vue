<template>
<div class="container">
  <div class="columns">
    <div class="column is-one-fifth left-menu">
      <a class="button is-fullwidth" href="/users/sign_out" data-method="delete">ログアウト</a>
      <button class="button is-fullwidth" @click="goToPost">投稿ページ</button>
      <button class="button is-fullwidth" @click="goToHome">学習ホーム</button>
      <button class="button is-fullwidth" @click="goToSentences">登録単語一覧</button>
    </div>
    <div class="column">
      <exercise-table
        v-if="isDoing.isTable"
        @do-exercise="doExercise($event)"
      ></exercise-table>
      <exercise-area
        v-if="isDoing.isExercise"
        :question-data="questionData"
      ></exercise-area>
    </div>
  </div>
</div>
</template>

<script>
import Table from './table'
import Exercise from './exercise'

export default {
  components: {
    'exercise-table': Table,
    'exercise-area': Exercise,
  },
  data() {
    return {
      questionData: {},
      isDoing: {
        isTable: true,
        isExercise: false,
        // isSentence: false,
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
      // this.isDoing.isSentence = false

      this.questionData = {}
    },
    // goToHome: function() {
    //   this.isDoing.isTable = false
    //   this.isDoing.isExercise = false
    //   this.isDoing.isSentence = true
    // },
    doExercise: function(questionDataParams) {
      console.log(questionDataParams)
      // this.questionData = questionDataParams
      this.isDoing.isTable = false
      this.isDoing.isExercise = true
      // this.isDoing.isSentence = false
    }
  }
}
</script>