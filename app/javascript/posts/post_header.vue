<template>
<div>
  <button class="button" @click="doEditProfile">Edit Profile</button>

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
    profileActive: Boolean,
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