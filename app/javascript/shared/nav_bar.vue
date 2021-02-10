<template>
<div class="nav-bar-template">
  <div class="box pointer" @click="goToRoot">
    <div class="content has-text-centered">
      <h1 class="title is-1">MyDUO</h1>
    </div>
  </div>
  <a class="button is-light is-fullwidth" href="/users/sign_out" data-method="delete">SignOut</a>
  <button class="button is-light is-fullwidth" @click="doSetUser">@{{ currentUserName }}</button>
  <button class="button is-light is-fullwidth is-info" @click="goToExercises">Go EXERCISE</button>
  <button class="button is-fullwidth is-light is-primary" @click="goToPost">Go POST</button>
</div>
</template>

<script>
export default {
  props: {
    currentUserName: String,
  },
  emits: [
    'do-set-user'
  ],
  methods: {
    goToRoot: function() {
      window.location.href = '/'
    },
    goToExercises: function() {
      window.location.href = '/exercises'
    },
    goToPost: function() {
      window.location.href = '/posts'
    },
    doSetUser: function() {
      this.$emit('do-set-user')
    }
  }
}
</script>

<style scoped>
.pointer {
  cursor: pointer;
}
.nav-bar-template {
  margin-bottom: 20px;
}
</style>