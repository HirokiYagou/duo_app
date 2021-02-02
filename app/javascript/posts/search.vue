<template>
<div class="search-area-wrapper">
  <div class="search-initially" v-show="!Object.keys(searchInfo).length">
    <form @submit.prevent="searchPostByInput">
      <input type="text" class="input is-normal" @keyup="searchTerm" v-model="searchInput" placeholder="search with keyword">
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

  <div class="search-detailly" v-show="Object.keys(searchInfo).length">
    <h5 class="title is-5 has-text-centered"> ComplexSearch</h5>
    <form @submit.prevent="searchDetail">
      <div class="field">
        <label class="label">Content</label>
        <input type="text" class="input" v-model="searchContent" placeholder="Content">
      </div>
    </form>
  </div>
</div>
</template>

<script>
export default {
  props: {
    searchInfo: Object,
  },
  emits: [
    'search-post-by-input',
  ],
  data() {
    return {
      searchInput: '',
      searchResults: [],
      searchContent: '',
    }
  },
  watch: {
    searchInfo: {
      handler: function(next) {
        this.searchContent = next.content
      },
      deep: true,
      immediate: true
    },
  },
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
      this.searchInfo.content = this.searchInput
      this.searchInput = ''
    }
  }
}
</script>

<style scoped>
.search-result {
  margin-bottom: 10px;
  border-bottom: 1px solid ghostwhite;
}
.search-detailly> h5 {
  margin-bottom: 10px;
}
</style>