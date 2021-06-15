<template>
  <div v-if="discountCouponData.is_enabled" class="alert alert-warning">
    <div v-if="discountСoupon > 0" class="alert alert-success">
      Применён купон на скидку, на сумму: -
      <span v-html="format(discountСoupon)"></span>
    </div>

    <form class="form-inline" @submit.prevent="submit">
      <div class="form-group">
        <label class="control-label ">
          Купон на скидку (если есть):
        </label>
        <input
          type="text"
          class="form-control"
          name="coupon_code"
          :value="discountCouponData.coupon_code"
          @input="setCouponCodeWrapper"
        />
      </div>
      <button class="btn btn-success" type="submit">
        Применить
      </button>
      <img v-if="loading" :src="`${currentThemePath}img/loading16.gif`" />
    </form>
  </div>
</template>
<script>
import HTTP from '@/plugins/http';
import { mapState, mapGetters, mapMutations, mapActions } from 'vuex';
export default {
  computed: {
    ...mapState('cart', ['discountCouponData', 'loading', 'discountСoupon']),
    ...mapGetters('index', ['currentThemePath']),
    ...mapGetters('currency', ['format']),
  },
  methods: {
    setCouponCodeWrapper(e) {
      this.setCouponCode(e.currentTarget.value);
    },
    ...mapMutations('cart', ['setCouponCode', 'setLoading']),
    ...mapActions('cart', ['getCartData']),
    submit() {
      this.setLoading(true);
      HTTP.post('/cart/', {
        coupon_code: this.discountCouponData.coupon_code,
      }).then(this.getCartData);
    },
  },
};
</script>
