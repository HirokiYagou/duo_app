<template>
<div class="container">
  <div class="columns">
    <div class="column is-one-fifth left-menu">
      <a class="button is-fullwidth" href="/users/sign_out" data-method="delete">ログアウト</a>
      <button class="button is-fullwidth" @click="goToPost">投稿ページ</button>
      <button class="button is-fullwidth" @click="goToHome">学習ホーム</button>
      <button class="button is-fullwidth" @click="goToSentences">登録文章一覧</button>
      <button class="button is-fullwidth" @click="goToWords">登録単語一覧</button>
    </div>
    <div class="column">
      <exercise-table
        @do-exercise="doExercise($event)"
      ></exercise-table>
    </div>
  </div>
</div>
</template>

<script>
import Table from './table'

export default {
  components: {
    'exercise-table': Table,
  },
  methods: {
    goToPost: function() {
      window.location.href = '/posts'
    },
    doExercise: function(questionData) {
      console.log(questionData)
    }
  }
}
</script>