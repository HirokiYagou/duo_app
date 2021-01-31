<template>
<div class="container">
  <h1 class="title is-1">Admin画面</h1>
  <div class="columns">
    <div class="column is-one-fifth left-menu">
      <a class="button is-fullwidth" href="/users/sign_out" data-method="delete">ログアウト</a>
      <button class="button is-fullwidth" @click="goToPost">投稿ページ</button>
      <button class="button is-fullwidth" @click="goToHome">Adminホーム</button>
      <button class="button is-fullwidth" @click="goToForm">新規登録</button>
      <button class="button is-fullwidth is-info" @click="goToTerm">登録単語一覧</button>
    </div>
    <div class="column auto">
      <create-form v-if="page.form"></create-form>
      <term-index v-if="page.term" :lessonCount="45"></term-index>
    </div>
  </div>
</div>
</template>

<script>
import Form from './form'
import Term from '../../exercises/term.vue'

export default {
  components: {
    'create-form': Form,
    'term-index': Term,
  },
  data() {
    return {
      page: {
        form: false,
        term: false,
      }
    }
  },
  methods: {
    goToPost: function() {
      window.location.href = '/posts'
    },
    goToHome: function() {
      this.page.form = false
      this.page.term = false
    },
    goToForm: function() {
      this.page.form = true
      this.page.term = false
    },
    goToTerm: function() {
      this.page.form = false
      this.page.term = true
    }
  }
}
</script>
