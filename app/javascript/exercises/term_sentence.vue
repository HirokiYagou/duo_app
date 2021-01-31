<template>
<div>
  <div class="columns" @click="doIsActive" @contextmenu.prevent="onContextMenu">
    <div class="column is-1 sentence-id">
      {{ sentence.sentence_id }}
      <p v-show="!isActive">+</p>
      <p v-show="isActive">-</p>
    </div>
    <div class="column is-5">{{ sentence.english }}</div>
    <div class="column is-6">{{ sentence.japanese }}</div>
  </div>
  <div v-show="isActiveMenu" @click="editTerm(sentence)">
    <p>登録文章編集</p>
  </div>
  <word
    v-for="word in sentence.words"
    :key="word.term_id"
    :current-user="currentUser"
    :word="word"
    v-show="isActive"
    @edit-term="editTerm($event)"
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
    currentUser: String,
    sentence: Object,
    lesson: Number
  },
  emits: [
    'sort-words',
    'edit-term',
  ],
  data() {
    return {
      isActive: false,
      isActiveMenu: false,
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
    },
    onContextMenu: function() {
      if (this.currentUser === 'admin') {
        this.isActiveMenu = !this.isActiveMenu
      }
    },
    editTerm: function(term) {
      if (this.currentUser === 'admin') {
        this.$emit('edit-term', term)
      }
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