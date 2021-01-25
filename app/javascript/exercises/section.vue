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
  methods: {
    getExercise: function() {
      const questionData = {}
      const path = `exercises/${this.exerciseDatum.lesson}/${this.exerciseDatum.type}.json`
      fetch(path)
        .then(response => {
          return response.json()
        })
        .then(data => {
          questionData.display = this.exerciseDatum.display
          questionData.questions = data.questions
          this.$emit('do-exercise', questionData)
        })
        .catch(error => {
          console.log(error)
        })
    }
  }
}
</script>