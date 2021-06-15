<template>
  <span class="price-format">
    <slot name="before"></slot>
    <span v-if="code == 'USD'" class="usd-sign">$</span>
    {{ price }}
    <span v-if="code == 'UAH'" class="uah-sign">грн</span>
  </span>
</template>
<script>
import { mapState } from 'vuex';
export default {
  props: {
    price: { type: Number, required: true },
  },
  computed: {
    ...mapState('currency', ['code']),
  },
};
</script>
<style lang="scss">
.price-format {
  .uah-sign {
    font-size: 14px;
  }
}
</style>
