<template>
<div class="box">
  <h4 class="title is-4">{{ currentIndex + 1 }} / {{ questionLength }}</h4>
  <p>{{ currentQuestion }}</p>
</div>
<div>
  <form @submit.prevent="doAnswer">
    <label class="label">Your Answer</label>
    <div class="columns">
      <div class="column is-10">
        <textarea type="textarea" class="input" name="answer" id="answer" rows="5"></textarea>
      </div>
      <div class="column is-2"><button class="button is-fullwidth">CHECK</button></div>
    </div>
  </form>
</div>
</template>

<script>
export default {
  props: {
    currentQuestion: String,
    currentIndex: Number,
    questionLength: Number,
  },
}
</script>

<style scoped>
.textarea {
  resize: none;
}
</style>