import Vue from 'vue';
import Vuex from 'vuex';
Vue.use(Vuex);

import VModal from '@/modules/vue-js-modal/src/index.js';
Vue.use(VModal, { dynamic: true });
import { VueMaskDirective } from 'v-mask';
Vue.directive('mask', VueMaskDirective);

import initData from '@/components/initData/index.vue';

VModal.rootInstance = new Vue({
  el: '#vue-root',
  components: { initData },
  store,
});

import './header.scss';
import './components/menuPrimaryMenuLine/index.scss';
import './headerFixedWhenScroll.css';

import store from '@/vuex/store';
import topCategories from './components/topCategories/index.vue';
import toggleMenu from './components/toggleMenuButton/index.vue';
import quickSearchWrapper from './components/quickSearchWrapper/index.vue';
import miniCartMobileLink from './topLine/components/miniCartMobileLink/index.vue';
import userButtons from './topLine/components/userButtons/index.vue';
import modalMixin from '@/mixins/modalMixin.js';
import LoginForm from '@/components/LoginForm/index.vue';
import SignupForm from '@/components/SignupForm/index.vue';
import modalCloseButton from '@/components/modalCloseButton/index.vue';
import contactsBacklight from '@/helpers/contactsBackLight.js';

const app = new Vue({
  el: '#header',
  data() {
    return {
      width: 0,
    };
  },
  mixins: [modalMixin],
  components: {
    miniCartMobileLink,
    userButtons,
    topCategories,
    toggleMenu,
    quickSearchWrapper,
    LoginForm,
    SignupForm,
    modalCloseButton,
  },
  computed: {
    ...Vuex.mapState('topMenu', [
      'menuIsSwitched',
      'isMobile',
      'isTouchScreen',
    ]),
    ...Vuex.mapState('miniCart', ['showCartContent']),
    ...Vuex.mapState('category', ['mobileFiltersAreOpened']),
  },
  watch: {
    // Вотчеры нужны для возможности придать body{overflow:hidden}
    // и избежать наложения , когда
    //  открываются "модальные окна" меню, фильтров и корзины на мобильном:
    menuIsSwitched() {
      this.setLocalModalClass();
      if (this.isMobile && this.menuIsSwitched) {
        if (this.mobileFiltersAreOpened) this.setMobileFiltersAreOpened(false);
        if (this.showCartContent) this.setShowCartContent(false);
      }
    },
    showCartContent() {
      this.setLocalModalClass();
      if (this.isMobile && this.showCartContent) {
        if (this.mobileFiltersAreOpened) this.setMobileFiltersAreOpened(false);
        if (this.menuIsSwitched) this.pushMenuButton();
      }
    },
    mobileFiltersAreOpened() {
      this.setLocalModalClass();
      if (this.isMobile && this.mobileFiltersAreOpened) {
        if (this.showCartContent) this.setShowCartContent(false);
        if (this.menuIsSwitched) this.pushMenuButton();
      }
    },
  },
  methods: {
    ...Vuex.mapMutations('topMenu', ['pushMenuButton']),
    ...Vuex.mapMutations('category', ['setMobileFiltersAreOpened']),
    ...Vuex.mapMutations('miniCart', ['setShowCartContent']),
    onAnimation(el) {
      contactsBacklight(el);
    },
    setLocalModalClass() {
      const classList = document.querySelector('body').classList;
      const cartFlag = this.showCartContent && this.isMobile;
      const filtersFlag = this.mobileFiltersAreOpened && this.isTouchScreen;
      const menuFlag = this.menuIsSwitched && this.isMobile;
      if (
        !classList.contains('local-modal-open') &&
        (cartFlag || filtersFlag || menuFlag)
      )
        classList.add('local-modal-open');
      if (
        classList.contains('local-modal-open') &&
        !cartFlag &&
        !filtersFlag &&
        !menuFlag
      )
        classList.remove('local-modal-open');
    },
  },
  store,
});
window.app = app;
// Логика присвоения хедеру класса для фиксации при скроле:
const fixingToplineDesktop = document.querySelector('#preMenuCategory');

window.onscroll = function() {
  // Будем измерять скрол по отступу верхней границы основного контейнера
  //  с контентом от верхней границы окна браузера:
  window.topOffsetMainContainer = document
    .querySelector('#container_white_bg')
    .getBoundingClientRect().top;
  const fixedClassExist = fixingToplineDesktop.classList.contains(
    'fixed-scrolled',
  );
  // Если отступ <0 (в.граница контейнера выше в.границы браузера) и у #preMenuCategory
  //  нет класса 'fixed-scrolled':
  if (window.topOffsetMainContainer < 0 && !fixedClassExist)
    fixingToplineDesktop.classList.add('fixed-scrolled');
  // Если отступ >=0 (в.граница контейнера ниже в.границы браузера) и у #preMenuCategory
  // есть класс 'fixed-scrolled':
  if (fixedClassExist && window.topOffsetMainContainer >= 0)
    fixingToplineDesktop.classList.remove('fixed-scrolled');
};
