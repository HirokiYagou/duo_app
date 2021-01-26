<template>
<div>
  <p>2020/12/31</p>
  <div class="button is-fullwidth" @click="doExercise">
  </div>
</div>
</template>

<script>
export default {
  props: {
    exerciseDatum: Object,
  },
  data() {
    return {
      // questionDataParams: {},
    }
  },
  methods: {
    doExercise: function() {
      const questionData = {
        display: this.exerciseDatum.display,
        lesson: this.exerciseDatum.lesson,
        type: this.exerciseDatum.type
      }
      this.$emit('do-exercise', questionData)
    },
  }
}
</script>