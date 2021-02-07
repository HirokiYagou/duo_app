<template>
<section class="section">
  <h4 class="title is-4">単語帳の完成形</h4>
  <p class="is-size-5">
    学習していて楽しい<br>
    効率の良い学習ができる<br>
    使い方は無限大！<br>
    そんなDUOの魅力をお伝えします
  </p>
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
  height: 30vh;
}
</style>