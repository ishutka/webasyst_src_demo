<template>
  <img v-lazy="{ src, loading, error }" :alt="alt" />
</template>

<script>
// import VueLazyload from 'vue-lazyload/src/index.js';
import VueLazyload from './src/index.js';
import Vue from 'vue';
import { currentThemePath } from '@/helpers/path.js';

Vue.use(VueLazyload, {
  lazyComponent: true,
  attempt: (window.Cypress === true && 1) || 3,
  loading: `${currentThemePath}img/loader.gif`,
});

import { mapGetters } from 'vuex';
export default {
  props: {
    error: { type: String, default: '' },
    src: { type: String, required: true },
    alt: { type: String, required: true },
  },
  computed: {
    ...mapGetters('index', ['currentThemePath']),
    loading() {
      return `${this.currentThemePath}/img/loader.gif`;
    },
  },
};
</script>
