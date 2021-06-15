import '../../index.js';

import './index.scss';
import '../../modules/globals/listThumbs/listThumbs.js';
import '../../modules/globals/news/news.css';
import store from '@/vuex/store';
import Vue from 'vue';
import lazyImage from '@/modules/globals/lazyImage/index.vue';

if (document.querySelector('.categoryNews'))
  new Vue({
    el: '.categoryNews',
    components: {
      lazyImage,
    },
    store,
  });
const searchCollapsedArray = document.querySelectorAll(
  '.search-navigation__title',
);
function setCollapsedOptions() {
  if (searchCollapsedArray && searchCollapsedArray.length)
    for (let i = 0; i < searchCollapsedArray.length; i++) {
      searchCollapsedArray[i].addEventListener('click', function() {
        const parentClass = this.parentElement.classList;
        if (parentClass.contains('closed')) parentClass.remove('closed');
        else parentClass.add('closed');
      });
      const childLength =
        searchCollapsedArray[i].nextElementSibling.children.length;
      if (window.innerWidth < 768) searchCollapsedArray[i].click();
      else if (childLength > 3) searchCollapsedArray[i].click();
    }
}
window.addEventListener('load', setCollapsedOptions);
