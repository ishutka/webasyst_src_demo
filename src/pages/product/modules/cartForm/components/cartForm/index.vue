<template>
  <div>
    <div class="price_plus_order">
      <div
        v-if="product.avalaible"
        class="col-xs-12 col-sm-6 col_product_price"
      >
        <span
          class="price nowrap"
          data-cy="total-product-price"
          v-html="preparePrice(product.id, cost)"
        >
        </span>
        <span v-if="sku.compare_price > 0" class="compare-at-price nowrap">
          {{ preparePrice(sku.id, sku.compare_price) }}
        </span>
        <!-- <span v-if="priceUsd" class="usd_price nowrap">
            ({{ format(costUsd, 'USD') }})
          </span> -->
      </div>

      <!-- TODO: Коля, @event frontend_product.%plugin_id%.cart -->

      <div
        v-if="product.avalaible"
        class="col-sm-6 col-xs-12 tr col_quickorder"
      >
        <QuickOrder
          :product-id="product.id"
          :cost="cost"
          :price="price"
          :prepare-price="preparePrice"
          :set-selected-param="setSelectedParam"
        />
        <!-- TODO:  Коля,  shopProductdayPlugin::display -->
      </div>
    </div>

    <div class="col-xs-12 col_product_stocks">
      <div v-if="!product.avalaible"><ArrivedButton :id="id" /></div>
      <div class="stocks">
        <strong v-if="product.avalaible" class="text_in_stock">
          <em> есть в наличии </em>
          <span v-if="sku.stock_poland">
            ,<br />
            доставка из Польши<br />
            в течении 7-14 рабочих дней
          </span>
        </strong>
        <strong v-else class="stock-none">
          <i class="icon16 stock-transparent"></i>Нет в наличии
        </strong>
      </div>
      <div v-if="product.skus.length && sku.sku">Артикул: {{ sku.sku }}</div>
      <div v-if="product.avalaible" class="blank"></div>
      <div
        v-if="
          product.skus.length > 1 ||
            (product.services.length && product.avalaible)
        "
        class="services"
      >
        <div v-if="product.skus.length > 1">
          <div v-for="sku in product.skus" :key="sku.id">
            <Radio v-model="sku_id" :value="sku.id" :disabled="!sku.count">
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
                  <em>нет в наличии</em>
                </span>
              </div>
            </Radio>
          </div>
        </div>
        <div v-if="product.avalaible">
          <div
            v-for="service in product.services"
            :key="service.id"
            class="form-group"
          >
            <Checkbox
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
                </span>
              </div>
            </Checkbox>
            <!-- Описание сервиса -->
            <div v-if="service.description" class="service-description">
              <div
                :class="{ opened: openedDescription === service.id }"
                v-html="service.description"
              />
              <a
                v-if="openedDescription === service.id"
                href="#"
                @click.prevent="toggleDescription(service.id)"
              >
                <i class="fa fa-angle-up"></i>
                свернуть
              </a>
              <a v-else href="#" @click.prevent="toggleDescription(service.id)">
                <i class="fa fa-angle-down"></i>
                подробнее
              </a>
              <div class="clearfix"></div>
            </div>
          </div>
        </div>
      </div>

      <form
        v-if="product.avalaible"
        class="form-horizontal addtocart"
        method="post"
        @submit="addToCartWrapper({ id: product.id })"
      >
        <div class="purchase">
          <div class="add2cart">
            <div class="row">
              <div class="col-xs-6 product_btn_cart_outer">
                <button
                  type="button"
                  class="btn btn-block btn-success"
                  :title="`Купить ${product.name}`"
                  :disabled="!product.avalaible || loading"
                  data-cy="addToCartButton"
                  @click="addToCartWrapper({ id: product.id })"
                >
                  <i class="fa fa-shopping-cart"> </i> Купить
                  <!-- 
                    <i v-if="loading" class="adding2cart icon16 loading"></i> 
                    закоментировал, потому что лоадер отображается при добавлении любого товара в корзину, не только этого
                   -->
                </button>
              </div>
              <div class="col-xs-6 quantity_outer">
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
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import { Checkbox, Radio } from 'vue-checkbox-radio';
import productMixin from '@/mixins/productMixin.js';
import QuickOrder from './components/QuickOrder/index.vue';
import ArrivedButton from './components/arrivedButton/index.vue';
import eventsBus from '../../../../../../eventsBus.js';
export default {
  data() {
    return {
      openedDescription: 0,
    };
  },
  created() {
    eventsBus.$emit('productPageView', {
      id: this.id,
      price: this.price,
      name: this.product.name,
    });
  },
  mounted() {
    // Проверяем, разме(высоту) описание доп.сервиса -
    //если короткое,то прячем ссылку для разворачивания
    const descriptionsArray = document.querySelectorAll(
      '.service-description>div:not(.clearfix)',
    );
    descriptionsArray.forEach(desc => {
      const height = desc.clientHeight;
      // Прячем ссылку (если высота <= двум строкам(line-height*2=36px))
      if (height <= 36) desc.nextElementSibling.classList.add('hidden');
    });
  },

  components: {
    Checkbox,
    Radio,
    QuickOrder,
    ArrivedButton,
  },
  mixins: [productMixin],
  methods: {
    toggleDescription(val) {
      if (this.openedDescription == 0) this.openedDescription = val;
      else this.openedDescription = 0;
    },
  },
};
</script>

<style lang="scss">
#cart-form {
  .skus_price {
    font-size: 12px;
    color: gray;
    font-weight: 400;
  }
  .price {
    font-size: 2em;
  }
  .fa-shopping-cart {
    margin-right: 3px;
  }
  .product_btn_cart_outer button {
    text-align: center;
    padding: 5px;
    font-size: 16px;
  }
  .product_service_description {
    font-size: 0.9em;
    color: #999999;
    padding: 10px;
    margin-top: 3px;
  }
  .radio-component div {
    display: inline-block;
    width: calc(100% - 30px);
  }
  .price_plus_order {
    display: flex;
    align-items: center;
  }
  .service_info {
    font-size: 16.8px;
  }
  .services {
    padding: 5px;
    border-radius: 5px;
    -moz-border-radius: 5px;
    -webkit-border-radius: 5px;
    background: #f8f7f3;
    padding-bottom: 0px;
  }

  .service-description {
    font-size: 12px;
    color: #333;
    padding: 0 10px 10px;
    > div:first-child {
      overflow: hidden;
      max-height: 40px;
      transition: all 0.4s ease;
      line-height: 18px;
    }
    > div.opened {
      max-height: 500px;
    }
    > a.hidden {
      display: none;
    }
    > a {
      margin-top: 10px;
      border-bottom: 1px dashed;
      float: right;
      line-height: 1;
      text-decoration: none;
    }
    i {
      font-size: 16px;
      vertical-align: middle;
      margin-right: 2px;
      font-weight: 700;
    }
  }
  .product_service_description_toggle {
    display: none;
  }
  .product_service_description_toggle_btn {
    font-size: 0.9em;
    border-bottom: 1px dotted;
    text-decoration: none;
  }
  .col_product_price {
    display: flex;
    flex-direction: column;
  }
  @media screen and (max-width: 500px) {
    .price_plus_order {
      flex-wrap: wrap;
    }
  }
}
</style>
