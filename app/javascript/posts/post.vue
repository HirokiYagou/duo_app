<template>
<div class="card-content">
  <div class="media">
    <div class="media-left">
      <figure class="image is-48x48">
        <a @click="doSetUserPosts(post.user)">
          <img :src="post.user.profile.icon" alt="Placeholder image">
        </a>
      </figure>
    </div>
    <div class="media-content">
      <p class="title is-4" @click="doSetUserPosts(post.user)">{{ post.user.profile.nickname }}</p>
      <p class="subtitle is-6">
        <a class="right-margin" @click="doSetUserPosts(post.user)">@{{ post.user.name }}</a>
        <time :datetime="post.created_at">
          {{ new Date(post.created_at).getFullYear() }}/{{ new Date(post.created_at).getMonth() + 1 }}/{{ new Date(post.created_at).getDate() }}
          {{ new Date(post.created_at).getHours() }}:{{ new Date(post.created_at).getMinutes() }}
        </time>
      </p>
    </div>
    <div class="media-right">
      <div class="dropdown is-right is-hoverable" v-show="isCurrentUser">
        <div class="dropdown-trigger">
          <button class="button" aria-haspopup="true" aria-controls="dropdown-menu3">
            <span class="icon is-small">
              <img :src="menu_bar" alt="" id="menu-bar">
              <i class="fas fa-angle-down" aria-hidden="true"></i>
            </span>
          </button>
        </div>
        <div class="dropdown-menu" id="dropdown-menu3" role="menu">
          <div class="dropdown-content">
            <a @click="doEditPost(post)"  class="dropdown-item" id="edit">
              Edit
            </a>
            <hr class="dropdown-divider">
            <a @click="doDeletePost(post.id)" class="dropdown-item" id="delete">
              Delete
            </a>
          </div>
        </div>
      </div>
    </div>
  </div>

  <div :class="{ 'columns': !isShow }">
    <div class="content is-left-content is-medium column is-two-third" @click="doShowPost">
      <div class="post-content">
        <p :class="{'is-size-3': isShow }">{{ post.content }}</p>
      </div>
      <!-- <a>@bulmaio</a> -->
      <a 
        class="tag is-link is-light is-medium right-margin"
        @click="doSearchComplex(term.english)"
        v-for="term in post.terms"
        :key="term.id"
      >#{{ term.english }}</a>
    </div>
    <div :class="['block', 'column', { 'is-one-third': !isShow }]" v-if="post.image">
        <img @click="openImageModal(post.image)" :src="post.image" :class="{'is-fullwidth': isShow }" alt="Placeholder image">
    </div>
  </div>
</div>
<div class="card-footer">
  <div class="card-footer-item" @click="doReply(post.id)">
    <span><img src="/assets/reply.png" alt="reply"></span>
    <span v-if="post.replied_count !== 0">{{ post.replied_count }}</span>
  </div>
  <div :class="['card-footer-item', { 'is-favorite': post.is_favorite }]" @click="dofavorite(post.id)">
    <span class="heart">♡</span>
    <span v-if="post.favorite_count !== 0">{{ post.favorite_count }}</span>
  </div>
  <div class="card-footer-item"></div>
</div>
</template>

<script>
export default {
  props: {
    post: Object,
    current_user_name: String,
    menu_bar: String,
    showPostId: Number,
  },
  emits: [
    'delete-post',
    'edit-post',
    'open-img-modal',
    'set-user-posts',
    'do-reply',
    'show-post',
    'search-complex'
  ],
  data() {
    return {
      onTag: false,
    }
  },
  computed: {
    isCurrentUser: function() {
      return this.post.user.name === this.current_user_name
    },
    isShow: function() {
      return this.post.id === this.showPostId
    },
    linkedPostContent: function() {
      let str = this.post.content
      const array = str.match(/(#.*?)(?=\s)/g)
      if(str.includes('#')) {
        console.log(array)
        for(let i = 0; i < array.length; i++) {
          str = str.replace(array[i], array[i].replace('#','<a>').concat('</a>'))
        }
      }
      return str
    },
  },
  methods: {
    doDeletePost: function(post_id) {
      this.$emit("delete-post", post_id)
    },
    doEditPost: function(post) {
      this.$emit("edit-post", post)
    },
    openImageModal: function(img) {
      this.$emit("open-img-modal", img)
    },
    doSetUserPosts: function(user) {
      this.$emit("set-user-posts", user)
    },
    doReply: function(post_id) {
      this.$emit("do-reply", post_id)
    },
    doShowPost: function() {
      if (this.onTag) {
        this.onTag = false
      } else {
        this.$emit("show-post", this.post)
      }
    },
    dofavorite: function(post_id) {
      fetch(`/posts/${post_id}`)
        .then(response => {
          return response.json()
        })
        .then(data => {
          this.post.favorite_count = data.favorite_count
          if (this.post.is_favorite) {
            this.post.is_favorite = false
          } else {
            this.post.is_favorite = true
          }
        })
        .catch(error => {
          console.log(error)
        })
    },
    doSearchComplex: function(term) {
      this.onTag = true
      const params = { 
        content: '',
        term: term,
        username: ''
      }
      this.$emit('search-complex', params)
    }
  }
}
</script>

<style scoped>
.content> p {
  white-space: pre-wrap;
  word-wrap: break-word;
}
.media-left img {
  border-radius: 50%;
  border: 1px solid ghostwhite;
}
.card-footer> .is-favorite {
  background-color: rgba(255, 112, 96, 0.685);
}
.media-content> .title,
.is-left-content,
.card-footer-item {
  cursor: pointer;
}
.card-footer-item:hover {
  opacity: 0.5;
}
.dropdown button {
  border: none;
}
.columns img {
  max-height: 50vh;
  cursor: pointer;
}
.columns img:hover {
  opacity: 0.8;
}
.right-margin {
  margin-right: 10px;
}
</style>
