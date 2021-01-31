<template>
<div class="left-bar-wrapper">
  <a class="button is-light is-fullwidth" href="/users/sign_out" data-method="delete">ログアウト</a>
  <button class="button is-light is-fullwidth" @click="doSetUserPosts">@{{ current_user_name }}</button>
  <button class="button is-light is-fullwidth is-info" @click="goToExercises">学習ページ</button>
  <button class="button is-light is-primary is-fullwidth" @click="doFetchPosts">HOME</button>
  <button class="button is-primary is-fullwidth" @click="doOpenForm">NEW POST</button>
</div>
</template>

<script>
export default {
  props: {
    current_user_name: String,
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
    }
  }
}
</script>

<style scoped>
.button {
  border: none;
}
</style>