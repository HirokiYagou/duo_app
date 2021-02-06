<template>
<div>
  <nav class="navbar is-fixed-top">
    <div class="container">
      <div id="navMenu" class="navbar-menu">
        <div class="navbar-start">
          <h1 class="navbar-item title is-1">DUO3.0</h1>
          <a class="navbar-item" @click="goToPost">
            POST
          </a>
          <a class="navbar-item" @click="goToExercise">
            EXERCISE
          </a>
        </div>

        <div class="navbar-end">
          <p class="navbar-item">ROONEY</p>
          <div class="navbar-item">
            <div class="buttons">
              <a class="button is-ghost is-large" href="/users/sign_out" data-method="delete">SignOut</a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </nav>
  <section class="navbar-back">navbar-back</section>

  <section class="hero is-light is-large">
    <div class="hero-body">
      <p class="title is-1 has-text-centered">Enjoy Yourself with DUO3.0!!</p>
    </div>
  </section>

  <div class="container is-policy">
    <h3 class="title is-3 has-text-centered">このアプリが目指すこと</h3>
    <p class="is-size-4 has-text-centered">英語学習者の次の課題を解決します</p>
    <div class="columns is-problems">
      <div class="column is-half">
        <div class="images columns is-centered">
          <div class="column is-half">
            <img src="/assets/study.png" alt="">
          </div>
        </div>
        <h4 class="title is-4 has-text-centered">学習が思うように進まない</h4>
        <p class="is-size-5">
          たまプラーザ
        </p>
      </div>
      <div class="column is-half">
        <div class="images columns is-centered">
          <div class="column is-half">
            <img src="/assets/fukei_mura_kaso.png" alt="">
          </div>
        </div>
        <h4 class="title is-4 has-text-centered">均等な学習機会が得られない</h4>
        <p class="is-size-5">
          たまプラーザ
        </p>
      </div>
    </div>
  </div>

  <div class="container is-love">
    <h3 class="title is-3 has-text-centered">DUOを心から愛しています</h3>
    <p class="is-size-4">
      みなさんも薄々気づいているでしょう。<br>
      英語学習において単語力がそのまま英語能力に結びつくことに。<br>
      それなら
    </p>
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
.navbar-start h1 {
  height: 100%;
  margin-bottom: 0;
}
.navbar-back {
  height: 10vh;
}

.is-policy,
.is-love {
  margin-top: 10vh;
}
.is-problems {
  margin-top: 25px;
}
.is-problems .images {
  height: 30vh;
}
.top-hero {
  height: 80vh;
}
</style>