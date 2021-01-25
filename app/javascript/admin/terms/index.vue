<template>
<div class="container">
  <h1 class="title is-1">Admin画面</h1>
  <div class="columns">
    <div class="column is-one-fifth left-menu">
      <a class="button is-fullwidth" href="/users/sign_out" data-method="delete">ログアウト</a>
      <button class="button is-fullwidth" @click="goToPost">投稿ページ</button>
      <button class="button is-fullwidth" @click="goToHome">Adminホーム</button>
      <button class="button is-fullwidth" @click="goToForm">新規登録</button>
      <button class="button is-fullwidth" @click="goToSentences">登録文章一覧</button>
      <button class="button is-fullwidth" @click="goToWords">登録単語一覧</button>
    </div>
    <div class="column auto">
      <create-form v-if="page.form"></create-form>
    </div>
  </div>
</div>
</template>

<script>
import Form from './form'

export default {
  components: {
    'create-form': Form,
  },
  data() {
    return {
      page: {
        form: false,
        // sentence: false,
        // word: false,
      }
    }
  },
  methods: {
    goToPost: function() {
      window.location.href = '/posts'
    },
    goToHome: function() {
      this.page.form = false
      // this.page.sentence = false
      // this.page.word = false
    },
    goToForm: function() {
      this.page.form = true
      // this.page.sentence = false
      // this.page.word = false
    }
  }
}
</script>
