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
            required>
          </textarea>
          <div class="columns">
            <div class="column is-half">
              <input
                type="text"
                class="input"
                @keyup="getSearchTerm"
                v-model="searchTermInput"
                placeholder="タグ検索">
              <ul>
                <li
                  v-for="(searchTermResult, index) in searchTermResults"
                  :key="index"
                  @click="setSearchTerm(searchTermResult)"
                  class="search-result"
                ><a>{{ searchTermResult.english }}</a></li>
              </ul>
            </div>
            <div class="column is-half tags">
              <span
                class="tag"
                v-for="(uploadTerm, index) in uploadTerms"
                :key="index"
              >{{ uploadTerm.english }}
                <button type="button" class="delete is-small" @click.prevent="deleteUploadTerm(index)"></button>
              </span>
            </div>
          </div>
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
      uploadTerms: [],
      searchTermInput: '',
      searchTermResults: [],
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
      if (this.uploadTerms.length) {
        this.uploadTerms.forEach(uploadTerm => {
          formData.append('post[term_ids][]', uploadTerm.term_id)
        });
      }
      this.$emit("do-post", formData)
      this.uploadContent = ''
      this.uploadImage = null
      this.searchTermInput = ''
      this.uploadTerms = []
    },
    getSearchTerm: function() {
      fetch(`posts/search/?keyword=${this.searchTermInput}`)
        .then(response => {
          return response.json()
        })
        .then(data => {
          this.searchTermResults = data
        })
        .catch(error => {
          console.log(error)
        })
    },
    setSearchTerm: function(term) {
      this.uploadTerms.push(term)
      this.searchTermResults = []
      this.searchTermInput = ''
    },
    deleteUploadTerm: function(index) {
      console.log(index)
      this.uploadTerms.splice(index, 1)
    },
    doCloseForm: function() {
      this.$emit("close-form")
      this.searchTermInput = ''
      this.uploadTerms = []
    },
  },
}
</script>

<style scoped>
.textarea {
  resize: none;
  border: none;
}
.column> .input {
  border: none;
}
.empty {
  opacity: 0.5;
}
</style>
