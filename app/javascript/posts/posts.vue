<template>
<div
  class="card"
  v-for="post in posts"
  :key="post.id"
  :data-id="post.id"
>
  <div class="card-content">
    <div class="media">
      <div class="media-left">
        <figure class="image is-48x48">
          <img src="https://bulma.io/images/placeholders/96x96.png" alt="Placeholder image">
        </figure>
      </div>
      <div class="media-content">
        <p class="title is-4">たまプラーザ</p>
        <p class="subtitle is-6">@{{ post.username }}
          <time :datetime="post.created_at">
            {{ new Date(post.created_at).getFullYear() }}/{{ new Date(post.created_at).getMonth() + 1 }}/{{ new Date(post.created_at).getDate() }}
            {{ new Date(post.created_at).getHours() }}:{{ new Date(post.created_at).getMinutes() }}
          </time>
        </p>
      </div>
      <div class="media-right">
        <div class="dropdown">
          <div class="dropdown-trigger">
            <button class="button" aria-haspopup="true" aria-controls="dropdown-menu3">
              <span class="icon is-small">
                <img src="/assets/bars_24.png" alt="">
                <i class="fas fa-angle-down" aria-hidden="true"></i>
              </span>
            </button>
          </div>
          <div class="dropdown-menu" id="dropdown-menu3" role="menu">
            <div class="dropdown-content">
              <a href="#" class="dropdown-item">
                Overview
              </a>
              <a href="#" class="dropdown-item">
                Modifiers
              </a>
              <a href="#" class="dropdown-item">
                Grid
              </a>
              <a href="#" class="dropdown-item">
                Form
              </a>
              <a href="#" class="dropdown-item">
                Elements
              </a>
              <a href="#" class="dropdown-item">
                Components
              </a>
              <a href="#" class="dropdown-item">
                Layout
              </a>
              <hr class="dropdown-divider">
              <a href="#" class="dropdown-item">
                More
              </a>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="content">
      <p>{{ post.content }}</p>
      <!-- <a>@bulmaio</a>.
      <a href="#">#css</a> <a href="#">#responsive</a> -->
    </div>
    <div class="card-image" v-if="post.image">
      <figure class="image is-4by3">
        <img :src="post.image" alt="Placeholder image">
      </figure>
    </div>
  </div>
</div>
</template>

<script>
export default {
  props: {
    posts: Array,
  },
}
</script>

<style scoped>
.content> p {
  white-space: pre-wrap;
  word-wrap: break-word;
}
.dropdown button {
  border: none;
}
</style>