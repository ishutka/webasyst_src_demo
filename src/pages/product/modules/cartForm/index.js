import './index.css';

import Vue from 'vue';

import store from '@/vuex/store';
import cartForm from './components/cartForm/index.vue';
import toCompareButton from './components/toCompareButton/index.vue';
if (document.querySelector('#product_page_cart'))
  new Vue({
    el: '#product_page_cart',
    store,
    components: { cartForm, toCompareButton },
  });
