<template>
  <a href="/cart/" data-cy="miniCartInfo" class="cart-summary">
    <span class="fa-stack fa-lg tc">
      <i class="fa fa-circle fa-stack-2x"></i>
      <i class="fa fa-shopping-cart fa-1x fa-inverse"> </i>
    </span>
    <span class="cart-total" v-html="format(total)" />
  </a>
</template>

<script>
import { mapGetters, mapState } from 'vuex';

export default {
  computed: {
    ...mapState('cart', ['total']),
    ...mapGetters('currency', ['format']),
  },
};
</script>
