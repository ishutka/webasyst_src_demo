import '../../index.js';
import './index.scss';
import '@/modules/globals/postsCategories/postsCategoriesMenu.scss';
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
