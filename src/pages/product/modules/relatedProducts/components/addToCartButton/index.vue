<template>
  <div>
    <button
      class="added2cart btn btn-success"
      :v-if="product.avalaible"
      @click="addToCartWrapper({ id: product.id })"
    >
      Купить
    </button>
    <span class="price nowrap" v-html="preparePrice(product.id, cost)" />
  </div>
</template>
<script>
import productMixin from '@/mixins/productMixin.js';

export default {
  mixins: [productMixin],
};
</script>
