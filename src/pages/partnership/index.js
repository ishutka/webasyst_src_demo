import '../../index.js';

import './index.scss';
import partnership from './components/index.vue';
import components from '@/components/globalComponentsList.js';
import store from '@/vuex/store';
import Vue from 'vue';

new Vue({
  el: '#partner-ship-vue',
  components: Object.assign(components, {
    partnership,
  }),
  store,
});
