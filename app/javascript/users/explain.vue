<template>
<section class="section">
  <h4 class="title is-4">単語帳の完成形</h4>
  <p class="is-size-5">
    日本の「いろは歌」をヒントに、現代英語の重要単語1600語と重要熟語1000語を
    重複なしで560本の英文に凝縮させてあります。
    一つのセンテンスで平均約5個の単語・熟語が覚えられるため効率よく学習ができます。<br>
    音源もあるので語彙力向上にフルコミットできる単語帳です。<br>
    難易度は国公立大学を目指す受験生やTOEICで700点程度を目指す方にオススメです。
  </p>
</section>
</template>

<script>
export default {
  props: {
    modalContent: String
  },
  emits: [
    'do-close-explain-modal'
  ],
  computed: {
    isModalActive: function() {
      if (this.modalContent) {
        return true
      } else {
        return false
      }
    }
  },
  methods: {
    doCloseExplainModal: function() {
      this.$emit('do-close-explain-modal')
    }
  }
}
</script>

<style scoped>
.section {
  border: 1px solid black;
  /* height: 30vh; */
}
</style>