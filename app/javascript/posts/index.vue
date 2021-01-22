<template>
<div>
  <button class="button" @click="onClick">投稿する</button>
  
  <div :class="['modal', isActive]">
    <div class="modal-background"></div>
    <div class="modal-content">
      <div class="columns is-mobile is-centered">
        <div class="column is-half">
          <p>{{ message }}</p>
        </div>
      </div>
    </div>
    <button class="modal-close is-large" aria-label="close"></button>
  </div>
</div>
</template>

<script>
export default {
  data() {
    return {
      message: 'たまプラーザ',
      isActive: '',
    }
  },
  methods: {
    onClick: function() {
      this.isActive = 'is-active'
    },
  },
}
</script>
