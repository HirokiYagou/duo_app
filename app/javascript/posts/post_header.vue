<template>
<div>
  <p>{{ showUsername }}さん</p>
  <button class="button" @click="doEditProfile" v-if="showUsername === current_user_name">Edit Profile</button>

  <div :class="['modal', {'is-active': profileActive}]">
    <div class="modal-background" @click.self="doCloseForm"></div>
    <div class="modal-content">
      <p>たまプラーザ</p>
    </div>
    <button class="modal-close is-large" aria-label="close" @click.self="doCloseForm"></button>
  </div>
</div>
</template>

<script>
export default {
  props: {
    current_user_name: String,
    profileActive: Boolean,
    showUsername: {
      type: String,
      required: true,
    },
  },
  methods: {
    doEditProfile: function() {
      this.$emit("do-edit-profile")
    },
    doCloseForm: function() {
       this.$emit("close-form")
    }
  }
}
</script>