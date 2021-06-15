<template>
  <div v-if="votesSuma >= 1" class="percent">
    {{ number }}% пользователей считают этот отзыв полезным
  </div>
</template>

<script>
const percentRating = {
  props: {
    isGood: {
      type: Number,
      default: 0,
    },
    isBad: {
      type: Number,
      default: 0,
    },
  },
  computed: {
    votesSuma() {
      return this.isGood + this.isBad;
    },
    number() {
      const percent = (this.isGood / this.votesSuma) * 100;
      return Math.round(percent);
    },
  },
};
export default percentRating;
</script>
<style>
.percent {
  line-height: 1em;
  color: #777;
}
</style>
