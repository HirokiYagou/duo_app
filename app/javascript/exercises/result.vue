<template>
<div class="container">
  <h5 class="title is-5">RESULT</h5>
  <div
    v-for="(yourResult, index) in yourResults"
    :key="index"
    class="columns"
    >
    <div class="column is-1">
      {{ index + 1 }}
    </div>
    <div class="column is-1">
      {{ yourResult.yourAnswer }}
    </div>
    <div class="column is-5">
      {{ yourResult.questionText }}
    </div>
    <div class="column is-5">
      {{ yourResult.questionAnswer }}
    </div>
  </div>
</div>
</template>

<script>
export default {
  props: {
    yourResults: Array,
  },
}
</script>

<style scoped>
.columns {
  border-bottom: 1px solid black;
}
</style>