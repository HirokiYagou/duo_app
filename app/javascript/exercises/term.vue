<template>
<div>
  <section class="accordions">
    <div
      v-for="lesson in lessons"
      :key="lesson"
    >
      <lesson
        :lesson="lesson"
      ></lesson>
    </div>
  </section>
</div>
</template>

<script>
import Lesson from './term_lesson'

export default {
  components: {
    'lesson': Lesson,
  },
  props: {
    lessonCount: Number
  },
  computed: {
    lessons: function() {
      const array = []
      for (let i = 42; i < this.lessonCount; i++) {
        array.push(i + 1)
      }
      return array
    }
  }
}
</script>