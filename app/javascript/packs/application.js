require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import { createApp } from 'vue';
import Posts from 'posts/index.vue';

document.addEventListener('DOMContentLoaded', () => {
  createApp(Posts).mount('#posts')
});
