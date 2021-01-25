require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import { createApp } from "vue"
import Posts from "posts/index"
import Terms from "admin/terms/index"

document.addEventListener('DOMContentLoaded', () => {
  createApp(Posts).mount('#posts')
  createApp(Terms).mount('#terms')
});
