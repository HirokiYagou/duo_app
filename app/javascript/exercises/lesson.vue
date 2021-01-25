<template>
<div class="columns is-gapless">
  <div class="column">
    <div class="button is-fullwidth is-bottom">LESSON{{ lesson }}</div>
  </div>
  <div class="column" v-for="exerciseDatum in exerciseData" :key="exerciseDatum.id">
    <exercise-type
      :exercise-datum="exerciseDatum"
    ></exercise-type>
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
  },
  computed: {
    exerciseData: function() {
      return [
        {
          id: 1,
          lesson: this.lesson,
          type: 'sentence',
          display: 'english'
        },
        {
          id: 2,
          lesson: this.lesson,
          type: 'sentence',
          display: 'japanese'
        },
        {
          id: 3,
          lesson: this.lesson,
          type: 'word',
          display: 'english'
        },
        {
          id: 4,
          lesson: this.lesson,
          type: 'word',
          display: 'japanese'
        },
      ]
    }
  }
}
</script>