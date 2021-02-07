<template>
<section class="section">
  <h1 class="title">Section</h1>
  <h2 class="subtitle">
    A simple container to divide your page into <strong>sections</strong>, like the one you're currently reading.
  </h2>
</section>
</template>

<script>
export default {
  props: {
    modalContent: String
  },
  emits: [
    'do-close-explain-modal'
  ],
  computed: {
    isModalActive: function() {
      if (this.modalContent) {
        return true
      } else {
        return false
      }
    }
  },
  methods: {
    doCloseExplainModal: function() {
      this.$emit('do-close-explain-modal')
    }
  }
}
</script>

<style scoped>
.section {
  border: 1px solid black;
}
</style>