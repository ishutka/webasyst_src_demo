<template>
  <div>
    <div v-if="discountNumeric > 0" class="row">
      <div class="col-xs-6 col-sm-6 col-md-9 col-lg-9 tr">
        <strong>Скидка</strong>
      </div>
      <div class="col-xs-6 col-sm-6 col-md-2 col-lg-2  tc ">
        -
        <span class="nowrap cart-discount " v-html="format(discountNumeric)" />
      </div>
    </div>

    <div class="row">
      <div class="col-xs-6 col-sm-6 col-md-9 col-lg-9 tr">
        <strong>
          Итого за товары
          <span v-if="discountСoupon > 0">
            (с учетом купона на скидку)
          </span>
        </strong>
      </div>
      <div class="col-xs-6 col-sm-6 col-md-2 col-lg-2  tc total">
        <span
          class="nowrap cart-total total"
          v-html="format(itemsTotal - discountNumeric)"
        />
      </div>
    </div>
  </div>
</template>
<script>
import { mapState, mapGetters } from 'vuex';

export default {
  computed: {
    ...mapState('cart', ['total', 'discountNumeric', 'discountСoupon']),
    ...mapGetters('currency', ['format']),
    ...mapGetters('cart', ['itemsTotal']),
  },
};
</script>
