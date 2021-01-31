<template>
<div>
  <section class="accordions">
    <div
      v-for="lesson in lessons"
      :key="lesson"
    >
      <lesson
        :current-user="currentUser"
        :lesson="lesson"
        @edit-term="editTerm($event)"
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
    currentUser: String,
    lessonCount: Number
  },
  emits: [
    'edit-term',
  ],
  computed: {
    lessons: function() {
      const array = []
      for (let i = 42; i < this.lessonCount; i++) {
        array.push(i + 1)
      }
      return array
    }
  },
  methods: {
    editTerm: function(term) {
      this.$emit('edit-term', term)
    }
  }
}
</script>