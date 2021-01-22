<template>
<div>
  <button class="button is-primary" @click="openForm">投稿する</button>
  
  <post-form
    :is-Active="isActive"
    @close-form="closeForm"
    @create-post="createPost($event)"
  ></post-form>

  <posts
    :posts="posts"
  ></posts>
</div>
</template>

<script>
import Form from './form'
import Posts from './posts'
import { csrfToken } from "@rails/ujs"

export default {
  components: {
    'post-form': Form,
    'posts': Posts,
  },
  data() {
    return {
      isActive: '',
      posts: [],
      post: {},
    }
  },
  methods: {
    fetchPosts: function() {
      fetch('/posts.json')
        .then(response => {
          return response.json()
        })
        .then(data => {
          this.posts = data
        })
        .catch(error => {
          console.log(error)
        })
    },
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
  },
  mounted: function() {
    this.fetchPosts()
  }
}
</script>

