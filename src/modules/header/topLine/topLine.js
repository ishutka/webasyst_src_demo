import Vue from 'vue';
import Vuex from 'vuex';
Vue.use(Vuex);
import store from '@/vuex/store';
import miniCartInfo from './components/miniCartInfo/index.vue';
import userButtons from './components/userButtons/index.vue';

new Vue({
  el: '#top_line',
  components: {
    miniCartInfo,
    userButtons,
  },
  store,
});
