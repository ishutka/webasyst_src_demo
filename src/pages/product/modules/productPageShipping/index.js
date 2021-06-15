import './index.css';
import Vue from 'vue';

import store from '@/vuex/store';
import QuickShipping from './components/QuickShipping/index.vue';
if (document.querySelector('#product_page_shipping'))
  new Vue({
    el: '#quick-shipping',
    store,
    components: {
      QuickShipping,
    },
  });
