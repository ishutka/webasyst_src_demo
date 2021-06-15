import 'owl.carousel';
import 'owl.carousel/dist/assets/owl.carousel.css';
import Vue from 'vue';
import Vuex from 'vuex';
Vue.use(Vuex);
import store from '@/vuex/store';
import lazyImage from '@/modules/globals/lazyImage/index.vue';
import setLabelsForOwlCarouselDots from '@/helpers/setLabelsForOwlCarouselDots.js';

if ($('#index_reviews').length > 0) {
  new Vue({
    el: '#homecategories_blog_plugin .home-reviews-wrapper',
    components: {
      lazyImage,
    },
    store,
  });
  $('#index_reviews')
    .addClass('owl-carousel')
    .owlCarousel({
      responsive: {
        0: { items: 1 },
        650: { items: 2 },
        1200: { items: 3 },
      },
      nav: true,
      navText: ['<i class="icon-014-left"/>', '<i class="icon-015-right"/>'],
      margin: 30,
    });
  setLabelsForOwlCarouselDots('#index_reviews');
}
