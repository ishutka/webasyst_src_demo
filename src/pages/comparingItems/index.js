import '../../index.js';

import './index.css';
import '../product/modules/reviews/index.css';
import 'fancybox/dist/js/jquery.fancybox.pack.js';
import 'fancybox/dist/css/jquery.fancybox.css';
import 'owl.carousel';
import 'owl.carousel/dist/assets/owl.carousel.css';
import 'owl.carousel/dist/assets/owl.theme.default.css';
import Vue from 'vue';
import store from '@/vuex/store';
import components from '@/components/globalComponentsList.js';
import IsUseful from '@/modules/review/components/isUseful/index.vue';
import CreatedReview from '@/modules/review/components/createdReview/index.vue';
import ReviewForm from '@/modules/review/components/reviewForm/index.vue';
import showFormBtn from '@/modules/review/components/showFormBtn/index.vue';
import PercentRating from '@/modules/review/components/percentRating/index.vue';
import ArrivedButton from '../product/modules/cartForm/components/cartForm/components/arrivedButton/index.vue';
import setLabelsForOwlCarouselDots from '@/helpers/setLabelsForOwlCarouselDots.js';

new Vue({
  el: '#container_white_bg',
  components: Object.assign(components, {
    IsUseful,
    CreatedReview,
    ReviewForm,
    showFormBtn,
    PercentRating,
    ArrivedButton,
  }),
  store,
});
$(() => {
  jQuery('.fancybox').fancybox();
  jQuery('#show_new_products_2').owlCarousel({
    navigation: true,
    navigationText: [
      "<span class='glyphicon glyphicon-chevron-left'></span>",
      "<span class='glyphicon glyphicon-chevron-right'></span>",
    ],
    responsive: {
      0: { items: 2 },
      375: { items: 3 },
      600: { items: 3 },
      700: { items: 3 },
      1024: { items: 3 },
    },
  });
  setLabelsForOwlCarouselDots('#show_new_products_2');
});
