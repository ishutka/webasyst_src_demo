import Vue from 'vue';
import store from '@/vuex/store';
import cartFormDouble from './components/cartFormDouble/index.vue';
new Vue({
  el: '#cartFormDouble',
  store,
  components: { cartFormDouble },
});
