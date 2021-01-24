<template>
<div>
  <p>{{ showUsername }}さん</p>
  <button class="button" @click="doEditProfile" v-if="showUsername === current_user.name">Edit Profile</button>

  <div :class="['modal', {'is-active': profileActive}]">
    <div class="modal-background" @click.self="doCloseForm"></div>
    <div class="modal-content">
      <div class="box">
        <div class="content">
          <form @submit.prevent="doPost">
            <div class="field">
              <div class="field-label">
                <label class="label">Nickname</label>
              </div>
              <div class="field-body">
                <div class="field">
                  <p class="control">
                    <input class="input" name="nickname" type="email" placeholder="名前" required>
                  </p>
                </div>
              </div>
            </div>
            <div class="field">
              <label class="label">Status</label>
              <textarea
                name="status"
                class="textarea is-medium"
                placeholder="自己紹介"
                cols="30"
                rows="5"
                autofocus
                required></textarea>
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
    showUsername: {
      type: String,
      required: true,
    },
  },
  data() {
    return {
    }
  },
  methods: {
    doEditProfile: function() {
      this.$emit("do-edit-profile")
    },
    doCloseForm: function() {
       this.$emit("close-form")
    },
    selectImage: function(e) {
      const files = e.target.files
      this.uploadImage = files[0]
    },
  }
}
</script>