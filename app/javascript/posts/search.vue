<template>
<div class="search-area-wrapper">
  <form @submit.prevent="searchComplex">
    <button type="submit" class="button is-fullwidth is-primary">ComplexSearch</button>
    <div class="field">
      <label class="label">Content</label>
      <input type="text" class="input" @focus="onfocus('content')" v-model="searchInfo.content" placeholder="Content">
    </div>
    <div class="field">
      <label class="label">Term</label>
      <input
        type="text"
        class="input"
        @keyup="getSearchTerm"
        @focus="onfocus('term')"
        v-model="searchInfo.term"
        placeholder="Term">
      <ul>
        <li
          v-for="(searchTermResult, index) in searchTermResults"
          :key="index"
          @click="setSearchTerm(searchTermResult.english)"
          class="search-result"
        ><a>{{ searchTermResult.english }}</a></li>
      </ul>
    </div>
    <div class="field">
      <label class="label">Username</label>
      <input type="text" class="input" @focus="onfocus('username')" v-model="searchInfo.username" placeholder="Username">
    </div>
  </form>
</div>
</template>

<script>
export default {
  props: {
    searchInfoParams: Boolean,
  },
  emits: [
    'search-complex',
  ],
  data() {
    return {
      searchInfo: {
        content: '',
        term: '',
        username: '',
      },
      searchTermResults: [],
      searchUsernameResults: [],
    }
  },
  watch: {
    searchInfoParams: {
      handler: function() {
        this.searchInfo = {
          content: '',
          term: '',
          username: '',
        }
      },
      deep: true,
      immediate: true
    },
  },
  methods: {
    onfocus: function(input) {
      if (input === 'content') {
        this.searchTermResults = []
        this.searchUsernameResults = []
      } else if(input === 'term') {
        this.searchUsernameResults = []
      } else if(input === 'username') {
        this.searchTermResults = []
      }
    },
    getSearchTerm: function() {
      fetch(`posts/search/?keyword=${this.searchInfo.term}`)
        .then(response => {
          return response.json()
        })
        .then(data => {
          this.searchTermResults = data
        })
        .catch(error => {
          console.log(error)
        })
    },
    setSearchTerm: function(term) {
      this.searchInfo.term = term
      this.searchTermResults = []
    },
    searchComplex: function() {
      this.$emit('search-complex', this.searchInfo)
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