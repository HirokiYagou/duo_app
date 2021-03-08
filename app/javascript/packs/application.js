require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import { createApp } from "vue"
import { createRouter, createWebHashHistory } from "vue-router"
import Users from "users/index"
import Posts from "posts/index"
import Exercises from "exercises/index"
import Terms from "admin/terms/index"

const router = createRouter({
  history: createWebHashHistory(),
  routes: [
    { path: '/', component: Users },
    // { path: '/posts', component: Posts }
  ]
})

document.addEventListener('DOMContentLoaded', () => {
  const users = createApp(Users)
  const posts = createApp(Posts)
  users.use(router)
  users.mount('#users')
  // createApp(Users).mount('#users')
  posts.use(router)
  posts.mount('#posts')
  // createApp(Posts).mount('#posts')
  createApp(Exercises).mount('#exercises')
  createApp(Terms).mount('#terms')
});
