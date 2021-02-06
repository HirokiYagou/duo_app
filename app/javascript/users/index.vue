<template>
<div>
  <nav class="navbar is-fixed-top">
    <div class="container">
      <div id="navMenu" class="navbar-menu">
        <div class="navbar-start">
          <img src="/assets/duo3.jpg" alt="" class="navbar-item">
          <a class="navbar-item" @click="goToPost">
            POST
          </a>
          <a class="navbar-item" @click="goToExercise">
            EXERCISE
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
  <section class="navbar-back">navbar-back</section>

  <section class="hero is-light is-large">
    <div class="hero-body">
      <p class="title has-text-centered">Enjoy Yourself with DUO3.0!!</p>
    </div>
  </section>


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
import section from '../exercises/section.vue'
export default {
  components: { section },
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
.navbar {
  height: 10vh;
}
.navbar-back {
  height: 10vh;
}
.top-hero {
  height: 80vh;
}
</style>