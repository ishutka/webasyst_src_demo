import '../../index.js';
import './index.css';

import '../../modules/globals/news/news.css';
import './modules/subCategories/index.css';
import '../../modules/globals/listThumbs/listThumbs.js';
import './modules/categoryAvtokraskaFilters/index.css';
import './modules/categoryAvtokraskaFilters/index.js';
import './modules/categoryHub/index.css';
import './modules/categoryHub/index.js';
import './modules/articles/index.css';
import './modules/filtersLinks/index.css';

import './modules/filters/index.js';

import store from '@/vuex/store';
import Vue from 'vue';
import lazyImage from '@/modules/globals/lazyImage/index.vue';

if (document.querySelector('.categories_banner'))
  new Vue({
    el: '.categories_banner',
    components: {
      lazyImage,
    },
    store,
  });
if (document.querySelector('.hub_sub-categories'))
  new Vue({
    el: '.hub_sub-categories',
    components: {
      lazyImage,
    },
    store,
  });
if (document.querySelector('.categoryNews'))
  new Vue({
    el: '.categoryNews',
    components: {
      lazyImage,
    },
    store,
  });
if (document.querySelector('.categoryNews-down'))
  new Vue({
    el: '.categoryNews-down',
    components: {
      lazyImage,
    },
    store,
  });

if (
  jQuery('.category_description').length &&
  jQuery('.category_description_2')
) {
  jQuery('.category_description_2').html(
    jQuery('.category_description').html(),
  );
  jQuery('.category_description').remove();
}
