<template>
<div class="search-area-wrapper">
  <form @submit.prevent="searchPostByInput">
    <input class="input is-normal" type="text" @keyup="searchTerm" v-model="searchInput" placeholder="search with keyword">
  </form>
  <div class="box" v-show="searchInput">
    <ul>
      <li
        v-for="(searchResult, index) in searchResults"
        :key="index"
        @click="searchPostByTerm(searchResult.english)"
        class="search-result"
      ><a>{{ searchResult.english }}</a></li>
    </ul>
  </div>
</div>
</template>

<script>
export default {
  data() {
    return {
      searchInput: '',
      searchResults: [],
    }
  },
  emits: [
    'search-post-by-input',
  ],
  methods: {
    searchTerm: function() {
      fetch(`posts/search/?keyword=${this.searchInput}`)
        .then(response => {
          return response.json()
        })
        .then(data => {
          this.searchResults = data
        })
        .catch(error => {
          console.log(error)
        })
    },
    searchPostByInput: function() {
      this.$emit('search-post-by-input', this.searchInput)
    }
  }
}
</script>

<style scoped>
.search-result {
  margin-bottom: 10px;
  border-bottom: 1px solid ghostwhite;
}
</style>