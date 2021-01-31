<template>
 <div class="columns" @click="doIsActive">
    <div class="column is-1"></div>
    <div class="column is-1 word-id">{{ word.word_id }}</div>
    <div class="column is-5">{{ word.english }}</div>
    <div class="column is-5">{{ word.japanese }}</div>
  </div>
</template>

<script>
export default {
  props: {
    word: Object,
  },
}
</script>

<style scoped>
.columns {
  border-bottom: 1px solid black;
}
.column {
  white-space: pre-wrap;
  word-wrap: break-word;
  padding-left: 0;
}
</style>