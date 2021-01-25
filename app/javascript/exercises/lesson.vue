<template>
<div class="columns is-gapless">
  <div class="column">
    <div class="button is-fullwidth is-bottom">LESSON{{ lesson }}</div>
  </div>
  <div class="column">
    <exercise-type></exercise-type>
  </div>
  <div class="column">
    <exercise-type></exercise-type>
  </div>
  <div class="column">
    <exercise-type></exercise-type>
  </div>
  <div class="column">
    <exercise-type></exercise-type>
  </div>
</div>
</template>

<script>
import Type from './type'

export default {
  components: {
    'exercise-type': Type,
  },
  props: {
    lesson: Number
  }
}
</script>