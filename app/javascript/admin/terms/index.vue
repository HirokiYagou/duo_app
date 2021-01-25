<template>
<div class="container">
  <h1 class="title is-1">Admin画面</h1>
  <button class="button" @click="goToHome">ホームに戻る</button>

  <create-form
    @create-term="createTerm($event)"
  ></create-form>
</div>
</template>

<script>
import Form from './form'
import { csrfToken } from "@rails/ujs"

export default {
  components: {
    'create-form': Form,
  },
  methods: {
    goToHome: function() {
      window.location.href = '/posts'
    },
    createTerm: function(newTerm) {
      const sendData = { term: newTerm }
      fetch('/admin/terms', {
          method: 'POST',
          headers: {
              'X-CSRF-Token': csrfToken(),
              'Content-Type': 'application/json',
            },
            body: JSON.stringify(sendData),
        })

      this.term.english = ''
      this.term.japanese = ''
      this.term.each_id = ''
      this.term.term_type = '1'
      this.term.lesson = '1'
    }
  }
}
</script>

<style scoped>
.textarea {
  resize: none;
}
</style>