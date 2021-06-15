<template>
  <div id="filter_item_price" :class="{ 'is-closed': !isOpened }">
    <p class="feature-heading" tabindex="0" @click="isOpened = !isOpened">
      <span> По цене </span>
      <i v-if="isOpened" class="icon-013-down"></i>
      <i v-else class="icon-016-up"></i>
    </p>
    <div class="filter_content">
      <div ref="priceSlider" class="slider-wrapper"></div>
      <div class="price_label">
        <!-- eslint-disable -->
          {{ code == 'UAH' ? '' : '$' }}
          <input type="number" :disabled="listThumbsIsLoading" v-model="slideFrom" class="from" @input="changePriceInput(slideFrom,null)" aria-label="Цена от"/>
          {{ code == 'UAH' ? '₴' : '' }}
         —
          {{ code == 'UAH' ? '' : '$' }}
          <input type="number" :disabled="listThumbsIsLoading" v-model="slideTo" class="to" @input="changePriceInput(null,slideTo)" aria-label="Цена до"/>
          {{ code == 'UAH' ? '₴' : '' }}
        <!-- eslint-enable -->
      </div>
    </div>
  </div>
</template>
<script>
import eventBus from '@/eventsBus';
import cloneDeep from 'lodash/cloneDeep';
import debounce from 'lodash/debounce';
import 'nouislider/distribute/nouislider.css';
import noUiSlider from 'nouislider';
import { mapState, mapMutations } from 'vuex';
export default {
  data() {
    return {
      isOpened: true,
      slideFrom: 0,
      slideTo: 0,
      isFiltersFetching: false,
      isInputChanging: false,
    };
  },
  //TODO: Коля, нужно,наверно, также получать priceRange и selectedFilters.price_... в долларах для соответсвующих групп пользователей
  mounted() {
    this.initPriceSlider(); //Разделила на две ф-ции для удобочтения
    this.updatePriceSlider();
    eventBus.$on(
      'setSliderWithFiltersFetching',
      this.setSliderWithFiltersFetching,
    );
  },
  computed: {
    ...mapState('category', ['selectedFilters', 'priceRange']),
    ...mapState('currency', ['code']),
    ...mapState('products', ['listThumbsIsLoading']),
  },
  methods: {
    ...mapMutations('category', ['updateState']),
    updatePriceSlider() {
      this.$refs.priceSlider.noUiSlider.on(
        'update',
        debounce((values, handle) => {
          const val1 = +values[0];
          const val2 = +values[1];
          // Условие,что слайдер цены был обновлен инпутом или передвижением слайдера непосредственно(при выборе диапазона цен):
          if (!this.isFiltersFetching) {
            // handle возвращает индекс регулятора слайдера цены(0 или 1,так как у нас два регулятора)
            // в зависимости от того позиция какого регулятора была изменена, обновляем фильтр цены
            if (handle === 0)
              this.selectedFilters.price_min = Math.max(
                val1,
                this.priceRange.min,
              );
            else if (handle === 1)
              this.selectedFilters.price_max = Math.min(
                val2,
                this.priceRange.max,
              );
            // При выборе диапазона цен в инпутах this.slideFrom и this.slideTo обновляются через v-model,
            // а при выборе диапазона цен слайдером, обновляем this.slideFrom и this.slideTo:
            if (!this.isInputChanging)
              [this.slideFrom, this.slideTo] = [
                val1,
                val1 == val2 ? val2 + 1 : val2,
              ];
            this.updatePrice();
          }
          if (this.isInputChanging) this.isInputChanging = false;
          if (this.isFiltersFetching) this.isFiltersFetching = false;
        }, 0),
      );
    },
    initPriceSlider() {
      noUiSlider.create(this.$refs.priceSlider, {
        start: [
          Math.max(
            this.selectedFilters.price_min || this.priceRange.min,
            this.priceRange.min,
          ),
          Math.min(
            this.selectedFilters.price_max || this.priceRange.max,
            this.priceRange.max,
          ),
        ],
        behaviour: 'snap',
        connect: true,
        step: 0.01,
        range: {
          min: this.priceRange.min,
          max: this.priceRange.max + 1, // +1 нужен на случай,если крайние точки диапазона цен равны - тогда слайдер выдает ошибку
        },
      });
    },
    changePriceInput: debounce(function(val1, val2) {
      //  с помощью ф-ции setHandle передаем ( для события update слайдера цены) индекс регулятора и значение
      this.isInputChanging = true;
      let index = 0;
      if (val1 === null) index = 1;

      this.$refs.priceSlider.noUiSlider.setHandle(index, index ? +val2 : +val1);
    }, 1000),
    setSliderWithFiltersFetching(val1, val2) {
      // Ф-ция используется в компоненте фильтров при смене роута,чтобы обновить диапазон слайдер
      this.isFiltersFetching = true;
      const minMin = Math.max(this.selectedFilters.price_min || val1, val1);
      const maxMax = Math.min(this.selectedFilters.price_max || val2, val2);

      // обновление диапазона слайдера цены:
      this.$refs.priceSlider.noUiSlider.updateOptions({
        range: {
          min: val1,
          max: val1 == val2 ? val2 + 1 : val2,
        },
      });
      // Обновление значения в инпутах:
      [this.slideFrom, this.slideTo] = [
        Math.min(minMin, maxMax),
        Math.max(minMin, val1 == val2 ? maxMax + 1 : maxMax),
      ];
      // обновление положений регуляторов слайдера цены:
      this.$refs.priceSlider.noUiSlider.set([
        Math.min(minMin, maxMax),
        Math.max(minMin, val1 == val2 ? maxMax + 1 : maxMax),
      ]);
    },
    updatePrice: debounce(function() {
      const selectedFilters = cloneDeep(this.selectedFilters);
      const name_min = `price_min`;
      const name_max = `price_max`;
      const value_min = selectedFilters[name_min];
      const value_max = selectedFilters[name_max];
      const query = cloneDeep(this.$route.query); // потому что не обновляется роут в браузере, если без cloneDeep
      query[name_min] = value_min;
      query[name_max] = value_max;
      if (selectedFilters[name_min] == this.priceRange.min) {
        delete selectedFilters.price_min;
        delete query[name_min];
      }
      if (selectedFilters[name_max] == this.priceRange.max) {
        delete selectedFilters.price_max;
        delete query[name_max];
      }
      const data = [
        {
          name: 'selectedFilters',
          value: selectedFilters,
        },
      ];
      this.updateState(data);

      // Удаляем параметр страницы при обновлении фильтров
      if (query.page) delete query.page;
      this.$router.push({ query });
    }, 1000),
  },
  beforeDestroy() {
    eventBus.$off(
      'setSliderWithFiltersFetching',
      this.setSliderWithFiltersFetching,
    );
  },
};
</script>
<style lang="scss">
#filter_item_price {
  input[type='number'] {
    -moz-appearance: textfield;
    -webkit-appearance: textfield;
  }
  input[type='number']:hover,
  input[type='number']:focus {
    -moz-appearance: number-input;
    -webkit-appearance: number-input;
  }
  input[type='number']::-webkit-outer-spin-button,
  input[type='number']::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
  }
  .slider-wrapper {
    height: 2px;
    cursor: pointer;
    margin: 15px 0;
    border: none;
    background: #eee;
    .noUi-connect {
      background: #ddd;
    }
    .noUi-base {
      background: #fff;
    }
    .noUi-origin {
      top: -1px;
    }
    &.noUi-horizontal .noUi-handle {
      height: 16px;
      width: 16px;
      border-radius: 50%;
      background: #eee;
      box-shadow: none;
      cursor: pointer;
      &.noUi-handle-lower {
        right: -16px;
      }
      &.noUi-handle-upper {
        right: 0px;
      }
      &:before,
      &:after {
        display: none;
      }
    }
    .noUi-handle {
      border: none;
    }
    .noUi-handle,
    noUi-handle:focus,
    .noUi-touch-area,
    .noUi-touch-area:focus {
      outline: none;
      background: #eee;
      border-radius: 50%;
    }
    .noUi-touch-area {
      border: 0.5px solid #aaa;
    }
  }
  .price_label {
    font-size: 16px;
    color: #999;
    white-space: nowrap;
    padding-top: 10px;
    input {
      max-width: calc(50% - 30px);
      border: #d1d1d1 1px solid;
      height: 34px;
      line-height: 34px;
      padding: 0 5px;
    }
  }
  .filter_content {
    overflow: visible;
    transition: max-height 0.3s ease;
    max-height: 200px;
  }
  &.is-closed .filter_content {
    overflow: hidden;
  }
}
</style>
