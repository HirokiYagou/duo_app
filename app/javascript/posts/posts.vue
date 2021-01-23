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
        <p class="subtitle is-6">@{{ post.username }}</p>
      </div>
    </div>

    <div class="content">
      {{ post.content }}
      <a>@bulmaio</a>.
      <a href="#">#css</a> <a href="#">#responsive</a>
      <br>
      <time datetime="2016-1-1">{{ post.created_at }}</time>
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