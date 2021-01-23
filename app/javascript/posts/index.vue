<template>
<div class="container">
  <div class="columns">
    <div class="column is-one-fifth">
      <a href="/users/sign_out" data-method="delete">ログアウト</a>
      <p>{{ currentuser.name }}</p>
      <button class="button is-primary is-fullwidth" @click="openForm">投稿する</button>
    </div>
    <div class="column is-half">
      <div v-for="post in posts" :key="post.id" :data-id="post.id" class="card">
        <post
          :post="post"
          :current_user_name="currentuser.name"
          @delete-post="deletePost($event)"
        ></post>
      </div>
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
import Post from './post'
import { csrfToken } from "@rails/ujs"

export default {
  components: {
    'post-form': Form,
    'post': Post,
  },
  data() {
    return {
      isActive: '',
      posts: [],
      post: {},
      currentuser: {},
    }
  },
  watch: {
    post: {
      handler: function(next) {
        this.posts.unshift(next)
      },
      deep: true
    },
  },
  methods: {
    fetchPosts: function() {
      fetch('/posts.json')
        .then(response => {
          return response.json()
        })
        .then(data => {
          this.posts = data.posts
          this.currentuser = data.currentuser
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
    deletePost: function(post) {
      fetch(`/posts/${post.id}`, {
        method: 'DELETE',
        headers: {
          'X-CSRF-Token': csrfToken(),
        }
      })
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

<style scoped>
.card {
  overflow: visible;
}
</style>