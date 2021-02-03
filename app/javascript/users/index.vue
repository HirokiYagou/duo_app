<template>
<div>
  <nav class="navbar">
    <div class="container">
      <div id="navMenu" class="navbar-menu">
        <div class="navbar-start">
          <a class="navbar-item">
            Home
          </a>
          <a class="navbar-item">
            Documentation
          </a>
        </div>

        <div class="navbar-end">
          <div class="navbar-item">
            <div class="buttons">
              <a class="button is-dark">SignOut</a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </nav>

  <section class="hero is-primary">
    <div class="hero-body">
      <div>
        <a class="title" @click="goToPost">POST</a>
      </div>
      <p class="subtitle">
        POST subtitle
      </p>
    </div>
  </section>

  <section class="hero is-link">
    <div class="hero-body">
      <div>
        <a class="title" @click="goToExercise">EXERCISE</a>
      </div>
      <p class="subtitle">
        EXERCISE subtitle
      </p>
    </div>
  </section>
</div>
</template>

<script>
export default {
  methods: {
    goToPost: function() {
      window.location.href = '/posts'
    },
    goToExercise: function() {
      window.location.href = '/exercises'
    },
  }
}
</script>

<style scoped>
.hero {
  height: 45vh;
}
.navbar {
  height: 10vh;
}
</style>