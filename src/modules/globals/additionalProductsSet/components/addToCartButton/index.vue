<template>
  <button
    type="button"
    class="btn  btn-success"
    :aria-label="`Купить ${product.name}`"
    :disabled="!product.avalaible"
    @click="addToCartWrapper({ id: product.id })"
  >
    <i class="icon-001-cart"></i>
    <div v-if="requestIsLoading" class="loader-image">
      <img
        src="/wa-apps/shop/themes/flip/img/loading16.gif"
        class="img-responsive "
      />
    </div>
  </button>
</template>
<script>
import productMixin from '@/mixins/productMixin.js';

export default {
  mixins: [productMixin],
};
</script>
