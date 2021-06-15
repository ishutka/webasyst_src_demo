import '../../index.js';

import './index.css';
import Vue from 'vue';
import store from '@/vuex/store';

import scrollController from './components/cart/scrollController.js';
import components from '@/components/globalComponentsList.js';
import pricelist from './components/pricelist/index.vue';
import cart from './components/cart/index.vue';
import logs from './components/logs/index.vue';

(async () => {
  //для того аби спочатку в нас прийшов запити, а потім відобразились всі компоненти, в хук запихнути це не можна бо виклик асинхронний
  await Promise.all([
    store.dispatch('cart/getCartData'),

    store.dispatch('productsLogs/fetchLogs'),
    store.dispatch('pricelist/getPriceData'),
  ]);
  $('#pricelistIsLoading').hide();
  new Vue({
    el: '#container_white_bg',
    components: Object.assign(components, {
      pricelist,
      logs,
      cart,
    }),
    store,
  });
  scrollController();
})();
