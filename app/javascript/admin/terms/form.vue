<template>
<form @submit.prevent="createEditTerm">
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
        <option>43</option>
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
  props: {
    editInfo: {
      type: Object,
      default: {
        english: '',
        japanese: '',
        lesson: undefined,
        sentence_id: undefined,
        term_id: undefined,
        word_id: undefined,
      },
    },
  },
  emits: [
    'done-edit',
  ],
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
  watch: {
    editInfo: {
      handler: function(next) {
        this.term.english = next.english
        this.term.japanese = next.japanese
        this.term.sentence_id = next.sentence_id
        this.term.word_id = next.word_id
        this.term.lesson = next.lesson
      },
      deep: true,
      immediate: true,
    }
  },
  methods: {
    createEditTerm: function() {
      const editId = this.editInfo.term_id
      const path = editId ? `/admin/terms/${editId}` : '/admin/terms'
      const method = editId ? 'PATCH' : 'POST'
      const sendData = { term: this.term }
      fetch(path, {
          method: method,
          headers: {
              'X-CSRF-Token': csrfToken(),
              'Content-Type': 'application/json',
            },
            body: JSON.stringify(sendData),
        })

      this.$emit('done-edit')
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
