<template>
<div>
  <button class="button is-primary" @click="openForm">投稿する</button>
  
  <post-form
    :is-Active="isActive"
    @close-form="closeForm"
    @create-post="createPost($event)"
  ></post-form>
</div>
</template>

<script>
import Form from './form'
import { csrfToken } from "@rails/ujs"

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
    createPost: function(formData) {
      fetch('/posts', {
          method: 'POST',
          headers: {
            'X-CSRF-Token': csrfToken(),
          },
          body: formData,
        })
        .then(response => {
          return response.json()
        })
        .then(data => {
          this.post = data
          this.closeForm()
        })
        .catch(error => console.log(error))
    },
    openForm: function() {
      this.isActive = 'is-active'
    },
    closeForm: function() {
      this.isActive = ''
    },
  }
}
</script>

