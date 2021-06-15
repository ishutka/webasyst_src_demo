<template>
  <button
    v-if="settingsAreLoaded"
    class="quickorder-custom-button default btn btn-lg btn-block  btn-success"
    type="button"
    data-cy="quickOrderButton"
    @click="showForm"
    v-html="buttonName"
  />
</template>
<script>
import { mapState, mapGetters, mapActions } from 'vuex';
import QuickOrderForm from './QuickOrderForm/index.vue';
export default {
  created() {
    this.fetchSettings();
  },
  props: {
    productId: {
      required: true,
      type: Number,
    },
    cost: {
      required: true,
      type: Number,
    },
    price: {
      required: true,
      type: Number,
    },
    preparePrice: {
      required: true,
      type: Function,
    },
    setSelectedParam: {
      required: true,
      type: Function,
    },
  },
  computed: {
    product() {
      return this.getProductById(this.productId);
    },
    ...mapGetters('products', ['getProductById']),
    ...mapState('quickOrder', ['buttonName', 'settingsLoaded']),
    ...mapGetters('quickOrder', ['settingsAreLoaded']),
  },
  methods: {
    ...mapActions('quickOrder', ['fetchSettings']),
    showForm() {
      let modalWidth = '100%';
      if (window.innerWidth > 450) modalWidth = '90%';
      if (window.innerWidth > 600) modalWidth = '500';
      if (window.innerWidth > 767) modalWidth = '700';
      this.$modal.show(QuickOrderForm, this.$props, {
        width: modalWidth,
        height: 'auto',
        name: 'container',
      });
      window.ga('send', 'event', 'checkout', 'openFormQuickOrder');
    },
  },
};
</script>
<style>
@media screen and (min-width: 1200px) {
  #product_page_cart .quickorder-custom-button {
    padding: 10px 5px;
  }
}
@media screen and (max-width: 500px) {
  #product_page_cart .quickorder-custom-button {
    padding: 10px 5px;
  }
}
</style>
