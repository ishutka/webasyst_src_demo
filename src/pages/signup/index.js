import '../../index.js';

import Vue from 'vue';

import store from '@/vuex/store';
import components from '@/components/globalComponentsList.js';

new Vue({
  el: '#container_white_bg',
  components: Object.assign(components, {}),
  store,
});
