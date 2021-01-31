<template>
<div class="container">
  <h1 class="title is-1">Admin画面</h1>
  <div class="columns">
    <div class="column is-one-fifth left-menu">
      <nav-bar
        :current-user-name="'admin'"
        @do-set-user="doSetUserPosts"
      ></nav-bar>
      <button class="button is-fullwidth" @click="goToHome">Adminホーム</button>
      <button class="button is-fullwidth is-link" @click="goToForm">新規登録</button>
      <button class="button is-fullwidth is-info" @click="goToTerm">登録単語一覧</button>
    </div>
    <div class="column auto">
      <create-form
        v-if="page.form"
        :edit-info="editInfo"
        @done-edit="clearEditInfo"
      ></create-form>
      <term-index
        v-if="page.term"
        :current-user="'admin'"
        :lessonCount="45"
        @edit-term="editTerm($event)"
      ></term-index>
    </div>
  </div>
</div>
</template>

<script>
import Form from './form'
import Term from '../../exercises/term.vue'
import nav_barVue from '../../shared/nav_bar.vue'

export default {
  components: {
    'nav-bar': nav_barVue,
    'create-form': Form,
    'term-index': Term,
  },
  data() {
    return {
      page: {
        form: false,
        term: false,
      },
      editInfo: {},
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
    openForm: function() {
      this.page.form = true
      this.page.term = false
    },
    goToForm: function() {
      this.openForm()
      this.clearEditInfo()
    },
    goToTerm: function() {
      this.page.form = false
      this.page.term = true
    },
    editTerm: function(term) {
      this.editInfo = term
      this.openForm()
    },
    clearEditInfo: function() {
      this.editInfo = {}
    }
  }
}
</script>
