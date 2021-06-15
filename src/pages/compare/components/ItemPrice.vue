<template>
  <div class="compare-page-price-block">
    <div v-if="product.avalaible">
      <span class="price nowrap"> {{ format(product.price) }} </span>
      <!-- <span v-if="priceUsd" class="usd_price nowrap">
        ({{ format(costUsd, 'USD') }})
      </span> -->
    </div>
    <button
      v-if="product.avalaible"
      type="button"
      class="btn  btn-success"
      :title="`Купить ${product.name}`"
      :disabled="!product.avalaible"
      data-cy="addToCartButton"
      @click="addToCartWrapper({ id: product.id })"
    >
      <span class="visible-xs">+ </span> <i class="fa fa-shopping-cart"> </i>
      <span class="hidden-xs">Купить</span>
      <div v-if="itemLoading" class="loader-image">
        <img
          src="/wa-apps/shop/themes/flip/img/loading16.gif"
          class="img-responsive "
        />
      </div>
    </button>
    <span v-else class="offers__availability">нет в наличии</span>
  </div>
</template>

<script>
import productMixin from '@/mixins/productMixin.js';
export default {
  mixins: [productMixin],
};
</script>

<style lang="scss">
.compare-page-price-block {
  .offers__availability {
    line-height: 4;
  }
  .loader-image img {
    margin: 0 3px;
  }
  .loader-image {
    display: inline-flex;
    align-items: center;
    width: 16px;
  }
  button > * {
    margin-right: 3px;
  }
  button i {
    margin-bottom: 3px;
  }
  button {
    padding: 3px 6px;
    display: inline-flex;
    justify-content: center;
    align-items: center;
  }
  @media screen and (max-width: 767px) {
    button {
      width: 65px;
      padding: 0;
      margin: 0 auto;
    }
    span.visible-xs {
      display: inline-block !important;
    }
  }
}
</style>
