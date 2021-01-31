<template>
<div>
  <div class="columns" @contextmenu.prevent="onContextMenu">
    <div class="column is-1"></div>
    <div class="column is-1 word-id">{{ word.word_id }}</div>
    <div class="column is-5">{{ word.english }}</div>
    <div class="column is-5">{{ word.japanese }}</div>
  </div>
  <div v-show="isActiveMenu" @click="editTerm(word)">
    <p>登録単語編集</p>
  </div>
</div>
</template>

<script>
export default {
  props: {
    currentUser: String,
    word: Object,
  },
  emits: [
    'edit-term',
  ],
  data() {
    return {
      isActiveMenu: false,
    }
  },
  methods: {
    onContextMenu: function() {
      if (this.currentUser === 'admin') {
        this.isActiveMenu = !this.isActiveMenu
      }
    },
    editTerm: function(word) {
      this.$emit('edit-term', word)
    }
  }
}
</script>

<style scoped>
.columns {
  border-bottom: 1px solid black;
  border-left: 1px solid black;
  border-right: 1px solid black;
}
.column {
  white-space: pre-wrap;
  word-wrap: break-word;
  padding-left: 0;
}
</style>