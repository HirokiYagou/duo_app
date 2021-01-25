<template>
<div class="container">
  <h1 class="title is-1">Admin画面</h1>
  <button class="button" @click="goToHome">ホームに戻る</button>

  <form @submit.prevent="createTerm">
    <div class="field">
      <label class="label">ENGLISH</label>
      <textarea v-model="term.english" class="textarea is-medium" name="english" cols="30" rows="5" placeholder="in english" required></textarea>
    </div>
    <div class="field">
      <label class="label">JAPANESE</label>
      <textarea v-model="term.japanese" class="textarea is-medium" name="japanese" cols="30" rows="5" placeholder="in japanene" required></textarea>
    </div>
    <div class="field">
      <label class="label">NUMBER</label>
      <input v-model="term.each_id" class="input" name="each_id" type="text" placeholder="each number" required>
    </div>
    <div class="field">
      <div class="control">
        <label class="radio">
          <input v-model="term.term_type" type="radio" id="0" value='0' name="term_type">
          Sentence
        </label>
        <label class="radio">
          <input v-model="term.term_type" type="radio" id="1" value="1" name="term_type" checked>
          Word
        </label>
      </div>
    </div>
    <div class="field">
      <label class="label">Lesson</label>
      <div class="select">
        <select v-model="term.lesson">
          <option>1</option>
          <option>2</option>
        </select>
      </div>
    </div>
    <button type="submit" class="button is-primary">登録する</button>
  </form>
</div>
</template>

<script>
import { csrfToken } from "@rails/ujs"

export default {
  data() {
    return {
      term: {
        english: '',
        japanese: '',
        each_id: '',
        term_type: '1',
        lesson: '1',
      },
    }
  },
  methods: {
    goToHome: function() {
      window.location.href = '/posts'
    },
    createTerm: function() {
      const sendData = { term: this.term }
      fetch('/admin/terms', {
          method: 'POST',
          headers: {
              'X-CSRF-Token': csrfToken(),
              'Content-Type': 'application/json',
            },
            body: JSON.stringify(sendData),
        })
    }
  }
}
</script>

<style scoped>
.textarea {
  resize: none;
}
</style>