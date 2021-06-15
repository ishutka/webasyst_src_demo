import Vue from 'vue';

import store from '@/vuex/store';

import filters from './index.vue';
import modalMixin from '@/mixins/modalMixin.js';
import VueRouter from 'vue-router';
Vue.use(VueRouter);
import { mapState } from 'vuex';
const filtersLinks = document.querySelector('#filtersLinks');
const filtersBlock = document.querySelector('#categoryFilters');
let delay = 0;
if (window.Cypress) delay = 4000;
if (filtersBlock)
  setTimeout(() => {
    if (filtersLinks) filtersBlock.removeChild(filtersLinks);
    const router = new VueRouter({
      routes: [],
      mode: 'history',
    });
    new Vue({
      el: '#categoryFilters',
      mixins: [modalMixin],
      components: {
        filters,
      },
      computed: {
        ...mapState('category', ['filters']),
      },
      store,
      router,
    });
  }, delay);
