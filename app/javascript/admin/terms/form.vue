<template>
<form @submit.prevent="createTerm">
  <div class="field">
    <label class="label">ENGLISH</label>
    <textarea v-model="term.english" class="textarea is-medium" name="english" cols="30" rows="5" placeholder="in english" required></textarea>
  </div>
  <div class="field">
    <label class="label">JAPANESE</label>
    <textarea v-model="term.japanese" class="textarea is-medium" name="japanese" cols="30" rows="5" placeholder="in japanene" required></textarea>
  </div>
  <div class="columns feild">
    <div class="column">
      <label class="label">SENTENCE Number</label>
      <input v-model="term.sentence_id" class="input" name="sentence_id" type="text" placeholder="sentence number" required>
    </div>
    <div class="column">
      <label class="label">WORD Number</label>
      <input v-model="term.word_id" class="input" name="word_id" type="text" placeholder="fill with '0', if registrate sentence" required>
    </div>
  </div>
  <div class="field">
    <label class="label">Lesson</label>
    <div class="select">
      <select v-model="term.lesson">
        <option>1</option>
        <option>2</option>
        <option>44</option>
      </select>
    </div>
  </div>
  <button type="submit" class="button is-primary">登録する</button>
</form>
</template>

<script>
import { csrfToken } from "@rails/ujs"

export default {
  data() {
    return {
      term: {
        english: '',
        japanese: '',
        sentence_id: '',
        word_id: '',
        lesson: '1',
      },
    }
  },
  methods: {
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

      this.term.english = ''
      this.term.japanese = ''
      this.term.sentence_id = ''
      this.term.word_id = ''
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
