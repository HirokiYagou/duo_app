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
    <p class="is-size-4 has-text-centered">学習者の次の課題を解決します</p>
    <div class="columns is-problems">
      <div class="column is-half">
        <div class="images columns is-centered">
          <div class="column is-half">
            <img src="/assets/study.png" alt="">
          </div>
        </div>
        <h5 class="title is-5 has-text-centered">学習が思うように進まない</h5>
        <h5 class="title is-5 has-text-centered">↓</h5>
        <h4 class="title is-4 has-text-centered">熱意ではなく仕組みで解決</h4>
        <p class="is-size-5">
          こんな経験はありませんか？<br>
          「よし、やるぞ！」<br>
          意気込んでみても、熱意が続くのは三日だけ。<br>
          「やらなきゃなあ・・・」<br>
          そう思いつつ現実逃避。<br>
          <br>
          私は勉強や継続した努力、ちょっとした積み重ねを気持ちで続けようとすることに無理があると考えます。<br>
          このフレームワークに乗るだけで勉強に向かうことができる。そんな仕組みを提供します。
        </p>
      </div>
      <div class="column is-half">
        <div class="images columns is-centered">
          <div class="column is-half">
            <img src="/assets/fukei_mura_kaso.png" alt="">
          </div>
        </div>
        <h5 class="title is-5 has-text-centered">均等な学習機会が得られない</h5>
        <h5 class="title is-5 has-text-centered">↓</h5>
        <h4 class="title is-4 has-text-centered">オンライン学習</h4>
        <p class="is-size-5">
          私の前職の同期が本土最北端の稚内に転勤しました。<br>
          彼には生まれたばかりのお子さんがおり、その子は稚内を生まれ故郷として人生を歩みます。<br>
          この貴重で素晴らしい環境で育っていくにもかかわらず、
          田舎だからといってチャンスに恵まれずその才能を十分発揮できない可能性があるのならば、
          それは直ちに解決されるべきだと考えます。<br>
          <br>
          地方創生<br>
          その大きな要素の一つとして、均等な学習機会の提供。<br>
          これを実現するためにオンライン学習のアプリを提供します。
        </p>
      </div>
    </div>
  </div>

  <div class="container is-love">
    <h3 class="title is-3 has-text-centered">DUOを心から愛しています</h3>
    <p class="is-size-5 has-text-centered">
      学習していて楽しい。<br>
      効率の良い学習ができる。<br>
      使い方は無限大！<br>
      そんなDUOの魅力をお伝えします。
    </p>
    <div class="columns is-explanation">
      <div class="column is-one-third">
        <h4 class="title is-4 has-text-centered">どんな本？</h4>
        <div class="images columns is-centered">
          <div class="column is-half">
            <img src="/assets/book.png" alt="">
          </div>
        </div>
      </div>
      <div class="column is-one-third">
        <h4 class="title is-4 has-text-centered">LOVE</h4>
        <div class="images columns is-centered">
          <div class="column is-half">
            <img src="/assets/heart_welcome.png" alt="">
          </div>
        </div>
      </div>
      <div class="column is-one-third">
        <h4 class="title is-4 has-text-centered">いつやるの？</h4>
        <div class="images columns is-centered">
          <div class="column is-half">
            <img src="/assets/mangrove_hayashi.png" alt="">
          </div>
        </div>
      </div>
    </div>
  </div>

  <div class="container is-functions">
    <h3 class="title is-3 has-text-centered">搭載機能</h3>
    <section class="hero is-light is-primary">
      <div class="hero-body" @click="goToPost">
        <div>
          <a class="title">POST</a>
        </div>
        <p class="subtitle">
          SNSと単語学習をマッチさせる
        </p>
      </div>
    </section>

    <section class="hero is-light is-link">
      <div class="hero-body" @click="goToExercise">
        <div>
          <a class="title">EXERCISE</a>
        </div>
        <p class="subtitle">
          レッスンごとに日英・英日／文章・単語別にクイズ形式で暗記の勉強ができる
        </p>
      </div>
    </section>
  </div>
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
.is-love,
.is-functions {
  margin-top: 15vh;
}
.is-problems,
.is-explanation {
  margin-top: 25px;
}
.is-problems .images {
  height: 30vh;
  align-items: center;
}
.is-love .images {
  height: 20vh;
  align-items: center;
}
.top-hero {
  height: 80vh;
}
.is-functions .hero-body {
  cursor: pointer;
}
</style>