<template>
<div>
  <div>
    <div class="columns is-gapless">
      <div class="column">
        <div class="button is-fullwidth is-lesson">LESSON</div>
      </div>
      <div class="column">
        <div class="button is-fullwidth">文章 JtoE</div>
      </div>
      <div class="column">
        <div class="button is-fullwidth">文章 EtoJ</div>
      </div>
      <div class="column">
        <div class="button is-fullwidth">単語 JtoE</div>
      </div>
      <div class="column">
        <div class="button is-fullwidth">単語 EtoJ</div>
      </div>
    </div>
  </div>
  <div v-for="lesson in lessons" :key="lesson">
    <exercise-lesson
      :lesson="lesson"
      @do-exercise="doExercise($event)"
    ></exercise-lesson>
  </div>
</div>
</template>

<script>
import Lesson from './lesson'

export default {
  components: {
    'exercise-lesson': Lesson,
  },
  data() {
    return {
      lessonCount: 44,
    }
  },
  computed: {
    lessons: function() {
      const array = []
      for (let i = 0; i < this.lessonCount; i++) {
        array.push(i + 1)
      }
      return array
    }
  },
  methods: {
    doExercise: function(questionData) {
      this.$emit('do-exercise', questionData)
    }
  }
}
</script>

<style scoped>
.is-lesson {
  border: none;
}
</style>