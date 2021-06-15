import Vue from 'vue';
import store from '@/vuex/store';
import Rating from './rating.vue';
const productsRatingArray = Array.from(
  document.querySelectorAll('.rating-stars-wrapper'),
);

if (productsRatingArray.length)
  productsRatingArray.forEach(el => {
    new Vue({
      el,
      components: { Rating },
      store,
    });
  });
