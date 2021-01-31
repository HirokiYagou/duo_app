<template>
<div>
  <p>{{ showUser.showProfile.nickname }}さん</p>
  <p>@{{ showUser.name }}</p>
  <p>{{ showUser.showProfile.status }}</p>
  <button class="button" @click="doEditProfile" v-if="showUser.id === current_user.id">Edit Profile</button>
  <div class="tabs is-fullwidth">
    <ul>
      <li :class="{ 'is-active': isActive === 'all' }" @click="switchIsActive('all')"><a>ALL</a></li>
      <li :class="{ 'is-active': isActive === 'favorite' }" @click="switchIsActive('favorite')"><a>FAVORITE</a></li>
    </ul>
  </div>

  <div :class="['modal', {'is-active': profileActive}]">
    <div class="modal-background" @click.self="doCloseForm"></div>
    <div class="modal-content">
      <div class="box">
        <div class="content">
          <form @submit.prevent="setUpdateProfile">
            <div class="field">
              <label class="label">Nickname</label>
              <input v-model="updateNickname" class="input" name="nickname" type="text" placeholder="名前" autofocus required>
            </div>
            <div class="field">
              <label class="label">Status</label>
              <textarea
                v-model="updateStatus"
                name="status"
                class="textarea is-medium"
                placeholder="自己紹介"
                cols="30"
                rows="5"
                required
              ></textarea>
            </div>
            <input type="file" name="profile[icon]" @change="selectIcon" id="profile-icon">
            <input type="file" name="profile[header]" @change="selectHeader" id="profile-header">
            <button type="submit" class="button is-primary">編集する</button>
          </form>
        </div>
      </div>
    </div>
    <button class="modal-close is-large" aria-label="close" @click.self="doCloseForm"></button>
  </div>
</div>
</template>

<script>
export default {
  props: {
    current_user: Object,
    profileActive: Boolean,
    showUser: {
      type: Object,
      default: {
        id: null,
        name: '',
        showProfile: {
          nickname: '',
          status: '',
        }
      },
    },
  },
  emits: [
    'do-edit-profile',
    'update-profile',
    'close-form',
    'set-user-posts',
    'set-favorite-posts',
  ],
  data() {
    return {
      updateNickname: '',
      updateStatus: '',
      updateIcon: null,
      updateHeader: null,
      isActive: 'all',
    }
  },
  watch: {
    showUser: {
      handler: function(next) {
        this.updateNickname = next.showProfile.nickname
        this.updateStatus = next.showProfile.status
        this.isActive = 'all'
        console.log(1234)
      },
      deep: true,
      immediate: true
    }
  },
  methods: {
    doEditProfile: function() {
      this.$emit("do-edit-profile")
    },
    selectIcon: function(e) {
      const files = e.target.files
      this.updateIcon = files[0]
    },
    selectHeader: function(e) {
      const files = e.target.files
      this.updateHeader = files[0]
    },
    setUpdateProfile: function() {
      const formData = new FormData()
      formData.append('profile[nickname]', this.updateNickname)
      formData.append('profile[status]', this.updateStatus)
      if (this.updateIcon) {
        formData.append('profile[icon]', this.updateIcon)
      }
      if (this.updateHeader) {
        formData.append('profile[header]', this.updateHeader)
      }
      this.$emit('update-profile',formData)
      this.updateNickname = ''
      this.updateStatus = ''
      this.updateIcon = null
      this.updateHeader = null
    },
    doCloseForm: function() {
       this.$emit("close-form")
    },
    switchIsActive: function(key) {
      this.isActive = key
      if (this.isActive === 'all') {
        this.$emit('set-user-posts', this.showUser)
      } else if (this.isActive === 'favorite') {
        this.$emit('set-favorite-posts', this.showUser)
      }
    }
  }
}
</script>

<style scoped>
.textarea {
  resize: none;
}
.tabs li:hover {
  background-color: ghostwhite;
}
</style>