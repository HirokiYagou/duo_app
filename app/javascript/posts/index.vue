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
        :current-user-name="currentUser.name"
        :search-info-params="searchInfoParams"
        :search-terms-by-tag="searchTermsByTag"
        @do-open-form="openForm"
        @do-fetch-posts="fetchPosts"
        @do-set-user-posts="fetchProfile(currentUser)"
        @search-complex="searchComplex($event)"
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
          @set-user-posts="fetchProfile($event)"
          @set-favorite-posts="setFavoritePosts($event)"
        ></post-header>
      </div>
      <div
        v-for="(post, index) in templatePosts"
        :key="post.id"
        :data-id="post.id"
        :class="['card', { 'is-show-card': post.id === showPostId }]">
        <post
          :post="post"
          :current_user_name="currentUser.name"
          :menu_bar="assets.menu_bar"
          :show-post-id="showPostId"
          @delete-post="deletePost($event, index)"
          @edit-post="editPost($event, index)"
          @open-img-modal="openImgModal($event)"
          @set-user-posts="fetchProfile($event)"
          @do-reply="doReply($event)"
          @show-post="showPost($event)"
          @search-complex="searchComplex($event)"
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
      },
      showProfile: {},

      replyInfo: {
        reply_to: undefined,
      },

      showPostId: undefined,

      searchInfoParams: false,
      searchTermsByTag: ''
    }
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
          this.showProfile = {}
          this.showPostId = undefined
          this.searchInfoParams = !this.searchInfoParams
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
            this.allPosts.unshift(data)
            this.templatePosts = this.allPosts
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
      this.showPostId = undefined
      this.searchInfoParams = !this.searchInfoParams
      this.templatePosts = this.allPosts.filter(post => post.user.id === user.id)
      this.showUser.id = user.id
      this.showUser.name = user.name
      this.showUser.showProfile = this.showProfile
    },
    doReply: function(post_id) {
      this.replyInfo.reply_to = post_id
      this.openForm()
    },
    showPost: function(post) {
      this.showUser = {name: ''}
      this.searchInfoParams = !this.searchInfoParams
      this.showPostId = post.id
      const array = []
      array.push(post)
      const repliedPost = this.allPosts.filter(onePost => onePost.id === post.reply_to)
      const replyPost = []
      this.allPosts.forEach(onePost => {
        if(onePost.reply_to === post.id) {replyPost.unshift(onePost)}
        })
      this.templatePosts = repliedPost.concat(array.concat(replyPost))
    },
    fetchProfile: function(user) {
      fetch(`/users/${user.id}/profile`)
        .then(response => {
          return response.json()
        })
        .then(data => {
          this.showProfile.nickname = data.nickname
          this.showProfile.status = data.status
          if (data.header) {
            this.showProfile.header = data.header
          }
          this.setUserPosts(user)
        })
        .catch(error => {
          console.log(error)
        })
    },
    updateProfile: function(formData) {
      fetch(`/users/${this.currentUser.id}/profile/`, {
        method: 'PATCH',
          headers: {
            'X-CSRF-Token': csrfToken(),
          },
          body: formData,
        })
        
      this.closeForm()
      this.fetchPosts()
    },
    setFavoritePosts: function(user) {
      fetch(`/favorites/${user.id}`)
        .then(response => {
          return response.json()
        })
        .then(data => {
          this.templatePosts = []
          if (data.post_ids.length !== 0) {
            data.post_ids.forEach(post_id => {
              const result = this.allPosts.find(post => post.id === post_id)
              this.templatePosts.push(result)
            })
          }
        })
        .catch(error => {
          console.log(error)
        })
    },
    searchComplex: function(params) {
      this.showUser = {name: ''}
      this.showPostId = undefined
      let searchPosts = this.allPosts
      searchPosts = this.allPosts.filter(post => post.content.toLowerCase().includes(params.content))
      searchPosts.forEach((post, index) => {
        const postTerm = post.terms.filter(term => term.english === params.term)
        if (postTerm.length === 0) {
          searchPosts.splice(index, 1, 0)
        }
      })
      searchPosts = searchPosts.filter(post => post !== 0)
      searchPosts = searchPosts.filter(post => post.user.name.includes(params.username))
      this.templatePosts = searchPosts
      this.searchTermsByTag = params.term
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
.is-show-card {
  border: 1px solid blue;
}
.card {
  overflow: visible;
}
</style>
