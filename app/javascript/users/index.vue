<template>
<div>
  <nav class="navbar is-fixed-top">
    <div class="container">
      <div id="navMenu" class="navbar-menu">
        <div class="navbar-start">
          <h1 class="navbar-item title is-1" @click="goToRoot">MyDUO</h1>
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
        <img :src="assets.duo" alt="">
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
        <h4 class="title is-4 has-text-centered content-is-book">どんな本？</h4>
        <div
          :class="['images', 'columns', 'is-centered', { 'content-is-active': contentPart === 'isBook' }]"
          @mouseover="changeContent('isBook')"
        >
          <div class="column is-half">
            <img :src="assets.book" alt="">
          </div>
        </div>
      </div>
      <div class="column is-one-third">
        <h4 class="title is-4 has-text-centered content-is-love">LOVE</h4>
        <div
          :class="['images', 'columns', 'is-centered', { 'content-is-active': contentPart === 'isLove' }]" 
          @mouseover="changeContent('isLove')"
        >
          <div class="column is-half">
            <img :src="assets.heart" alt="">
          </div>
        </div>
      </div>
      <div class="column is-one-third">
        <h4 class="title is-4 has-text-centered content-is-hayashi">いつやるの？</h4>
        <div
          :class="['images', 'columns', 'is-centered', { 'content-is-active': contentPart === 'isHayashi' }]" 
          @mouseover="changeContent('isHayashi')"
        >
          <div class="column is-half">
            <img :src="assets.hayashi" alt="">
          </div>
        </div>
      </div>
    </div>
    <explain
      :content-part="contentPart"
    ></explain>
  </div>


  <div class="container is-policy">
    <h3 class="title is-3 has-text-centered">このアプリが目指すこと</h3>
    <p class="is-size-4 has-text-centered is-undertitle">学習者の次の課題を解決します</p>
    <div class="columns is-problems">
      <div class="column is-half">
        <div class="images columns is-centered">
          <div class="column is-half">
            <img :src="assets.study" alt="">
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
            <img :src="assets.kaso" alt="">
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
    <section class="section is-post" @click="goToPost">
      <div>
        <a class="title">POST</a>
      </div>
      <p class="subtitle">
        SNSと単語学習を組み合わせる
      </p>
    </section>

    <section class="section is-exercise" @click="goToExercise">
      <div>
        <a class="title">EXERCISE</a>
      </div>
      <p class="subtitle">
        クイズ形式で暗記の勉強ができる
      </p>
    </section>
  </div>

  <footer class="footer is-ghost">
    <div class="content has-text-centered">
      <p>
        <strong>MyDUO</strong> by Yagou Hiroki. The source code is on
        <a href="https://github.com/HirokiYagou/duo_app">GitHub</a>. The website content
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
    'explain': explainVue
  },
  data() {
    return {
      currentUserName: '',
      isSignedIn: false,
      contentPart: 'isBook',
      assets: {}
    }
  },
  methods: {
    goToRoot: function() {
      window.location.href = '/'
    },
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
          this.assets = data.assets
        })
        .catch(error => {
          console.log(error)
        })
    },
    changeContent: function(part) {
      this.contentPart = part
    },
  },
  created: function() {
    this.fetchUser()
  },
}
</script>

<style scoped>
.container {
  margin: 0 15vw;
}
.navbar {
  height: 10vh;
}
.navbar-start h1 {
  height: 100%;
  margin-bottom: 0;
  cursor: pointer;
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

.is-explanation .content-is-book {
  border-bottom: 3px solid skyblue;
}
.is-explanation .content-is-love {
  border-bottom: 3px solid pink;
}
.is-explanation .content-is-hayashi {
  border-bottom: 3px solid lightgreen;
}
.is-explanation .content-is-active {
  background-color: whitesmoke;
}
.is-love .images {
  height: 20vh;
  align-items: center;
  cursor: pointer;
}
.is-love .images:hover {
  background-color: whitesmoke;
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
.is-functions .section {
  cursor: pointer;
  position: relative;
}
.is-functions .is-post:before,
.is-functions .is-exercise:before {
  transition-property: width;
  transition-duration: 0.3s;
  transition-timing-function: ease;
  transition-delay: 0s;
  content: "";
  width: 0;
  height: 100%;
  position: absolute;
  top: 0;
  left: 0;
  z-index: -1;
}
.is-functions .is-post:before {
  background-color: lightgreen;
}
.is-functions .is-exercise:before {
  background-color: skyblue;
}

.is-functions .is-post {
  border-left: 20px solid lightgreen;
  background-color: rgb(240, 255, 240);
  z-index: 2;
}
.is-functions .is-exercise {
  border-left: 20px solid skyblue;
  background-color: rgb(240, 251, 255);
  z-index: 2;
}
.is-functions .is-post:hover,
.is-functions .is-post:active {
  color: white;
}
.is-functions .is-post:hover::before,
.is-functions .is-post:active::before,
.is-functions .is-exercise:hover::before,
.is-functions .is-exercise:active::before {
  width:100%;
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
  background-color: pink;
}

</style>
