import '../../index.js';
import './index.css';

import Vue from 'vue';
import store from '@/vuex/store';
import components from '@/components/globalComponentsList.js';
import FeedbackForm from './components/FeedbackForm/index.vue';

new Vue({
  el: '#container_white_bg',
  components: Object.assign(components, {
    FeedbackForm,
  }),
  store,
});
