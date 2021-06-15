import 'fancybox';

import arrivedButton from '@/modules/globals/listThumbs/components/arrivedButton/index.vue';
import addToCartButton from '@/modules/globals/listThumbs/components/addToCartButton/index.vue';
import productArrivedInit from '@/components/productArrivedForm/index.vue';
import compareProduct from '@/modules/compare/components/compareButton/index.vue';
import toCompareButton from '@/modules/compare/components/toCompareButton/index.vue';
import lazyImage from '@/modules/globals/lazyImage/index.vue';

import Vue from 'vue';
import store from '@/vuex/store';
import { mapState } from 'vuex';
if (document.querySelectorAll('.pbfButton').length > 0) {
  const initApp = () => {
    setTimeout(() => {
      new Vue({
        el: '#productsByFeatures',
        components: {
          arrivedButton,
          productArrivedInit,
          compareProduct,
          toCompareButton,
          addToCartButton,
        },
        store,
        computed: {
          ...mapState('products', ['listThumbsIsLoading']),
        },
      });
    }, 0);
  };
  new Vue({
    el: '.pbfButton',
    components: {
      lazyImage,
    },
    store,
  });
  jQuery(document).on('click', '.pbfButton', function() {
    const btn = jQuery(this);
    jQuery.fancybox.open({
      href: btn.attr('data-href'),
      type: 'ajax',
      width: 100,
      afterShow: initApp,
    });
  });
}
