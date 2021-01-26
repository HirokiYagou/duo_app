<template>
<div>
  <p>2020/12/31</p>
  <div class="button is-fullwidth" @click="goToExercise">
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
    goToExercise: function() {
      const questionDataParams = {
        display: this.exerciseDatum.display,
        lesson: this.exerciseDatum.lesson,
        type: this.exerciseDatum.type
      }
      this.$emit('go-to-exercise', questionDataParams)
    },
    // getQuestions: function() {
    //   const exercisePath = `exercises/${this.exerciseDatum.lesson}/${this.exerciseDatum.type}.json`
    //   fetch(exercisePath)
    //     .then(response => {
    //       return response.json()
    //     })
    //     .then(data => {
    //       questionDataParams.questions = data
    //     })
    //     .catch(error => {
    //       console.log(error)
    //     })
    // },
    // getScores: function() {
    //   const scorePath = `exercises/${this.exerciseDatum.lesson}/${this.exerciseDatum.type}/${this.exerciseDatum.display}.json`
    //   fetch(scorePath)
    //     .then(response => {
    //       return response.json()
    //     })
    //     .then(data => {
    //       questionDataParams.scores = data
    //     })
    //     .catch(error => {
    //       console.log(error)
    //     })
    // }
  }
}
</script>