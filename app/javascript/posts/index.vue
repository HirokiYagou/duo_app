<template>
<div class="container">
  <post-form
    :form-active="isActives.formActive"
    :edit-info="editInfo"
    :reply-info="replyInfo"
    @close-form="closeForm"
    @do-post="doPost($event)"
  ></post-form>
  <img-modal
    :img-active="isActives.imgActive"
    :img-src="imgSrc"
    @close-form="closeForm"
  ></img-modal>

  <div class="columns">
    <div class="column is-one-fifth left-menu">
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
          v-if="showUser.name.length"
          :profile-active="isActives.profileActive"
          :current_user="currentUser"
          :show-user="showUser"
          @do-edit-profile="editProfile"
          @update-profile="updateProfile($event)"
          @close-form="closeForm"
        ></post-header>
      </div>
      <div v-for="(post, index) in templatePosts" :key="post.id" :data-id="post.id" class="card">
        <post
          :post="post"
          :current_user_name="currentUser.name"
          :menu_bar="assets.menu_bar"
          @delete-post="deletePost($event, index)"
          @edit-post="editPost($event, index)"
          @open-img-modal="openImgModal($event)"
          @set-user-posts="setUserPosts($event)"
          @do-reply="doReply($event)"
          @show-post="showPost($event)"
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
      assets: {},
      
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
        name: '',
        showProfile: {},
      },

      replyInfo: {
        reply_to: undefined,
      }
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
          this.assets = data.assets
          this.showUser = {name: ''}
          this.showUser.showProfile = {}
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
    deletePost: function(post_id, index) {
      window.alert("Are you sure to DELETE?")

      fetch(`/posts/${post_id}`, {
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
      this.showUser.id = user.id
      this.showUser.name = user.name
      this.showUser.showProfile.nickname = user.profile.nickname
      this.fetchProfile(user.id)
    },
    doReply: function(post_id) {
      this.replyInfo.reply_to = post_id
      this.openForm()
    },
    showPost: function(post) {
      post.isShow = true
      const array = []
      array.push(post)
      const replyPost = this.allPosts.filter(onePost => onePost.reply_to === post.id)
      this.templatePosts = array.concat(replyPost)
    },
    fetchProfile: function(userId) {
      fetch(`/posts/user/${userId}`)
        .then(response => {
          return response.json()
        })
        .then(data => {
          this.showUser.showProfile.status = data.status
          if (data.header) {
            this.showUser.showProfile.header = data.header
          }
        })
        .catch(error => {
          console.log(error)
        })
    },
    updateProfile: function(formData) {
      fetch(`/posts/user/${this.currentUser.id}`, {
        method: 'PATCH',
          headers: {
            'X-CSRF-Token': csrfToken(),
          },
          body: formData,
        })
        
      this.closeForm()
      this.fetchPosts()
      // this.setUserPosts(this.currentUser)
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
  created: function() {
    this.fetchPosts()
  },
}
</script>

<style scoped>
.card {
  overflow: visible;
}
</style>
