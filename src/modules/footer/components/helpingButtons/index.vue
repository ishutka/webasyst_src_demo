<template>
  <div id="help-btns" :class="{ active: isVisible }">
    <ul class="container">
      <li class="menu-burger visible-xs">
        <toggle-menu></toggle-menu>
      </li>
      <li v-if="currentPageType !== 'home'" class="home-link hidden-xs">
        <a href="/">
          <i class="icon-005-home" title="На главную страницу"></i>
        </a>
      </li>
      <li class="search visible-xs" @click="toggleQuickSearch()">
        <i class="icon-011-search"></i>
      </li>
      <li class="contacts hidden-lg hidden-md" @click="show('contacts')">
        <i class="icon-018-phone"></i>
      </li>
      <li class="compare-img " :class="{ 'no-compare': !areCompareProduct }">
        <compare-product></compare-product>
      </li>
      <li class="up-arrow hidden-xs">
        <button-to-top></button-to-top>
      </li>
      <li
        v-if="currentPageType == 'category' && filters.length"
        class="filter"
        @click="showFilters()"
      >
        <i class="icon-049-filter"></i>
        <span v-if="selectedFiltersArray.length" class="filrets-count badge">{{
          selectedFiltersArray.length
        }}</span>
      </li>
    </ul>
  </div>
</template>

<script>
import toggleMenu from '@/modules/header/components/toggleMenuButton/index.vue';
import compareProduct from '../../../compare/components/compareButton/index.vue';
import ButtonToTop from '../buttonToTop/index.vue';
import modalMixin from '@/mixins/modalMixin.js';

import { mapState, mapGetters } from 'vuex';
export default {
  mixins: [modalMixin],
  components: {
    toggleMenu,
    ButtonToTop,
    compareProduct,
  },
  data() {
    return {
      isVisible: false,
    };
  },
  mounted() {
    window.addEventListener('scroll', this.checkIsVisible);
  },
  computed: {
    ...mapState('index', ['currentPageType']),
    ...mapState('category', ['filters']),
    ...mapGetters('category', ['selectedFiltersArray']),
    areCompareProduct() {
      const areCompared = this.$root.$store.getters['productCompare/count'];
      if (areCompared) return true;
      return false;
    },
  },
  methods: {
    toggleQuickSearch() {
      const targetElClasslist = document.querySelector(
        '.medium-header-search-bar',
      ).classList;
      if (window.innerWidth < 768)
        if (targetElClasslist.contains('toggled-xs')) {
          targetElClasslist.remove('toggled-xs', 'overflow-visible');
        } else {
          targetElClasslist.add('toggled-xs');
          setTimeout(() => {
            targetElClasslist.add('overflow-visible');
            document
              .querySelector('.medium-header-search-bar input[type="search"]')
              .focus();
          }, 300); //Задержка нужна для завершения анимации
        }
    },
    checkIsVisible() {
      if (window.pageYOffset > 500 && window.innerWidth > 767)
        this.isVisible = true;
      else this.isVisible = false;
    },
    showFilters() {
      const filtersBlock = document.querySelector('.category-filters__wrapper');
      const topScrollLine = document.querySelector('.content-wrapp');
      const filtersButton = document.querySelector('#mobile_btn_filter');
      // ф-ция для анимации бекграунда
      function twinkleFilters() {
        setTimeout(() => {
          // Меняем класс(добавляем анимацию), только когда скрол уже у верхней границы блока фильтров
          if (filtersBlock.getBoundingClientRect().top >= 0) {
            filtersBlock.classList.add('twinkle');
            // Удаляем класс по прошествию времени анимации
            setTimeout(() => {
              filtersBlock.classList.remove('twinkle');
            }, 1400);
          } else twinkleFilters();
        }, 300);
      }
      if (window.innerWidth < 992) filtersButton.click();
      else {
        // Прокрутку делаем к верху РОДИТЕЛЬСКОГО блока,-чтобы немного увеличить отступ сверху
        topScrollLine.scrollIntoView({ behavior: 'smooth', block: 'start' });
        twinkleFilters();
      }
    },
  },
};
</script>

