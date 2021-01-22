<template>
<div :class="['modal', isActive]">
  <div class="modal-background" @click.self="doCloseForm"></div>
  <div class="modal-content">
    <div class="box">
      <div class="content">
        <form @submit.prevent="createPost">
          <textarea
            name="content"
            v-model="content"
            class="textarea is-medium"
            placeholder="いまなにしてる？"
            cols="30"
            rows="5"
            required></textarea>
          <button type="submit" :class="['button', 'is-primary', isEmpty]">投稿する</button>
        </form>
      </div>
    </div>
  </div>
  <button class="modal-close is-large" aria-label="close" @click="doCloseForm"></button>
</div>
</template>

<script>
export default {
  props: {
    isActive: {
      type: String,
    }
  },
  data() {
    return {
      content: '',
    }
  },
  computed: {
    isEmpty: function() {
      if (this.content) {
        return 'filled'
      }
      return 'empty'
    },
  },
  methods: {
    doCloseForm: function() {
      this.$emit("close-form")
    },
    createPost: function() {
      
    },
  },
}
</script>

<style scoped>
.textarea {
  resize: none;
  border: none;
}
.empty {
  opacity: 0.5;
}
</style>
