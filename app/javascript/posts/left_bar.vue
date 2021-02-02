<template>
<div class="left-bar-wrapper">
  <nav-bar
    :current-user-name="currentUserName"
    @do-set-user="doSetUserPosts"
  ></nav-bar>
  <button class="button is-light is-primary is-fullwidth" @click="doFetchPosts">HOME</button>
  <button class="button is-primary is-fullwidth" @click="doOpenForm">NEW POST</button>
  <form @submit.prevent="searchPostByInput">
    <input class="input is-normal" type="text" @keyup="searchTerm" v-model="searchInput" placeholder="search with keyword">
  </form>
  <div class="box" v-show="searchInput">
    <ul>
      <li
        v-for="(searchResult, index) in searchResults"
        :key="index"
        @click="searchPostByTerm(searchResult.english)"
        class="search-result"
      ><a>{{ searchResult.english }}</a></li>
    </ul>
  </div>
</div>
</template>

<script>
import nav_barVue from '../shared/nav_bar.vue'

export default {
  components: {
    'nav-bar': nav_barVue
  },
  props: {
    currentUserName: String,
  },
  emits: [
    'do-set-user-posts',
    'search-post-by-input'
  ],
  data() {
    return {
      searchInput: '',
      searchResults: [],
    }
  },
  methods: {
    doOpenForm: function() {
      this.$emit("do-open-form")
    },
    goToExercises: function() {
      window.location.href = '/exercises'
    },
    doFetchPosts: function() {
      this.$emit("do-fetch-posts")
    },
    doSetUserPosts: function() {
      this.$emit("do-set-user-posts")
    },
    searchTerm: function() {
      fetch(`posts/search/?keyword=${this.searchInput}`)
        .then(response => {
          return response.json()
        })
        .then(data => {
          this.searchResults = data
        })
        .catch(error => {
          console.log(error)
        })
    },
    searchPostByInput: function() {
      this.$emit('search-post-by-input', this.searchInput)
    }
  }
}
</script>

<style scoped>
.button {
  border: none;
}
form {
  margin-top: 20px;
}
.search-result {
  margin-bottom: 10px;
  border-bottom: 1px solid ghostwhite;
}
</style>