<template>
<div :class="['modal', { 'is-active': isModalActive }]">
  <div class="modal-background" @click.self="doCloseExplainModal"></div>
  <div class="modal-card">
    <header class="modal-card-head">
      <p class="modal-card-title">Modal title</p>
      <button class="delete" aria-label="close" @click="doCloseExplainModal"></button>
    </header>
    <section class="modal-card-body">
      <p>未実装</p>
    </section>
    <footer class="modal-card-foot">
      <button class="button">back</button>
      <button class="button">next</button>
    </footer>
  </div>
</div>
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
.modal-card-foot {
  display: flex;
  justify-content: space-between;
}
</style>