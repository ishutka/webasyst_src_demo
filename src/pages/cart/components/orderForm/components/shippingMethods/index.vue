<template>
  <div class="wrapCheckoutFormDelivery">
    <div v-if="shippingMethods.length > 0" class="checkout-options">
      <legend>Способ доставки</legend>
      <div v-if="isOnlyIntime" class="alert alert-warning">
        В вашей корзине есть габаритные товары, поэтому их доставка возможна
        следующим образом:
        <ul>
          <li>Новая почта</li>
          <li>Самовывоз</li>
          <li>Курьер по Киеву</li>
        </ul>
        <hr />
        <strong>
          Отправка габаритных товаров почтовой службой Новая почта
          осуществляется только после предоплаты в размере 100%
        </strong>
      </div>
      <div
        v-for="method in shippingMethods"
        :key="method.id"
        class="checkoutDeliveryItem "
        :class="{ disabled: method.disabled }"
      >
        <div class="radio">
          <label
            class="col-form-label"
            :data-cy="`shippingMethod${method.plugin}_${method.id}`"
          >
            <img class="method-logo img-responsive" :src="method.logo" />
            <input
              v-model="shippingIdWrapper"
              type="radio"
              :value="method.id"
              :disabled="method.disabled"
            />
            <strong>{{ method.name }} </strong>
          </label>
        </div>

        <div
          class="shipping_description help-block"
          v-html="method.description"
        />
        <div v-if="method.id === shippingIdWrapper" class="ship_item_info">
          <NovaPoshta
            v-if="method.plugin === 'siteprofnovaposhta'"
            :shipping-id="method.id"
          />
          <ShippingAddress
            v-else-if="!method.name.toLowerCase().includes('самовывоз')"
            :method="method"
          />
        </div>
      </div>
    </div>
    <div v-else class="alert alert-danger">Список способов доставки пуст.</div>
  </div>
</template>
<script>
import NovaPoshta from './components/novaPoshta/index.vue';
import ShippingAddress from './components/shippingAddress/index.vue';
import { mapState, mapGetters, mapMutations } from 'vuex';
export default {
  computed: {
    ...mapGetters('cart', ['items', 'isOnlyIntime']),
    ...mapGetters('orderForm', ['shippingMethods']),
    ...mapState('orderForm', ['shipping_id']),
    shippingIdWrapper: {
      get() {
        return this.shipping_id;
      },
      set(id) {
        this.setShippingMethod(id);
      },
    },
  },
  methods: {
    ...mapMutations('orderForm', ['setShippingMethod']),
  },
  components: { NovaPoshta, ShippingAddress },
};
</script>
<style>
.checkoutDeliveryItem.disabled {
  opacity: 0.5;
}
.wrapCheckoutFormComment legend,
.wrapCheckoutFormDelivery legend {
  max-width: 250px;
}
#shop .dropdown-toggle {
  background: #fff;
  margin-bottom: 10px;
  padding: 0;
}
.wrapCheckoutFormDelivery .help-block {
  margin-left: 20px;
}
.wrapCheckoutFormDelivery,
.checkoutFormContact {
  margin-bottom: 40px;
}
.checkoutDeliveryItem,
.checkoutFormPayment {
  padding-left: 15px;
  margin-bottom: 20px;
}
.wrapCheckoutFormDelivery .radio,
.checkoutDeliveryItem .radio {
  padding-top: 0px;
}
.ship_item_info .wa-form {
  padding: 10px;
  margin-left: 10px;
  background: #ffffd9;
}
#shop .wrapCheckoutFormDelivery .form-control {
  margin: 0;
}
.wrapCheckoutFormDelivery .form-group {
  margin-bottom: 5px;
}
.wrapCheckoutFormDelivery .control-label,
.wrapCheckoutFormDelivery .control-label + div {
  width: 100%;
  text-align: left;
}
@media screen and (max-width: 500px) {
  .ship_item_info .wa-form {
    margin-left: 0px;
  }
  .checkoutDeliveryItem,
  .checkoutFormPayment {
    padding-left: 0px;
  }
}
</style>
