<template>
  <tr :data-cy="`product_${product.id}`" class="category-product">
    <td class="name">
      <strong>
        <a :href="`${product.frontend_url}`">{{ product.name }}</a>
      </strong>
    </td>

    <td
      v-for="(price, key) in getProductPrices(product)"
      :key="key"
      :data-cy="`price_${price.category_id}`"
      class="tc"
    >
      <strong v-if="price.category_id > 1">{{ format(price.price) }}</strong>
      <strong v-else>{{ format(price.price, 'UAH') }}</strong>
    </td>

    <td class="tc">
      <input
        v-model.number="quantityWrapper"
        :data-cy="`quantity_product_${product.id}`"
        type="number"
        min="1"
        class="form-control quantity input-sm "
      />
    </td>

    <td class="tc">
      <button
        :data-cy="`addToCartButton_${product.id}`"
        class=" btn btn-xs btn-success"
        @click="addProductWrapper({ id: product.id, quantity })"
      >
        <i class="fa fa-shopping-cart fa-1x"> </i>
      </button>
      <div
        v-if="requestResult === 'loading'"
        class="priselist_loader"
        data-cy="addToCartLoading"
      >
        <img
          src="/wa-apps/shop/themes/flip/img/loading16.gif"
          class="img-responsive"
        />
      </div>
      <div
        v-if="productInCart && productInCart.quantity"
        data-cy="addedToCartSuccess"
      >
        <span class="added_to_cart nowrap added_to_cart">
          <span class="glyphicon glyphicon-ok"></span>
          <span class="hidden-xs"> в корзине </span>({{
            productInCart.quantity
          }})шт
        </span>
      </div>
      <div v-if="requestResult === 'error'" data-cy="addedToCartError">
        ошибка... Попробуйте еще раз
      </div>
    </td>
  </tr>
</template>

<script>
import { mapActions, mapState, mapGetters } from 'vuex';

const product = {
  props: {
    product: {
      type: Object,
      required: true,
    },
  },
  created() {
    this.setProductData({
      ...this.product,
      skus: [{ id: this.product.sku_id }],
    });
  },
  data() {
    return {
      quantity: 1,
      requestResult: 'notStarted',
    };
  },
  computed: {
    ...mapGetters('pricelist', ['getProductPrices']),
    ...mapState('cart', { productsInCart: 'items' }),
    ...mapGetters('currency', ['format']),

    quantityWrapper: {
      get: function() {
        return this.quantity;
      },
      set: function(value) {
        this.quantity = value;
      },
    },
    productInCart() {
      return this.productsInCart.find(
        prod => +prod.product_id === this.product.id,
      );
    },
  },
  methods: {
    ...mapActions('products', ['addToCart', 'setProductData']),
    addProductWrapper(productObj) {
      this.requestResult = 'loading';
      this.addToCart(productObj).then(requestResult => {
        this.requestResult = requestResult;
      });
    },
  },
};
export default product;
</script>
<style lang="scss">
.category-product {
  .priselist_loader {
    display: inline-block;
    float: unset;
    margin: -5px 0;
    width: 18px;
  }
  .quantity {
    margin: 0px auto;
    width: 50px;
    text-align: right;
    padding: 5px;
  }
  .added_to_cart {
    font-style: italic;
    font-weight: bold;
    color: #0a3966;
  }
  @media screen and (min-width: 992px) and (max-width: 1180px) {
    td.name {
      max-width: 85px;
      font-size: 0.85em;
    }
    .added_to_cart .hidden-xs {
      display: none;
    }
  }
  @media screen and (max-width: 767px) {
  }
  @media screen and (max-width: 450px) {
    td.name {
      max-width: 85px;
    }
  }
}
</style>
