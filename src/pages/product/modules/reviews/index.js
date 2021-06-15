import './index.css';
import Vue from 'vue';

import store from '@/vuex/store';
import reviewForm from '@/modules/review/components/reviewForm/index.vue';
import showFormBtn from '@/modules/review/components/showFormBtn/index.vue';
import isUseful from '@/modules/review/components/isUseful/index.vue';
import percentRating from '@/modules/review/components/percentRating/index.vue';
import createdReview from '@/modules/review/components/createdReview/index.vue';

new Vue({
  el: '#product-reviews',
  store,
  components: {
    isUseful,
    percentRating,
    createdReview,
    reviewForm,
    showFormBtn,
  },
});
