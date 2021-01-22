<template>
<div>
  <button class="button is-primary" @click="openForm">投稿する</button>
  
  <post-form
    :is-Active="isActive"
    @close-form="closeForm"
  ></post-form>
</div>
</template>

<script>
import Form from './form'

export default {
  components: {
    'post-form': Form,
  },
  data() {
    return {
      message: 'たまプラーザ',
      isActive: '',
    }
  },
  methods: {
      openForm: function() {
      this.isActive = 'is-active'
    },
    closeForm: function() {
      this.isActive = ''
    },
  }
}
</script>

