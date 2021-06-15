<template>
  <div class="filters-wrapp">
    <div
      class="show-mobile-filters"
      :class="{ 'opened-filters': mobileFiltersAreOpened }"
    >
      <div class="filter-blur-inner">
        <div class="open-header visible-sm visible-xs">
          <span>Фильтры</span>
          <span
            id="close-filters"
            class="visible-sm visible-xs icon-012-closedelete"
            @click="toggleMobileFiltersAreOpened"
          ></span>
        </div>
        <div class="whole-filters">
          <SelectedFilters />
          <FeatureInStock />
          <div class="features-bunch">
            <Feature
              v-for="(feature, key) in filters"
              :key="key"
              :feature="feature"
            />
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import eventBus from '@/eventsBus';
import debounce from 'lodash/debounce';

import { mapState, mapMutations, mapActions, mapGetters } from 'vuex';
import Feature from './components/feature.vue';
import FeatureInStock from './components/featureInStock.vue';
import SelectedFilters from './components/selectedFilters.vue';

export default {
  components: { Feature, FeatureInStock, SelectedFilters },
  props: {
    categoryId: { type: Number, required: true },
    categoryName: { type: String, required: true },
  },
  created() {
    this.fetchFiltersWrapper(false);
  },
  mounted() {
    //Добавляю закрытие фиксированного блока фильтров свайпом на тачскрин устройствах
    let initialPoint;
    let finalPoint;
    const touchstartHendler = evt => {
      initialPoint = evt.changedTouches[0];
    };
    const touchendHendler = evt => {
      finalPoint = evt.changedTouches[0];
      const xAbs = Math.abs(initialPoint.pageX - finalPoint.pageX);
      /*СВАЙП ВПРАВО*/
      if (xAbs > 150) this.setMobileFiltersAreOpened(false);
    };
    const filtersFixedContainer = document.querySelector(
      '#categoryFilters .show-mobile-filters',
    );

    filtersFixedContainer.addEventListener('touchstart', touchstartHendler);
    filtersFixedContainer.addEventListener('touchend', touchendHendler);
    // Боработчик клика для мобильного контейнера-маски "выезжающего блока фильтров"(закрытие по клику):
    filtersFixedContainer.addEventListener('click', e => {
      if (e.target == filtersFixedContainer)
        this.setMobileFiltersAreOpened(false);
    });
  },
  computed: {
    ...mapState('category', [
      'filters',
      'selectedFilters',
      'categoryFiltersName',
      'mobileFiltersAreOpened',
      'priceRange',
    ]),
    ...mapState('products', ['listThumbsIsLoading']),
    ...mapGetters('category', ['selectedFiltersArray']),
  },

  methods: {
    ...mapMutations('category', [
      'toggleMobileFiltersAreOpened',
      'setMobileFiltersAreOpened',
    ]),
    updateCategoryH1() {
      const pageHeading = document.querySelector('.category-name__wp>h1');
      if (
        pageHeading.innerHTML !=
        `${this.categoryName} ${this.categoryFiltersName}`
      )
        pageHeading.innerHTML = `${this.categoryName} ${this.categoryFiltersName}`;
    },
    updateCategoryBreadCrumbs(breadcrumbs) {
      document.querySelector('.breadcrumb').outerHTML = breadcrumbs;
    },
    fetchFiltersWrapper(withUpdateHtmlBlocks = true) {
      this.setListThumbsIsLoading(true);
      return this.fetchFilters({
        $route: this.$route,
        withUpdateHtmlBlocks,
      }).then(({ data }) => {
        eventBus.$emit(
          'setSliderWithFiltersFetching',
          this.priceRange.min,
          this.priceRange.max,
        );
        if (withUpdateHtmlBlocks) this.updateHtmlBlocks(data.html);
        this.setListThumbsIsLoading(false);
      });
    },
    ...mapActions('category', ['fetchFilters']),
    ...mapMutations('products', ['setListThumbsIsLoading']),

    /*  
      обновляет html-блоки:
      список продуктов
      хлебные крошки
      h1 заголовка категории
    */
    updateHtmlBlocks({ list_thumbs, breadcrumbs, document_title }) {
      // сейчас сюда приходят: list_thumbs, breadcrumbs
      this.updateProductsList(list_thumbs);
      this.updateDocumentTitle(document_title);

      this.updateCategoryH1();
      this.updateCategoryBreadCrumbs(breadcrumbs);
    },
    updateDocumentTitle(document_title) {
      window.document.title = document_title;
    },
    updateProductsList(listThumbsHtml) {
      eventBus.$emit('listThumbsBeforeUpdate');
      document.querySelector('#listThumbs').innerHTML = listThumbsHtml;
      eventBus.$emit('listThumbsIsUpdated');
    },
  },
  watch: {
    $route(newValue, oldValue) {
      if (newValue.fullPath !== oldValue.fullPath) {
        this.setListThumbsIsLoading(true);
        debounce(() => {
          if (newValue.fullPath !== oldValue.fullPath) {
            const query = newValue.query;
            // Удаляем параметр страницы при обновлении фильтров
            if (query.page) {
              delete query.page;
              this.$router.push({ path: newValue.path, query });
            }
            this.fetchFiltersWrapper();
          }
        }, 100)();
      }
    },
  },
};
</script>
<style lang="scss">
@import '@/mainStylesVariables.scss';
#categoryFilters {
  margin: 0 0 32px;
  color: $link_color;
  .filters-wrapp {
    max-width: 100%;
  }
  #selectedFiltersInfo,
  #filter_item_drop_out_of_stock,
  .features-bunch .feature {
    position: relative;
    padding: 25px 20px;
    &:after {
      position: absolute;
      bottom: 0;
      left: 20px;
      right: 20px;
      content: '';
      height: 1px;
      background-color: #d8d8d8;
    }
    &:last-child:after {
      content: none;
    }
  }
  .checkbox-component:hover,
  .radio-component:hover {
    opacity: 1;
  }
  .radio-component > input:focus + label > .input-box,
  .checkbox-component > input:focus + label > .input-box {
    box-shadow: none;
  }
  .feature:last-child hr {
    display: none;
  }
  .radio-component > input + label > .input-box > .input-box-circle {
    background: #777;
    width: 40%;
    height: 40%;
    border-radius: 50px;
  }
  .checkbox-component.checked_item > input + label {
    color: $main_brand_color;
    font-weight: 600 !important;
  }
  .checkbox-component.checked_item > input + label > .input-box {
    border: 1px solid $main_brand_color;
  }
  .checkbox-component > input + label > .input-box {
    display: inline-flex;
    justify-content: center;
    margin-right: 8px;
    flex-shrink: 0;
    width: 16px;
    height: 16px;
    border: 1px solid #d1d1d1;
    border-radius: 0;
  }

  .radio-component input:disabled,
  .radio-component input:disabled + label {
    cursor: default !important;
  }
  label {
    font-weight: 400 !important;
    display: flex;
    align-items: center;
    input[disabled] {
      cursor: default;
    }
  }
  .checkbox-component > input + label > .input-box > .input-box-tick > path {
    stroke: $main_brand_color;
  }
  .checkbox-component > input + label > .input-box > .input-box-tick {
    width: 75%;
  }

  .radio-component > input + label > .input-box {
    border-color: #333;
    display: inline-flex;
    justify-content: center;
    align-items: center;
    vertical-align: text-top;
    margin-right: 3px;
    background: #fff;
  }

  @media screen and (max-width: 991px) {
    margin: 0;
    flex: 10;
    #filtersLinks {
      position: fixed;
      left: 100%;
    }
    .checkbox-component > input + label > .input-box {
      width: 20px;
      height: 20px;
    }
    #selectedFiltersInfo,
    #filter_item_drop_out_of_stock,
    .features-bunch .feature {
      padding: 30px 20px;
    }
    .open-header {
      display: flex !important;
      flex-shrink: 0;
      align-items: center;
      justify-content: space-between;
      background: #fff;
      border-bottom: 1px solid #d8d8d8;
      padding: 15px 20px 13px;
      > span:first-child {
        font-weight: 600;
        font-size: 16px;
        min-width: 60%;
        line-height: 1.2;
      }
    }
    .whole-filters {
      overflow-y: auto;
      flex-grow: 2;
      .check-or-radio.available:active {
        background: #d6d5d5;
      }
      label > div {
        padding: 3px;
        min-width: 50px;
      }
      label {
        font-size: 14px;
      }
    }
    .filter-blur-inner {
      width: 300px;
      float: right;
      background: $gray_bg;
      height: 100%;
      position: relative;
      display: flex;
      flex-direction: column;
    }

    #close-filters {
      font-size: 18px;
      line-height: 1;
    }
    .filters-wrapp {
      overflow: hidden;
    }
    .show-mobile-filters {
      transition: right 0.3s ease 0s, background-color 0s ease 0s;
      position: fixed;
      background-color: rgba(0, 0, 0, 0);
      width: 100%;
      right: -100%;
      padding-left: 15px;
      z-index: 3;
      top: 0;
      height: 100%;
      margin-left: 15px;
    }
    .show-mobile-filters.opened-filters {
      transition: right 0.3s, background-color 0.2s ease-in 0.15s;
      right: 0;
      background-color: rgba(0, 0, 0, 0.75);
    }
  }
  @media screen and (max-width: 767px) {
    margin: 0;
    border-top: 1px solid #ccc;
    .show-mobile-filters {
      width: calc(100% + 15px);
      padding: 0;
      margin-left: 7px;
    }
  }
}
</style>
