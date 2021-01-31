<template>
<div class="left-bar-wrapper">
  <nav-bar
    :current-user-name="currentUserName"
    @do-set-user="doSetUserPosts"
  ></nav-bar>
  <button class="button is-light is-primary is-fullwidth" @click="doFetchPosts">HOME</button>
  <button class="button is-primary is-fullwidth" @click="doOpenForm">NEW POST</button>
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
    'do-set-user-posts'
  ],
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
    }
  }
}
</script>

<style scoped>
.button {
  border: none;
}
</style>