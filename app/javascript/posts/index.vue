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

  <div class="columns left-menu">
    <div class="column is-one-fifth">
      <left-bar
        :current_user_name="currentUser.name"
        @do-open-form="openForm"
        @do-fetch-posts="fetchPosts"
        @do-set-user-posts="setUserPosts(currentUser)"
      ></left-bar>
    </div>
    <div class="column is-two-thirds">
      <div class="card">
        <post-header
          v-show="showUser.name.length"
          :profile-active="isActives.profileActive"
          :current_user="currentUser"
          :show-user="showUser"
          @do-edit-profile="editProfile"
          @close-form="closeForm"
        ></post-header>
      </div>
      <div v-for="(post, index) in templatePosts" :key="post.id" :data-id="post.id" class="card">
        <post
          :post="post"
          :current_user_name="currentUser.name"
          @delete-post="deletePost($event, index)"
          @edit-post="editPost($event, index)"
          @open-img-modal="openImgModal($event)"
          @set-user-posts="setUserPosts($event)"
        ></post>
      </div>
    </div>
  </div>
</div>
</template>

<script>
import LeftBar from './left_bar'
import Form from './form'
import Image from './img_modal'
import PostHeader from './post_header'
import Post from './post'
import { csrfToken } from "@rails/ujs"

export default {
  components: {
    'left-bar': LeftBar,
    'post-form': Form,
    'img-modal': Image,
    'post-header': PostHeader,
    'post': Post,
  },
  data() {
    return {
      currentUser: {},
      allPosts: [],
      templatePosts: [],
      post: {},
      
      isActives: {
        formActive: false,
        imgActive: false,
        profileActive: false,
      },
      imgSrc: '',
      
      editInfo: {
        editPost: {
          id: undefined,
        },
        editIndex: undefined,
      },

      showUser: {
        id: null,
        name: '',
        nickname: '',
      },
    }
  },
  watch: {
    post: {
      handler: function(next) {
        this.allPosts.unshift(next)
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
          this.allPosts = data.posts
          this.templatePosts = this.allPosts
          this.currentUser = data.currentuser
          this.showUser = {name: ''}
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
            this.allPosts.splice(this.editInfo.editIndex, 1, data)
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

      this.allPosts.splice(index, 1)
    },
    editPost: function(post, index) {
      this.editInfo = {
        editPost: post,
        editIndex: index,
      }
      this.openForm()
    },
    setUserPosts: function(user) {
      this.templatePosts = []
      this.allPosts.forEach(post => {
        if (post.user.id === user.id) {
          this.templatePosts.push(post)
        }
      })
      this.showUser = user
    },
    openForm: function() {
      this.isActives.formActive = true
    },
    openImgModal: function(img) {
      this.isActives.imgActive = true
      this.imgSrc =img
    },
    editProfile: function() {
      this.isActives.profileActive = true
    },
    closeForm: function() {
      this.isActives.formActive = false
      this.isActives.imgActive = false
      this.isActives.profileActive = false
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
  },
}
</script>

<style scoped>
.card {
  overflow: visible;
}
</style>