<style lang="scss">
@-webkit-keyframes color-change {
  0% {
    background: rgba(251, 124, 0, 0.3);
  }
  10% {
    background: #fff;
  }
  20% {
    background: rgba(251, 124, 0, 0.3);
  }
  30% {
    background: #fff;
  }
  50% {
    background: rgba(251, 124, 0, 0.3);
  }
  100% {
    background: #fff;
  }
}
@keyframes color-change {
  0% {
    background: rgba(251, 124, 0, 0.3);
  }
  10% {
    background: #fff;
  }
  20% {
    background: rgba(251, 124, 0, 0.3);
  }
  30% {
    background: #fff;
  }
  50% {
    background: rgba(251, 124, 0, 0.3);
  }
  100% {
    background: #fff;
  }
}

@import '@/mainStylesVariables.scss';
.contact-component .phone.twinkle,
.contact-component .addresses.twinkle,
.category-filters__wrapper.twinkle {
  -o-animation: color-change 1.3s linear;
  -ms-animation: color-change 1.3s linear;
  -moz-animation: color-change 1.3s linear;
  -webkit-animation: color-change 1.3s linear;
  animation: color-change 1.3s linear;
}
#help-btns.active {
  right: 0;
}
.up-arrow .button-to-top {
  opacity: 1;
  position: static;
  background: transparent;
}
#help-btns {
  position: fixed;
  right: -100%;
  transition: right 0.3s ease;
  bottom: 15px;
  margin: 0;
  background: $link_color;
  border: 1px solid $link_color;
  border-radius: 25px 0 0 25px;
  border-right: 0;
  padding: 7px 0 7px 15px;
  z-index: 2;
  display: flex;
  list-style: none;
  box-shadow: 0 1px 2px rgba(0, 0, 0, 0.3);
  > .container::before,
  > .container::after {
    content: none;
  }
  .container {
    display: flex;
    margin: 0;
    padding: 0;
    width: auto;
    @media screen and (min-width: 768px) {
      > li:hover:not(.no-compare),
      > li:active:not(.no-compare) {
        @include color_transition();
        background: $main_brand_color;
        .filrets-count,
        .comparing-count {
          @include color_transition();
          color: $link_color;
          background: #fff;
        }
        i {
          @include color_transition();
          color: #fff;
        }
      }
    }
    > li {
      width: 38px;
      height: 38px;
      margin-right: 15px;
      background: #fff;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      position: relative;
      cursor: pointer;
      i {
        color: $link_color;
        font-size: 20px;
      }
    }
  }
  .filrets-count {
    position: absolute;
    bottom: -5px;
    right: 0px;
    background: $main_brand_color;
    padding: 3px 6px;
  }

  @media screen and (max-width: 767px) {
    position: fixed;
    left: 0;
    bottom: 0;
    padding: 0;
    background: #fff;
    border: none;
    border-top: 1px solid #ccc;
    width: 100%;
    border-radius: 0;
    padding: 0;

    > .container {
      width: 100%;
      padding: 10px 15px !important;
      display: flex;
      justify-content: space-between;
      li:hover,
      li:active {
        background: #fff;
        box-shadow: none;
      }
      li {
        box-shadow: none;
        margin: 0;
        background: #fff;
        border-radius: 3px;
        display: flex;
        align-items: center;
        justify-content: center;
        position: relative;
        cursor: pointer;
        .burger {
          margin-left: 0;
        }
        i.active.burger {
          color: $main_brand_color;
        }
        i {
          color: $link_color;
          font-size: 2em;
        }
      }
      .compare-img i {
        font-size: 2.5em;
      }
    }
    .menu-burger.visible-xs {
      display: flex !important;
    }
  }
}
</style>
