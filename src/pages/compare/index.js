import '../../index.js';
import './index.css';

import Vue from 'vue';
import store from '@/vuex/store';
import components from '@/components/globalComponentsList.js';
import deleteButton from './components/deleteButton.vue';
import ItemPrice from './components/ItemPrice.vue';

new Vue({
  el: '#container_white_bg',
  components: Object.assign(components, {
    deleteButton,
    ItemPrice,
  }),
  store,
});
