<template>
<div>
  <div class="columns" @click="doIsActive">
    <div class="column is-1 sentence-id">
      {{ sentence.sentence_id }}
      <p v-show="!isActive">+</p>
      <p v-show="isActive">-</p>
    </div>
    <div class="column is-5">{{ sentence.english }}</div>
    <div class="column is-6">{{ sentence.japanese }}</div>
  </div>
  <word
    v-for="word in sentence.words"
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
  emits: [
    'sort-words',
  ],
  data() {
    return {
      isActive: false,
    }
  },
  methods: {
    doIsActive: function() {
      this.isActive = !this.isActive
      if (!this.sentence.words) {
        this.fetchWords()
      }
    },
    fetchWords: function() {
      fetch(`/exercises/${this.lesson}/word`)
        .then(response => {
          return response.json()
        })
        .then(data => {
          this.$emit('sort-words', data)
          this.sentence.words = data.filter(datum => datum.sentence_id === this.sentence.sentence_id)
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
  cursor: pointer;
}
.sentence-id {
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}
</style>