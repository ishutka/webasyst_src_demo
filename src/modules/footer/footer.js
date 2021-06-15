$(document).ready(() => {
  $(window).scroll(() => {
    if ($(this).scrollTop() > 300) $('#to_top').fadeIn();
    else $('#to_top').fadeOut();
  });

  $('#to_top').click(() => {
    $('body,html').animate({ scrollTop: 0 }, 800);
    return false;
  });
});
// Для разворачивания ,свернутых в мобильной версии, панелей футера
// подключаю в соотвествующем блоке футера,чтобы ограничить кол-во слушателей
function toggleMobileFooterMenu() {
  document
    .querySelector('.footer-main-part')
    .addEventListener('click', event => {
      if (window.innerWidth < 768) {
        const targetEl = event.target.getAttribute('data-target');
        if (targetEl) {
          const toggledClasslist = document.querySelector(targetEl).classList;
          if (toggledClasslist.contains('collapsed'))
            toggledClasslist.remove('collapsed');
          else toggledClasslist.add('collapsed');
        }
      }
    });
}
import Vue from 'vue';
import Vuex from 'vuex';
Vue.use(Vuex);
import store from '@/vuex/store';

import buttonToTop from './components/buttonToTop/index.vue';
import helpingButtons from './components/helpingButtons/index.vue';
import contacts from '@/modules/globals/contacts/index.vue';
import modalMixin from '@/mixins/modalMixin.js';
import contactsBacklight from '@/helpers/contactsBackLight.js';
import modalCloseButton from '@/components/modalCloseButton/index.vue';
import productArrivedInit from '@/components/productArrivedForm/index.vue';
import lazyImage from '@/modules/globals/lazyImage/index.vue';

new Vue({
  el: '#footer',
  mixins: [modalMixin],
  components: {
    contacts,
    helpingButtons,
    buttonToTop,
    productArrivedInit,
    lazyImage,
    modalCloseButton,
  },
  mounted() {
    toggleMobileFooterMenu();
    // При клике на фоновую  прозрачную маску,меню закрывается
    const fogBackOfMobileMenu = document.querySelector('.mobile-menu-slide');
    if (fogBackOfMobileMenu)
      fogBackOfMobileMenu.addEventListener('click', e => {
        if (e.target == fogBackOfMobileMenu) this.pushMenuButton();
      });
  },
  methods: {
    ...Vuex.mapMutations('topMenu', ['pushMenuButton']),
    onAnimation(el) {
      contactsBacklight(el);
    },
  },
  store,
});
