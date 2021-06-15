import './listThumbs.scss';
import loadSwitchers from './components/viewSwitcher/index.js';
import arrivedButton from './components/arrivedButton/index.vue';
import addToCartButton from './components/addToCartButton/index.vue';
import compareProduct from '../../compare/components/compareButton/index.vue';
import toCompareButton from '../../compare/components/toCompareButton/index.vue';
import filteredCount from '../../../pages/category/modules/filters/components/filteredCount.vue';
import modalMixin from '@/mixins/modalMixin.js';
import priceFormat from '@/components/priceFormat/index.vue';
import lazyImage from '../lazyImage/index.vue';
import rating from '../rating/rating.vue';
import Vue from 'vue';
import store from '@/vuex/store';
let instance = null;
const initApp = () => {
  instance = new Vue({
    el: '#listThumbs',
    mixins: [modalMixin],
    components: {
      arrivedButton,
      compareProduct,
      toCompareButton,
      addToCartButton,
      lazyImage,
      filteredCount,
      rating,
      priceFormat,
    },
    store,
    mounted() {
      // Ф-ция устанавливает слушателя на элементы внутри( и не только) экземпляра вью
      loadSwitchers();
    },
    computed: {
      ...mapState('products', ['listThumbsIsLoading']),
      ...mapState('category', ['filters']),
      ...mapGetters('category', ['selectedFiltersArray']),
    },
    methods: {
      ...mapMutations('category', ['toggleMobileFiltersAreOpened']),
      showMobileSorting() {
        if (window.innerWidth < 992) this.show('sortModal');
      },
    },
  });
};
const destroyApp = () => {
  if (instance) instance.$destroy();
};
import eventBus from '@/eventsBus';
import { mapState, mapGetters, mapMutations } from 'vuex';
eventBus.$on('listThumbsBeforeUpdate', destroyApp);
eventBus.$on('listThumbsIsUpdated', initApp);
if (document.querySelector('#listThumbs')) initApp();
else console.warn('#listThumbs is undefined');
