<template>
<div class="columns">
  <div class="column is-1">{{ sentence.sentence_id }}</div>
  <div class="column is-5">{{ sentence.english }}</div>
  <div class="column is-6">{{ sentence.japanese }}</div>
</div>
</template>

<script>
export default {
  props: {
    sentence: Object,
  }
}
</script>

<style scoped>
.columns {
  border-bottom: 1px solid black;
}
.column {
  white-space: pre-wrap;
  word-wrap: break-word;
}
</style>