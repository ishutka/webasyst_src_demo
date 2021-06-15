// TODO: replace jQuery (in future)

import Vue from 'vue';
import store from '@/vuex/store';
import lazyImage from '@/modules/globals/lazyImage/index.vue';
import addToCartButton from '@/modules/globals/listThumbs/components/addToCartButton/index.vue';

if (document.getElementsByClassName('categoryHubSectionCars').length > 0)
  jQuery(document).on('click', '.categoryHubSectionCars .btn', () => {
    setTimeout(() => {
      const val = jQuery('input[name="categories_list"]:checked').val();
      const parentOfChecked = document.querySelector(
        'input[name="categories_list"]:checked',
      ).parentElement;
      parentOfChecked.classList.add('active');
      const parentOfUnchecked = document.querySelector(
        'input[name="categories_list"]:not(:checked)',
      ).parentElement;
      parentOfUnchecked.classList.remove('active');
      let html = '';
      window.categories_cars.forEach(e => {
        if (val == 'favorite')
          if (e.favorite == '0') {
            return true;
          }
        html += `<li><a href="/}${e.full_url}/">${e.name} <sup>${
          e.count
        }</sup></a></li>`;
      });
      document
        .querySelector('.categoryHubSectionCars')
        .setAttribute('name', val);
      document.querySelector('.categoryHubSectionCars ul').innerHTML = html;
    }, 200);
  });
if (document.getElementsByClassName('categoryHub').length > 0)
  new Vue({
    el: '.categoryHub',
    components: { addToCartButton, lazyImage },
    store,
  });
