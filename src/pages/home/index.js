import '../../index.js';
import './index.css';
import './modules/category_home_page/category_home_page.scss';
import './modules/newArticles/index.scss';
import './modules/reviews/reviews.scss';

import './modules/reviews/reviews.js';
import './modules/newArticles/index.js';
import setLabelsForOwlCarouselDots from '@/helpers/setLabelsForOwlCarouselDots.js';
import 'owl.carousel';
import 'owl.carousel/dist/assets/owl.carousel.css';

if (jQuery('#home_slider').length) {
  jQuery('#home_slider').owlCarousel({
    items: 1,
    autoplay: true,
    autoplayTimeout: 9000,
    lazyLoad: true,
    loop: true,
  });
  setLabelsForOwlCarouselDots('#home_slider');
}
import Vue from 'vue';
import Vuex from 'vuex';
Vue.use(Vuex);
import store from '@/vuex/store';
import lazyImage from '@/modules/globals/lazyImage/index.vue';

if ($('#homecategories_plugin').length)
  new Vue({
    el: '#homecategories_plugin',
    components: {
      lazyImage,
    },
    store,
  });
