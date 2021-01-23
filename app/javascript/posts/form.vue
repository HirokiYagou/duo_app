<template>
<div :class="['modal', isActive]">
  <div class="modal-background" @click.self="doCloseForm"></div>
  <div class="modal-content">
    <div class="box">
      <div class="content">
        <form @submit.prevent="doCreatePost">
          <textarea
            name="content"
            v-model="content"
            class="textarea is-medium"
            placeholder="いまなにしてる？"
            cols="30"
            rows="5"
            autofocus
            required></textarea>
          <input type="file" name="post[image]" @change="selectImage" id="post-image">
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
    },
  },
  data() {
    return {
      content: '',
      uploadImage: null,
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
    selectImage: function(e) {
      const files = e.target.files
      this.uploadImage = files[0]
    },
    doCreatePost: function() {
      const formData = new FormData()
      formData.append('post[content]', this.content)
      if (this.uploadImage) {
        formData.append('post[image]', this.uploadImage)
      }
      this.$emit("create-post", formData)
      this.content = ''
      this.uploadImage = null
    },
    doCloseForm: function() {
      this.$emit("close-form")
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
