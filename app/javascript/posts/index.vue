<template>
<div class="container">
  <div class="columns">
    <div class="column is-one-fifth">
      <button class="button is-primary is-fullwidth" @click="openForm">投稿する</button>
    </div>
    <div class="column is-half">
      <posts
        :posts="posts"
      ></posts>
    </div>
  </div>

  <post-form
    :is-Active="isActive"
    @close-form="closeForm"
    @create-post="createPost($event)"
  ></post-form>
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
  // watch: {
  //   post: {
  //     handler: function(next) {
  //       this.post = this.posts.unshift(next)
  //     },
  //     deep: true
  //   }
  // },
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

