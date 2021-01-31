<template>
<article :class="['accordion', 'is-primary', { 'is-active': isActive }]">
  <div class="accordion-header toggle" @click="doIsActive">
    <p>LESSON{{ lesson }}</p>
    <div>
      <p v-show="!isActive">+</p>
      <p v-show="isActive">-</p>
    </div>
  </div>
  <div class="accordion-body">
    <div class="accordion-content">
      <div
        v-for="sentence in sentences"
        :key="sentence.term_id"
      >
        <sentence
          :sentence="sentence"
        ></sentence>
      </div>
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
    lesson: Number
  },
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
        this.fetchTerms()
      }
    },
    fetchTerms: function() {
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