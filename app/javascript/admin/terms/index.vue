<template>
<div class="container">
  <h1 class="title is-1">Admin画面</h1>
  <button class="button" @click="goToHome">ホームに戻る</button>

  <form @submit.prevent="createTerm">
    <div class="field">
      <label class="label">ENGLISH</label>
      <textarea v-model="newEnglish" class="textarea is-medium" name="english" type="text" placeholder="term in english" required></textarea>
    </div>
    <div class="field">
      <label class="label">JAPANESE</label>
      <textarea v-model="newJapanese" class="textarea is-medium" name="japanese" type="text" placeholder="term in japanene" required></textarea>
    </div>
    <div class="field">
      <div class="control">
        <label class="radio">
          <input type="radio" name="foobar">
          Sentence
        </label>
        <label class="radio">
          <input type="radio" name="foobar" checked>
          Word
        </label>
      </div>
    </div>
    <div class="field">
      <label class="label">Lesson</label>
      <div class="select">
        <select>
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
export default {
  data() {
    return {
      newEnglish: '',
      newJapanese: '',
    }
  },
  methods: {
    goToHome: function() {
      window.location.href = '/posts'
    }
  }
}
</script>