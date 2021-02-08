<template>
<div>
  <section class="section" v-if="bookIsActive">
    <h4 class="title is-4 content-is-book">単語帳の完成形</h4>
    <p class="is-size-5">
      日本の「いろは歌」をヒントに、現代英語の重要単語1600語と重要熟語1000語を
      重複なしで560本の英文に凝縮させてあります。
      一つのセンテンスで平均約5個の単語・熟語が覚えられるため効率よく学習ができます。<br>
      音源もあるので語彙力向上にフルコミットできる単語帳です。<br>
      難易度は国公立大学を目指す受験生やTOEICで700点程度を目指す方にオススメです。
    </p>
  </section>
  <section class="section" v-if="loveIsActive">
    <h4 class="title is-4 content-is-love">全幅の信頼を寄せています</h4>
    <p class="is-size-5">
      単語帳の例文を読んで「おもしろい！」と思ったことはありますか？<br>
      DUOの例文にはナチュラルで暗記する価値のある英文が揃っています。
      ビジネスのひと場面、交通機関を利用するときに聞こえるあの放送、恋愛の修羅場など
      現実的な状況を切り取った英文になっています。<br>
      このDUOを、私は高校2年から10年以上愛用しています。全幅の信頼を寄せています。<br>
    </p>
  </section>
  <section class="section" v-if="hayashiIsActive">
    <h4 class="title is-4 content-is-hayashi">今でしょ！</h4>
    <p class="is-size-5">
      <a href="https://www.amazon.co.jp/dp/4900790052/ref=cm_sw_r_tw_dp_DWF9JQSTXDARXMTT38XT">さあ、はじめよう！</a>
      <br><br><br>
    </p>
  </section>
</div>
</template>

<script>
export default {
  props: {
    contentPart: String
  },
  data() {
    return {
      bookIsActive: true,
      loveIsActive: false,
      hayashiIsActive: false,
    }
  },
  watch: {
    contentPart: {
      handler: function(next) {
        if (next === 'isBook') {
          this.bookIsActive = true
          this.loveIsActive = false
          this.hayashiIsActive = false
        } else if (next === 'isLove') {
          this.bookIsActive = false
          this.loveIsActive = true
          this.hayashiIsActive = false
        } else if (next === 'isHayashi') {
          this.bookIsActive = false
          this.loveIsActive = false
          this.hayashiIsActive = true
        }
      },
    },
  },
}
</script>

<style scoped>
.section {
  background-color: whitesmoke;
}
.title {
  padding-left: 10px;
}
.content-is-book {
  border-left: 10px solid skyblue;
}
.content-is-love {
  border-left: 10px solid pink;
}
.content-is-hayashi {
  border-left: 10px solid lightgreen;
}
</style>