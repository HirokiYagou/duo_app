<template>
<div :class="['modal', {'is-active': formActive}]">
  <div class="modal-background" @click.self="doCloseForm"></div>
  <div class="modal-content">
    <div class="box">
      <div class="content">
        <form @submit.prevent="doPost">
          <textarea
            name="content"
            id="post-content"
            v-model="uploadContent"
            class="textarea is-medium"
            placeholder="いまなにしてる？"
            cols="30"
            rows="5"
            autofocus
            required></textarea>
          <input type="file" name="post[image]" @change="selectImage" id="post-image">
          <input type="hidden" v-model="uploadReplyTo" name="post[reply_to]">
          <button type="submit" :class="['button', 'is-primary', isEmpty]" v-show="!isEdit">投稿する</button>
          <button type="submit" :class="['button', 'is-primary', isEmpty]" v-show="isEdit">編集する</button>
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
    formActive: Boolean,
    editInfo: Object,
    replyInfo: Object
  },
  emits: [
    'do-post',
    'close-form',
  ],
  data() {
    return {
      uploadContent: '',
      uploadImage: null,
      uploadReplyTo: null,
    }
  },
  computed: {
    isEdit: function() {
      if (this.editInfo.editPost.id) {
        return true
      }
    },
    isEmpty: function() {
      if (this.uploadContent) {
        return 'filled'
      }
      return 'empty'
    },
  },
  watch: {
    editInfo: {
      handler: function(next) {
        if (next.editPost.content) {
          this.uploadContent = next.editPost.content
        } else {
          this.uploadContent = ''
        }
      },
      deep: true,
    },
    replyInfo: {
      handler: function(next) {
        if (next.reply_to) {
          this.uploadReplyTo = next.reply_to
        }
      },
      deep: true,
    }
  },
  methods: {
    selectImage: function(e) {
      const files = e.target.files
      this.uploadImage = files[0]
    },
    doPost: function() {
      const formData = new FormData()
      formData.append('post[content]', this.uploadContent)
      if (this.uploadImage) {
        formData.append('post[image]', this.uploadImage)
      }
      if (this.uploadReplyTo) {
        formData.append('post[reply_to]', this.uploadReplyTo)
      }
      this.$emit("do-post", formData)
      this.uploadContent = ''
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
