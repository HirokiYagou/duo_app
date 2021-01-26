<template>
<div>
  <p>2020/12/31</p>
  <div class="button is-fullwidth" @click="getExercise">
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
      questionDataParams: {},
    }
  },
  methods: {
    getExercise: function() {
      this.questionDataParams.display = this.exerciseDatum.display
      this.getQuestions()
      this.getScores()
      this.$emit('do-exercise', this.questionDataParams)
    },
    getQuestions: function() {
      const exercisePath = `exercises/${this.exerciseDatum.lesson}/${this.exerciseDatum.type}.json`
      fetch(exercisePath)
        .then(response => {
          return response.json()
        })
        .then(data => {
          this.questionDataParams.questions = data
          console.log(data)
        })
        .catch(error => {
          console.log(error)
        })
    },
    getScores: function() {
      const scorePath = `exercises/${this.exerciseDatum.lesson}/${this.exerciseDatum.type}/${this.exerciseDatum.display}.json`
      fetch(scorePath)
        .then(response => {
          return response.json()
        })
        .then(data => {
          this.questionDataParams.scores = data
        })
        .catch(error => {
          console.log(error)
        })
    }
  }
}
</script>