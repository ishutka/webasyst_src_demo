<template>
  <button
    class="added2cart btn btn-success"
    :disabled="!product.avalaible"
    @click="addToCartWrapper({ id: product.id })"
  >
    Купить
  </button>
</template>
<script>
import productMixin from '@/mixins/productMixin.js';

export default {
  mixins: [productMixin],
};
</script>
