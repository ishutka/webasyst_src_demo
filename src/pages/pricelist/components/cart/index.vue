<template>
  <div
    id="panelPriceListCart"
    data-cy="cartInPricelist"
    class="panel panel-default"
    data-sticky-class="sticky"
    :data-sticky-for="991"
  >
    <div class="panel-heading">
      <span class="fa-stack fa-lg tc">
        <i class="fa fa-circle fa-stack-2x"></i>
        <i class="fa fa-shopping-cart fa-1x fa-inverse"> </i>
      </span>
      Корзина
    </div>
    <div class="panel-body" style="opacity: 1;">
      <div
        v-if="!items.length"
        class="alert alert-warning"
        data-cy="pricelist_cart_is_empty"
      >
        Ваша корзина пуста
      </div>
      <div class="cart_items" style="max-height: 730px;">
        <table class="table table-striped table-hover">
          <tbody>
            <Product
              v-for="product in items"
              :key="product.id"
              :product="product"
            ></Product>
          </tbody>
        </table>
      </div>
      <div style="margin-top: 10px" class="blank"></div>
      <div v-if="items.length">
        <p>
          <strong>{{ format(total) }}</strong>
        </p>
        <p class="tr">
          <a href="/cart/#siteprofQuickOrder" class="btn btn-success">
            Оформить заказ
          </a>
        </p>
      </div>
    </div>
  </div>
</template>

<script>
import { mapState, mapGetters } from 'vuex';
import Product from './product/index.vue';
const cart = {
  components: {
    Product,
  },
  computed: {
    ...mapState('cart', ['items', 'total']),
    ...mapGetters('currency', ['format']),
  },
};
export default cart;
</script>
<style lang="scss">
#panelPriceListCart {
  width: 100%;
  .panel-heading {
    background-image: -webkit-gradient(
      linear,
      left top,
      left bottom,
      from(#f5f5f5),
      to(#e8e8e8)
    );
    background-image: linear-gradient(to bottom, #f5f5f5 0%, #e8e8e8 100%);
    filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#fff5f5f5', endColorstr='#ffe8e8e8', GradientType=0 );
    background-repeat: repeat-x;
  }
}
</style>
