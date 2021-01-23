<template>
<div :class="['modal', {'is-active': imgActive}]">
  <div class="modal-background" @click.self="doCloseForm"></div>
  <div class="modal-content">
      <img :src="imgSrc" alt="">
  </div>
  <button class="modal-close is-large" aria-label="close" @click.self="doCloseForm"></button>
</div>
</template>

<script>
export default {
  props: {
    imgActive: Boolean,
    imgSrc: String,
  },
  methods: {
    doCloseForm: function() {
      this.$emit("close-form")
    },
  }
}
</script>

<style scoped>
.modal-content {
  width: 100vh;
  max-height: 100vh;
}
.modal-content img {
  max-width: 100%;
  max-height: 100%;
}
</style>