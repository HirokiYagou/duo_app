<template>
<article :class="['accordion', 'is-info', { 'is-active': isActive }]">
  <div class="accordion-header toggle" @click="doIsActive">
    <p>LESSON{{ lesson }}</p>
    <div>
      <p v-show="!isActive">+</p>
      <p v-show="isActive">-</p>
    </div>
  </div>
  <div class="accordion-body is-info">
    <div class="accordion-content">
      <sentence
        v-for="sentence in sentences"
        :key="sentence.term_id"
        :current-user="currentUser"
        :sentence="sentence"
        :lesson="lesson"
        @sort-words="sortWords($event)"
        @edit-term="editTerm($event)"
      ></sentence>
    </div>
  </div>
</article>
</template>

<script>
import Sentence from './term_sentence'

export default {
  components: {
    'sentence': Sentence,
  },
  props: {
    currentUser: String,
    lesson: Number
  },
  emits: [
    'edit-term',
  ],
  data() {
    return {
      isActive: false,
      sentences: [],
    }
  },
  methods: {
    doIsActive: function() {
      this.isActive = !this.isActive
      if (!this.sentences.length) {
        this.fetchSentences()
      }
    },
    fetchSentences: function() {
      fetch(`/exercises/${this.lesson}/sentence`)
        .then(response => {
          return response.json()
        })
        .then(data => {
          this.sentences = data
        })
        .catch(error => {
          console.log(error)
        })
    },
    sortWords: function(words) {
      for (let i = 0; i < this.sentences.length; i++) {
        this.sentences[i].words = words.filter(word => word.sentence_id === this.sentences[i].sentence_id)
      }
    },
    editTerm: function(term) {
      this.$emit('edit-term', term)
    }
  }
}
</script>

<style scoped>
.accordion-header {
  display: flex;
  justify-content: space-between;
}
</style>