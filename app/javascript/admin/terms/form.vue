<template>
<form @submit.prevent="doCreateTerm">
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
</template>

<script>
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
    doCreateTerm: function() {
      this.$emit('create-term', this.term)
    }
  }
}
</script>