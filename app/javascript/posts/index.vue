<template>
<div class="container">
  <post-form
    :form-active="isActives.formActive"
    :edit-info="editInfo"
    @close-form="closeForm"
    @do-post="doPost($event)"
  ></post-form>
  <img-modal
    :img-active="isActives.imgActive"
    :img-src="imgSrc"
    @close-form="closeForm"
  ></img-modal>

  <div class="columns">
    <div class="column is-one-fifth">
      <a href="/users/sign_out" data-method="delete">ログアウト</a>
      <p>{{ currentuser.name }}</p>
      <button class="button is-primary is-fullwidth" @click="openForm">投稿する</button>
    </div>
    <div class="column is-half">
      <div v-for="(post, index) in posts" :key="post.id" :data-id="post.id" class="card">
        <post
          :post="post"
          :current_user_name="currentuser.name"
          @delete-post="deletePost($event, index)"
          @edit-post="editPost($event, index)"
          @open-img-modal="openImgModal($event)"
        ></post>
      </div>
    </div>
  </div>
</div>
</template>

<script>
import Form from './form'
import Image from './img_modal'
import Post from './post'
import { csrfToken } from "@rails/ujs"

export default {
  components: {
    'post-form': Form,
    'img-modal': Image,
    'post': Post
  },
  data() {
    return {
      currentuser: {},
      posts: [],
      post: {},
      
      isActives: {
        formActive: false,
        imgActive: false,
      },
      imgSrc: '',
      
      editInfo: {
        editPost: {
          id: undefined,
        },
        editIndex: undefined,
      },
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
    doPost: function(formData) {
      const editId = this.editInfo.editPost.id
      const path = editId ? `/posts/${editId}` : '/posts'
      const method = editId ? 'PATCH' : 'POST'
      fetch(path, {
          method: method,
          headers: {
            'X-CSRF-Token': csrfToken(),
          },
          body: formData,
        })
        .then(response => {
          return response.json()
        })
        .then(data => {
          if (editId) {
            this.posts.splice(this.editInfo.editIndex, 1, data)
          } else {
            this.post = data
          }
            this.closeForm()
        })
        .catch(error => console.log(error))
    },
    deletePost: function(post, index) {
      window.alert("Are you sure to DELETE?")

      fetch(`/posts/${post.id}`, {
        method: 'DELETE',
        headers: {
          'X-CSRF-Token': csrfToken(),
        }
      })

      this.posts.splice(index, 1)
    },
    editPost: function(post, index) {
      this.editInfo = {
        editPost: post,
        editIndex: index,
      }
      this.openForm()
    },
    openForm: function() {
      this.isActives.formActive = true
    },
    openImgModal: function(img) {
      this.isActives.imgActive = true
      this.imgSrc =img
    },
    closeForm: function() {
      this.isActives.formActive = false
      this.isActives.imgActive = false
      this.editInfo = {
        editPost: {
          id: undefined,
        },
        editIndex: undefined,
      }
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