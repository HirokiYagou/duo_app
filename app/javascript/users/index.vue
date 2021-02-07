<template>
<div>
  <nav class="navbar is-fixed-top">
    <div class="container">
      <div id="navMenu" class="navbar-menu">
        <div class="navbar-start">
          <h1 class="navbar-item title is-1">MyDUO</h1>
          <a class="navbar-item" @click="goToPost">
            POST
          </a>
          <a class="navbar-item" @click="goToExercise">
            EXERCISE
          </a>
        </div>

        <div class="signed-in-check" v-if="isSignedIn">
          <div class="navbar-end">
            <p class="navbar-item is-size-4">@{{ currentUserName }}</p>
            <div class="navbar-item">
              <div class="buttons">
                <a class="button is-ghost is-light is-large" href="/users/sign_out" data-method="delete">SignOut</a>
              </div>
            </div>
          </div>
        </div>
        <div class="signed-in-check" v-if="!isSignedIn">
          <div class="navbar-end">
            <div class="navbar-item">
              <div class="buttons">
                <a class="button is-light is-primary is-large" href="/users/sign_up"><strong>SignUp</strong></a>
                <a class="button is-ghost is-light is-large" href="/users/sign_in">LogIn</a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </nav>
  <section class="navbar-back">navbar-back</section>

  <section class="hero is-light is-large">
    <div class="hero-body">
      <p class="title is-1 has-text-centered">Enjoy Yourself with DUO!!</p>
    </div>
  </section>

  <div class="container is-love">
    <h3 class="title is-3 has-text-centered">DUOって、何？</h3>
    <div class="columns is-centered is-undertitle">
      <div class="column is-half">
        <img src="/assets/duo.jpg" alt="">
      </div>
    </div>
    <p class="is-size-4 has-text-centered is-vocabulary-book">英単語帳です！</p>
    <p class="is-size-5 has-text-centered">
      学習していて楽しい<br>
      効率の良い学習ができる<br>
      使い方は無限大！<br>
      そんなDUOの魅力をお伝えします
    </p>
    <div class="columns is-explanation">
      <div class="column is-one-third">
        <h4 class="title is-4 has-text-centered">どんな本？</h4>
        <div class="images columns is-centered" @click="openExplainModal('isBook')">
          <div class="column is-half">
            <img src="/assets/book.png" alt="">
          </div>
        </div>
      </div>
      <div class="column is-one-third">
        <h4 class="title is-4 has-text-centered">LOVE</h4>
        <div class="images columns is-centered" @click="openExplainModal('isLove')">
          <div class="column is-half">
            <img src="/assets/heart_welcome.png" alt="">
          </div>
        </div>
      </div>
      <div class="column is-one-third">
        <h4 class="title is-4 has-text-centered">いつやるの？</h4>
        <div class="images columns is-centered" @click="openExplainModal('isHayashi')">
          <div class="column is-half">
            <img src="/assets/mangrove_hayashi.png" alt="">
          </div>
        </div>
      </div>
    </div>
  </div>

  <explain-modal
    :modal-content="modalContent"
    @do-close-explain-modal="closeExplainModal"
  ></explain-modal>

  <div class="container is-policy">
    <h3 class="title is-3 has-text-centered">このアプリが目指すこと</h3>
    <p class="is-size-4 has-text-centered is-undertitle">学習者の次の課題を解決します</p>
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
          意気込んでみても、熱意が続くのは3日だけ。<br>
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


  <div class="container is-functions">
    <h3 class="title is-3 has-text-centered">搭載機能</h3>
    <section class="hero is-light is-primary is-undertitle">
      <div class="hero-body" @click="goToPost">
        <div>
          <a class="title">SNS</a>
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
          クイズ形式で暗記の勉強ができる
        </p>
      </div>
    </section>
  </div>

  <footer class="footer is-ghost">
    <div class="content has-text-centered">
      <p>
        <strong>MyDUO</strong> by Yagou Hiroki. The source code is on
        <a href="https://github.com/HirokiYagou/duo_app">Github</a>. The website content
        is mainly made by Ruby on Rails &amp; Vue.js.
      </p>
    </div>
  </footer>
</div>
</template>

<script>
import explainVue from './explain.vue'

export default {
  components: {
    'explain-modal': explainVue
  },
  data() {
    return {
      currentUserName: '',
      isSignedIn: false,
      modalContent: ''
    }
  },
  methods: {
    goToPost: function() {
      window.location.href = '/posts'
    },
    goToExercise: function() {
      window.location.href = '/exercises'
    },
    fetchUser: function() {
      fetch('/users.json')
        .then(response => {
          return response.json()
        })
        .then(data => {
          if (data.user.username) {
            this.isSignedIn = true
            this.currentUserName = data.user.username
          } else {
            this.isSignedIn = false
          }
        })
        .catch(error => {
          console.log(error)
        })
    },
    openExplainModal: function(part) {
      this.modalContent = part
    },
    closeExplainModal: function() {
      this.modalContent = ''
    }
  },
  created: function() {
    this.fetchUser()
  },
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
.signed-in-check {
  display: flex;
  align-items: center;
}
.signed-in-check .button {
  width: 150px;
}
.navbar-back {
  height: 10vh;
}

.top-hero {
  height: 80vh;
}

.is-love .images {
  height: 20vh;
  align-items: center;
  cursor: pointer;
}
.is-love .images:hover {
  background-color: ghostwhite;
}

.is-vocabulary-book {
  margin-bottom: 5vh;
}

.is-policy,
.is-functions,
.footer {
  margin-top: 30vh;
}
.is-love {
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
.is-functions .hero-body {
  cursor: pointer;
}

h3 {
  position: relative;
  display: inline-block;
  margin-bottom: 1em;
  left: 50%;
  -webkit-transform: translateX(-50%);
  transform: translateX(-50%);

}
h3:before {
  content: '';
  position: absolute;
  bottom: -15px;
  display: inline-block;
  width: 60px;
  height: 5px;
  left: 50%;
  -webkit-transform: translateX(-50%);
  transform: translateX(-50%);
  background-color: black;
}
.is-undertitle {
  margin-top: 3vh;
}
.is-love h3:before {
  background-color: rgb(255, 182, 47);
}
.is-policy h3:before {
  background-color: lightgreen;
}
.is-functions h3:before {
  background-color: rgb(179, 170, 255);
}
</style>