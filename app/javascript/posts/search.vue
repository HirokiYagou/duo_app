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
      <input
        type="text"
        class="input"
        @keyup="getSearchUsername"
        @focus="onfocus('username')"
        v-model="searchInfo.username"
        placeholder="Username">
      <ul>
        <li
          v-for="(searchUsernameResult, index) in searchUsernameResults"
          :key="index"
          @click="setSearchUsername(searchUsernameResult.username)"
          class="search-result"
        ><a>@{{ searchUsernameResult.username }}</a></li>
      </ul>
    </div>
    <!-- <div class="field">
      <label class="label">Date</label>
      <input type="text" class="input">
      <p>↓</p>
      <input type="date" class="input">
    </div> -->
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
        // dateFrom: '',
        // dateTo: "2021-01-01"
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
    getSearchUsername: function() {
      fetch(`users/search/?keyword=${this.searchInfo.username}`)
        .then(response => {
          return response.json()
        })
        .then(data => {
          this.searchUsernameResults = data
        })
        .catch(error => {
          console.log(error)
        })
    },
    setSearchUsername: function(username) {
      this.searchInfo.username = username
      this.searchUsernameResults = []
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