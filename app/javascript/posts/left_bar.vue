<template>
<div class="left-bar-wrapper">
  <nav-bar
    :current-user-name="currentUserName"
    @do-set-user="doSetUserPosts"
  ></nav-bar>
  <button class="button is-light is-primary is-fullwidth" @click="doFetchPosts">HOME</button>
  <button class="button is-primary is-fullwidth new-post" @click="doOpenForm">NEW POST</button>

  <search-area
    :search-info-params="searchInfoParams"
    @search-complex="searchComplex($event)"
  ></search-area>
</div>
</template>

<script>
import nav_barVue from '../shared/nav_bar.vue'
import searchVue from './search.vue'

export default {
  components: {
    'nav-bar': nav_barVue,
    'search-area': searchVue
  },
  props: {
    currentUserName: String,
    searchInfoParams: Boolean,
  },
  emits: [
    'do-open-form',
    'do-fetch-posts',
    'do-set-user-posts',
    'search-complex'
  ],
  data() {
    return {
      
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
    searchComplex: function(params) {
      this.$emit('search-complex', params)
    }
  }
}
</script>

<style scoped>
.button {
  border: none;
}
.new-post {
  margin-bottom: 20px;
}
</style>