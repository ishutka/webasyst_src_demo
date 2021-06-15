import '../../index.js';

import './index.css';

import './modules/seoLinksToCategories/index.scss';

import './modules/images/index.js';

import './modules/video/index.js';
import './modules/bestReview/index.js';

import './modules/productNavigation/index.js';

import './modules/productComplectation/index.js';

import './modules/isOld/isOld.css';
import './modules/isOld/isOld.js';

import './modules/productPageTitle/productPageTitle.js';
import './modules/productPageTitle/productPageTitle.css';

import './modules/showNewProducts/showNewProducts.css';
import './modules/showNewProducts/showNewProducts.js';

import './modules/productsSets/productsSets.css';
import './modules/productsSets/productsSets.js';

import './modules/productDescription/productDescription.css';
import './modules/productDescription/productDescription.js';

import './modules/productFeatures/productFeatures.css';
import './modules/productFeatures/productFeatures.js';

import './modules/reviews/index.js';

import './modules/smallProductReviews/smallProductReviews.css';

import './modules/relatedProducts/index.js';

import './modules/productChannels/productChannels.css';
import './modules/productChannels/productChannels.js';

import './modules/product2articles/product2articles.css';
import './modules/product2articles/product2articles.js';

import './modules/productPageShipping/index.js';

import './modules/productsByFeatures/productsByFeatures.css';
import './modules/productsByFeatures/productsByFeatures.js';

import './modules/productLeftFixed/productLeftFixed.css';

import './modules/productPageShareBlock/index.js';

import './modules/cartForm/index.js';

import './modules/cartFormDouble/index.js';

import Vue from 'vue';
import Vuex from 'vuex';
Vue.use(Vuex);
import store from '@/vuex/store';
if (document.querySelector('#product-video'))
  new Vue({
    el: '#product-video',
    store,
  });
import initRelatedProducts from '@/helpers/initRelatedProductsComponent.js';
const relatedProductsBlock = document.querySelector(
  '#product_navigation_content .related-products',
);
if (relatedProductsBlock) initRelatedProducts(relatedProductsBlock);
