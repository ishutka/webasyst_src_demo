<template>
  <div
    :data-cy="`product_in_cart_${product.product_id}`"
    class="product_in_cart"
  >
    <div>
      <a :href="product.frontend_url" class="col-xs-4 col-sm-2 item-thumb">
        <img class="img-responsive" :src="product.image_url" />
      </a>
      <div class="col-xs-8 col-sm-5 col-md-5 col-lg-6 item-name">
        <a class="bold" :href="product.frontend_url">
          {{ product.name }}
        </a>
        <span
          v-if="product.product.only_intime === 1"
          class="label label-warning"
        >
          Для доставки требуется специальная упаковка
        </span>
        <div
          v-for="service in product.all_services"
          :key="service.id"
          class="form-group services"
        >
          <Checkbox
            v-model="selectedServiceVariants"
            :value="service.variant_id"
            required
          >
            <span class="button-checkbox bootstrap-checkbox">
              <span class="icon glyphicon glyphicon-unchecked"></span>
              <span class="icon glyphicon glyphicon-check"></span>
            </span>
            <span class="service_info">
              {{ service.name }} <br />

              <span class="service-price"> {{ format(service.price) }} </span>
            </span>
          </Checkbox>
        </div>
      </div>
      <div class="count-row col-xs-12 col-sm-5  col-lg-4">
        <input
          :id="`product_input_${product.product_id}`"
          v-model.number="quantityWrapper"
          class="tc form-control input-sm "
          :disabled="loading"
          type="number"
          min="1"
        />

        <div class="tc item-thumb">
          <span class="nowrap price item-total">{{
            format(product.total)
          }}</span>
        </div>

        <div v-if="loading" class="loader-image">
          <img
            src="/wa-apps/shop/themes/flip/img/loading16.gif"
            class="img-responsive "
          />
        </div>
        <div
          v-else
          :data-cy="`deleteFromCart_${product.product_id}`"
          class=" item-remove"
          @click="deleteFromCartWrapper"
        >
          <a class="delete btn btn-xs btn-success" title="Удалить из корзины">
            <i class="fa fa-close"></i>
          </a>
        </div>
      </div>
    </div>
    <div class="clearfix hr"><hr /></div>
  </div>
</template>

<script>
import { Checkbox } from 'vue-checkbox-radio';
import productInCartMixin from '@/mixins/productInCartMixin.js';
export default {
  mixins: [productInCartMixin],
  components: { Checkbox },
};
</script>
<style lang="scss">
/*cкроем vue-checkbox*/
#shop .checkbox-component > input + label > .input-box {
  display: none;
}
/*----end cкроем vue-checkbox*/
#shop .checkbox-component > input:checked + label .button-checkbox {
  background: #48a951;
}
#shop .checkbox-component > input + label .glyphicon-check {
  display: none;
  color: #fff;
}
#shop .checkbox-component > input:hover + label .glyphicon-unchecked {
  color: red;
}
#shop .checkbox-component > input:checked + label .glyphicon-unchecked {
  display: none;
}
#shop .checkbox-component > input:checked + label .glyphicon-check {
  display: inline-block;
}
/* ---- */

.cart_items .product_in_cart:last-child {
  margin-bottom: 30px;
}
.cart_items .product_in_cart:last-child hr {
  display: none;
}

.product_in_cart {
  .services label {
    padding-left: 0px;
    width: 100%;
  }
  .services .button-checkbox {
    float: left;
    padding: 3px 4px 0;
    border-radius: 3px;
    font-size: 12px;
    color: #333;
  }

  .services .service_info {
    line-height: 110%;
    display: inline-block;
    cursor: pointer;
    margin-left: 5px;
    color: #669933;
    text-align: left;
    max-width: calc(100% - 30px);
  }

  .loader-image {
    display: flex;
    align-items: center;
    width: 23px;
  }
  img {
    width: 100%;
  }
  .input-sm {
    height: 30px;
    padding: 5px 10px;
    font-size: 12px;
    line-height: 1.5;
    border-radius: 3px;
    max-width: 80px;
    min-width: 50px;
    width: 22%;
  }
  .item-name a {
    display: inline-block;
    margin-bottom: 15px;
  }
  .count-row {
    display: flex;
    justify-content: space-between;
  }
  .item-thumb {
    display: block;
    padding-left: 0;
  }
  .hr {
    padding-left: 0px;
    width: 100%;
  }
  > div:first-child {
    display: flex;
    align-items: center;
    flex-wrap: wrap;
  }
  .form-group {
    margin-bottom: 0;
  }
  @media screen and (max-width: 767px) {
    .count-row {
      margin-top: 7px;
      padding-left: 0;
    }
    .item-thumb {
      min-width: 80px;
      max-width: 200px;
      padding: 0;
    }
  }
  @media screen and (max-width: 430px) {
    .count-row .input-sm {
      padding: 0;
    }
  }
}
</style>
