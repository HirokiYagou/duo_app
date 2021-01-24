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
        <a @click="doSetUserPosts(post.user)">@{{ post.user.name }}</a>
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
              <img src="/assets/bars_24.png" alt="">
              <i class="fas fa-angle-down" aria-hidden="true"></i>
            </span>
          </button>
        </div>
        <div class="dropdown-menu" id="dropdown-menu3" role="menu">
          <div class="dropdown-content">
            <a @click="doEditPost(post)"  class="dropdown-item">
              Edit
            </a>
            <hr class="dropdown-divider">
            <a @click="doDeletePost(post)" class="dropdown-item">
              Delete
            </a>
          </div>
        </div>
      </div>
    </div>
  </div>

  <div class="columns">
    <div class="content is-medium column is-two-third">
      <p>{{ post.content }}</p>
      <!-- <a>@bulmaio</a>.
      <a href="#">#css</a> <a href="#">#responsive</a> -->
    </div>
    <div class="block column is-one-third" v-if="post.image">
        <img @click="openImageModal(post.image)" :src="post.image" alt="Placeholder image">
    </div>
  </div>
</div>
</template>

<script>
export default {
  props: {
    post: Object,
    current_user_name: String,
  },
  computed: {
    isCurrentUser: function() {
      return this.post.user.name === this.current_user_name
    },
  },
  methods: {
    doDeletePost: function(post) {
      this.$emit("delete-post", post)
    },
    doEditPost: function(post) {
      this.$emit("edit-post", post)
    },
    openImageModal: function(img) {
      this.$emit("open-img-modal", img)
    },
    doSetUserPosts: function(user) {
      this.$emit("set-user-posts", user)
    }
  }
}
</script>

<style scoped>
.content> p {
  white-space: pre-wrap;
  word-wrap: break-word;
}
.media-content> .title {
  cursor: pointer;
}
.dropdown button {
  border: none;
}
.columns img {
  max-height: 50vh;
  cursor: pointer;
}
</style>