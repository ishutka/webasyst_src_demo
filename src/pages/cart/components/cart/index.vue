<template>
  <div data-cy="cartAtCartPage">
    <div class="blank"></div>
    <h3>Корзина</h3>

    <div v-if="cartIsLoading && !items.length" class="loader-image ">
      <img
        :src="`${currentThemePath}img/loading16.gif`"
        class="img-responsive"
      />
    </div>
    <div v-else>
      <div v-if="!items.length" class="alert alert-warning">
        Ваша корзина пуста
      </div>
      <div v-if="items.length > 0">
        <div class="cart_items">
          <Product
            v-for="product in items"
            :key="product.id"
            :product="product"
          ></Product>
        </div>
        <cartTotal />
        <voucher-form></voucher-form>
      </div>
    </div>
  </div>
</template>

<script>
import voucherForm from './voucherForm/index.vue';

import { mapState, mapGetters } from 'vuex';
import Product from './product/index.vue';
import cartTotal from './cartTotal/index.vue';
export default {
  components: {
    Product,
    cartTotal,
    voucherForm,
  },
  computed: {
    ...mapGetters('index', ['currentThemePath']),
    ...mapGetters('cart', ['items']),
    ...mapState('cart', ['loading', 'cartIsLoading']),
  },
};
</script>

<style lang="scss">
[data-cy='cartAtCartPage'] {
  h3,
  .loader-image {
    display: inline-block;
  }
  .loader-image {
    vertical-align: middle;
    width: 22px;
    margin: 0 10px 10px;
  }
  .alert-warning {
    margin-right: 15px;
  }
}
</style>
