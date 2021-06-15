import '../../index.js';
import './index.css';
import '../../modules/globals/postsCategories/postsCategories.scss';
import Vue from 'vue';
import Vuex from 'vuex';
Vue.use(Vuex);
import store from '@/vuex/store';
import lazyImage from '@/modules/globals/lazyImage/index.vue';

new Vue({
  el: '.post-categories-tabs .tab-content',
  components: {
    lazyImage,
  },
  store,
});
