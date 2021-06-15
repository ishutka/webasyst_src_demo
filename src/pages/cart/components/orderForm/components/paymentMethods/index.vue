<template>
  <div class="wrapCheckoutFormDelivery">
    <div v-if="paymentMethods.length > 0" class="checkout-options">
      <div>
        <legend>Способ оплаты</legend>
        <div v-if="loading" class="loader-wrapper">
          <img
            src="/wa-apps/shop/themes/flip/img/loading16.gif"
            class="img-responsive col-md-1 col-lg-1"
            style="display:inline-block"
          />
        </div>

        <div
          v-for="method in paymentMethods"
          v-else
          :key="method.id"
          class="checkoutFormPayment"
        >
          <div class="radio">
            <label
              class="col-form-label"
              :data-cy="`paymentMethod${method.plugin}`"
            >
              <img :src="method.logo" class="method-logo img-responsive" />
              <input
                v-model="paymentWrapper"
                checked="paymentMethods.length == 1"
                :value="method.id"
                name="payment"
                type="radio"
              />
              <strong>{{ method.name }}</strong>
            </label>
          </div>
          <div class="help-block">{{ method.description }}</div>
        </div>
      </div>
    </div>
    <div v-else class="alert alert-danger">Список способов оплаты пуст.</div>
  </div>
</template>

<script>
import { mapState, mapMutations, mapActions } from 'vuex';
export default {
  created() {
    this.fetchPaymentMethods();
  },
  data() {
    return {
      loading: false,
    };
  },
  computed: {
    ...mapState('orderForm', ['payment_id', 'shipping_id', 'paymentMethods']),
    paymentWrapper: {
      get() {
        return this.payment_id;
      },
      set(payment_id) {
        this.setPaymentMethod(payment_id);
      },
    },
  },
  methods: {
    ...mapMutations('orderForm', ['setPaymentMethod']),
    ...mapActions('orderForm', ['fetchPaymentMethods']),
  },
  watch: {
    shipping_id() {
      this.fetchPaymentMethods();
    },
  },
};
</script>

<style></style>
