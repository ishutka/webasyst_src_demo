<template>
  <tr :id="`product_in_cart_${product.product_id}`" class="priceListCart_item">
    <td>
      <div>
        <a :href="`${product.frontend_url}`">{{ product.product_name }}</a>
      </div>
      <div class="info_table">
        <div>
          <input
            :id="`product_input_${product.product_id}`"
            v-model.number="quantityWrapper"
            :disabled="loading"
            class=" form-control input-sm priceListCart_quantity"
            type="number"
            min="1"
          />
        </div>
        <div v-if="loading" class="pricelist_loader">
          <img
            src="/wa-apps/shop/themes/flip/img/loading16.gif"
            class="img-responsive"
          />
        </div>
        <div>
          <span>{{ product.full_price }} </span>
        </div>
        <div>
          <button
            :data-cy="`deleteFromCart_${product.product_id}`"
            class="delete btn btn-xs btn-default act_tooltip"
            @click="deleteFromCartWrapper"
          >
            <i class="fa fa-close"></i>
          </button>
        </div>
      </div>
    </td>
  </tr>
</template>

<script>
import productInCartMixin from '@/mixins/productInCartMixin.js';
export default {
  mixins: [productInCartMixin],
};
</script>
<style lang="scss">
.priceListCart_item {
  .pricelist_loader {
    margin: 0 -18px;
    width: 20px;
  }
  td {
    padding: 10px 3px !important;
  }
  .input-sm {
    width: 50px;
    float: left;
    text-align: right;
    padding: 5px;
  }
  .info_table > div:first-child {
    justify-self: flex-start;
  }
  .info_table {
    display: flex;
    justify-content: space-between;
    max-width: 650px;
    padding: 10px 50px 10px 5px;
    align-items: center;
  }
  @media screen and (min-width: 992px) {
    .info_table {
      padding-right: 30px;
    }
  }
}
</style>
