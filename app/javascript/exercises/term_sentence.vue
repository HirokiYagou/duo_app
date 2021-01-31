<template>
<div>
  <div class="columns" @click="doIsActive">
    <div class="column is-1">{{ sentence.sentence_id }}</div>
    <div class="column is-5">{{ sentence.english }}</div>
    <div class="column is-6">{{ sentence.japanese }}</div>
  </div>
  <word
    v-for="word in words"
    :key="word.term_id"
    :word="word"
    v-show="isActive"
  ></word>
</div>
</template>

<script>
import Word from './term_word'

export default {
  components: {
    'word': Word,
  },
  props: {
    sentence: Object,
    lesson: Number
  },
  data() {
    return {
      isActive: false,
      words: []
    }
  },
  methods: {
    doIsActive: function() {
      this.isActive = !this.isActive
      if (!this.words.length) {
        this.fetchWords()
      }
    },
    fetchWords: function() {
      fetch(`/exercises/${this.lesson}/word`)
        .then(response => {
          return response.json()
        })
        .then(data => {
          this.words = data
        })
        .catch(error => {
          console.log(error)
        })
    }
  }
}
</script>

<style scoped>
.columns {
  border-bottom: 1px solid black;
}
.column {
  white-space: pre-wrap;
  word-wrap: break-word;
  padding-left: 0;
}
</style>