<template>
  <div v-show="isShow" id="cartFormDouble-component" class="row">
    <div v-if="product.avalaible" class="price_plus_order">
      <div class="col-xs-6 col_product_price">
        <span class="price nowrap">
          {{ preparePrice(0, cost) }}
        </span>
        <span v-if="product.compare_price > 0" class="compare-at-price nowrap">
          {{ preparePrice(product.id, product.compare_price) }}
        </span>
        <!-- <span v-if="priceUsd" class="usd_price nowrap">
          ({{ format(costUsd, 'USD') }})
        </span> -->
        <br />
        <strong class="text_in_stock">
          <em> есть в наличии </em>
        </strong>
      </div>
      <!-- TODO: Коля, @event frontend_product.%plugin_id%.cart  -->
      <div class="col-sm-6 col_quickorder">
        <QuickOrder
          :product-id="product.id"
          :cost="cost"
          :price="price"
          :prepare-price="preparePrice"
          :set-selected-param="setSelectedParam"
        />
        <!-- TODO: Коля, shopProductdayPlugin::display -->
      </div>
    </div>

    <div v-if="!product.avalaible" class="price_plus_order">
      <div class="col-xs-12">
        <strong class="stock-none">
          <i class="icon16 stock-transparent"></i>
          Нет в наличии
        </strong>
        <ArrivedButton :id="id" />
        <br />
      </div>
    </div>

    <div v-if="product.avalaible" class="col-xs-12 col_product_stocks">
      <div v-if="product.skus.length && sku.sku">Артикул: {{ sku.sku }}</div>
      <div class="stocks ">
        <div class="services">
          <div v-for="sku in product.skus" :key="sku.id">
            <Radio
              v-if="product.skus.length > 1"
              v-model="sku_id"
              :value="sku.id"
              :disabled="!sku.count"
            >
              <div>
                <span>
                  {{ sku.name }}
                  <span v-if="sku.sku">({{ sku.sku }})</span>
                </span>
                <span class="skus_price">
                  {{ preparePrice(0, getPrice(sku)) }}
                </span>
                <!-- <span v-if="priceUsd" class="usd_price nowrap">
                  ({{ format(getPriceUsd(sku), 'USD') }})
                </span> -->
                <span v-if="!sku.count" class="stock-none">
                  <em> нет в наличии </em>
                </span>
              </div>
            </Radio>
          </div>
          <div
            v-for="service in product.services"
            :key="service.id"
            class="form-group"
          >
            <Checkbox
              v-if="product.services.length > 0"
              v-model="selected.services"
              :value="service.variant_id"
              required
            >
              <span class="button-checkbox bootstrap-checkbox">
                <span class="icon glyphicon glyphicon-unchecked"></span>
                <span class="icon glyphicon glyphicon-check"></span>
              </span>
              <div>
                <span class="service_info">
                  {{ service.name }} <br />
                  <span class="service-price">
                    + {{ preparePrice(0, getPrice(service)) }}
                  </span>
                  <!-- <span v-if="priceUsd" class="usd_price nowrap">
                    ({{ format(getPriceUsd(service), 'USD') }} )
                  </span> -->
                </span>
              </div>
            </Checkbox>
          </div>
        </div>
      </div>

      <form class="form-horizontal addtocart" method="post">
        <div class="purchase">
          <div class="add2cart row">
            <div class="col-xs-8 col-sm-9 col-md-8  product_btn_cart_outer">
              <button
                type="button"
                class="btn btn-block btn-success"
                :title="`Купить ${product.name}`"
                :disabled="!product.avalaible || loading"
                @click="addToCartWrapper({ id: product.id })"
              >
                <i class="fa fa-shopping-cart "> </i> Купить
                <!-- 
                    <i v-if="loading" class="adding2cart icon16 loading"></i> 
                    закоментировал, потому что лоадер отображается при добавлении любого товара в корзину, не только этого
                   -->
              </button>
            </div>
            <div class="col-xs-4 col-sm-3 col-md-4 quantity_outer">
              <div class="qty">
                <input
                  v-model.number="quantityWrapper"
                  type="number"
                  min="1"
                  class="form-control"
                  aria-label="количество"
                />
              </div>
            </div>
          </div>
        </div>
      </form>
    </div>
    <div class="clearfix"></div>
  </div>
</template>

<script>
import QuickOrder from '../../../cartForm/components/cartForm/components/QuickOrder/index.vue';
import ArrivedButton from './components/arrivedButton/index.vue';

import { Checkbox, Radio } from 'vue-checkbox-radio';
import productMixin from '@/mixins/productMixin.js';
const productCartFormDouble = {
  components: { Checkbox, Radio, QuickOrder, ArrivedButton },
  mixins: [productMixin],
  data() {
    return { isShow: false };
  },
  created() {
    window.addEventListener('scroll', this.handleScroll);
  },
  destroyed() {
    window.removeEventListener('scroll', this.handleScroll);
  },

  methods: {
    handleScroll() {
      const product_page_cart = document.getElementById('product_page_cart');
      const position = product_page_cart.getBoundingClientRect();
      this.isShow = position.bottom < 0; //TODO: isShown or isVisible or hiden
    },
  },
};
export default productCartFormDouble;
</script>
<style lang="scss">
#cartFormDouble-component {
  .col_product_stocks > div:first-child {
    text-align: left;
    margin-top: 10px;
  }
  .col_product_price {
    line-height: 20px;
    text-align: left;
  }
  .radio-component div {
    display: inline-block;
    width: calc(100% - 30px);
  }
  .services .radio-component {
    padding-left: 0;
    margin-left: -2px;
  }
  .services .button-checkbox {
    margin-left: -4px;
  }
  .price {
    font-size: 1.5em;
  }
  .stocks > div:first-child {
    margin-top: 5px;
  }
  .fa-shopping-cart {
    margin-right: 3px;
  }
  .product_btn_cart_outer button {
    text-align: center;
    padding: 5px;
    font-size: 16px;
  }
  .form-group {
    margin-bottom: 0;
  }
  .form-control {
    padding: 0;
    padding-left: 10px;
  }
  .col_quickorder button {
    padding: 10px 0;
  }
}
</style>
