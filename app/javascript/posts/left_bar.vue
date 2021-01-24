<template>
<div class="left-bar-wrapper">
  <a class="button is-fullwidth" href="/users/sign_out" data-method="delete">ログアウト</a>
  <button class="button is-fullwidth" @click="doSetUserPosts">{{ current_user_name }}</button>
  <button class="button is-primary is-fullwidth" @click="doOpenForm">投稿する</button>
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
    doSetUserPosts: function() {
      this.$emit("do-set-user-posts")
    }
  }
}
</script>

<style scoped>
/* .left-bar-wrapper {
  position: fixed;
} */
</style>