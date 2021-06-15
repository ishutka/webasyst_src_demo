import Vue from 'vue';
import store from '@/vuex/store';
import components from '@/components/globalComponentsList.js';
import '../../index.js';

import cart from './components/cart/index.vue';
import orderForm from './components/orderForm/index.vue';
import recommendedProducts from './components/recommendedProducts/index.vue';

store.dispatch('cart/getCartData');
new Vue({
  el: '#content-wrapp',
  components: Object.assign(components, {
    cart,
    orderForm,
    recommendedProducts,
  }),
  store,
});

window.ga('send', 'event', 'checkout', 'visitToCartPage');
