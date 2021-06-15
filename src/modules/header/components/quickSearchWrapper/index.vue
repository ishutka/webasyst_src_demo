<template>
  <div class="top_search" :class="{ 'active-search': input }">
    <form class="search" @submit.prevent="resultPageShow">
      <div class="input-group">
        <input
          v-model="input"
          type="search"
          autocomplete="off"
          :aria-label="'Search products' | translate"
          class="form-control search_id "
          name="query"
          :placeholder="'Search products' | translate"
          @keydown.down.prevent="moveFocusToSearch()"
          @keyup="fetchData()"
          @focus="
            activateQuckSearch();
            if (input && products.length === 0) fetchData();
          "
        />
        <label
          v-show="input"
          for="before"
          class="icon-012-closedelete"
          @click="setSearchInput('')"
        >
        </label>
        <button class="btn btn--report" :title="'Search' | translate">
          <span class="hidden-xs hidden-sm">{{ 'Search' | translate }}</span>
          <i class="icon-011-search visible-sm  visible-xs visible-md"></i>
        </button>
      </div>
    </form>
    <div
      v-show="
        (input && inputIsFocused) ||
          (inputIsFocused && history && history.length)
      "
      :class="{ 'only-history': !input && history && history.length }"
      class="search_suggestions"
    >
      <div v-show="!input && history && history.length" class="history-block">
        <div class="text-muted">{{ 'You were looking for' | translate }}:</div>
        <!--eslint-disable -->
        <a
          v-for="(item, index) in reversedHistory"
          :key="index"
          class="search-item"
          :href="`/search/${item}/`"
          :class="{ 'last-searching': index == 0 }"
          :data-tabindex="(!input && history && history.length) ? '0' : false"
          @click.prevent="setSearchInput(item)"
        ><i class="icon-011-search"></i>{{ item }}</a>
        <!--eslint-enable -->
      </div>

      <div
        v-if="input"
        class="quick_search_results"
        :style="{ opacity: opacity }"
      >
        <div v-show="populars && populars.length" class="populars">
          <div v-show="products.length > 0" class="text-muted">
            {{ 'Related searches' | translate }}:
          </div>
          <div v-show="products.length === 0" class="text-muted">
            {{ 'Popular searches' | translate }}:
          </div>
          <a
            v-for="(popular, index) in populars"
            :key="index"
            :href="popular.url"
            class="search-item heading-link "
            :data-tabindex="populars && populars.length ? '0' : false"
            @click.prevent="setSearchInput(popular.name)"
          >
            {{ popular.name }}
          </a>
        </div>

        <div v-if="categories && categories.length > 1" class="categories">
          <div class="text-muted">{{ 'Categories' | translate }}:</div>

          <a
            v-for="(category, index) in categories"
            :key="index"
            :href="category.url"
            data-tabindex="0"
            class="search-item heading-link "
          >
            {{ category.name }}
          </a>
        </div>
        <div
          v-show="finded_in_categories && finded_in_categories.length > 1"
          class="finded-in-categories"
        >
          <div class="text-muted">
            {{ 'Search' | translate }} {{ 'in category' | translate }}:
          </div>

          <a
            v-for="(category, index) in finded_in_categories"
            :key="index"
            :href="category.url"
            :data-tabindex="
              finded_in_categories && finded_in_categories.length > 1
                ? '0'
                : false
            "
            class="search-item heading-link "
          >
            <span class="text-muted">
              <i class="icon-011-search"></i>
              {{ input }}
              {{ 'in category' | translate }}
            </span>
            {{ category.name }}
          </a>
        </div>

        <div v-if="products.length && products" class="search_result_wrapper">
          <div class="tc">
            <a
              :href="pathToSeeAllREsults"
              class="heading-link"
              data-tabindex="0"
              @click.stop="resultPageShow()"
            >
              {{ 'See all search results' | translate }} >
            </a>
          </div>
          <div class="text-muted">{{ 'Found' | translate }}:</div>
          <quick-search-result
            v-for="product in products"
            :key="product.id"
            :product="product"
          />
        </div>
        <div class="wait-block">
          <div v-if="!isLoading">{{ 'Waiting for data' | translate }}...</div>
          <div v-show="products.length === 0 && isLoading" class="tc">
            {{ msgNoResults }}
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import debounce from 'lodash/debounce.js';
import http from '../../../../plugins/http';
import translationMixin from '@/mixins/translationMixin.js';
import quickSearchResult from './quickSearchResult/index.vue';
export default {
  data: function() {
    return {
      input: '',
      products: [],
      populars: [],
      categories: [],
      finded_in_categories: [],
      history: [],
      isLoading: false,
      opacity: 1,
      msgNoResults: window.translations['No results for your request'],
      inputIsFocused: false,
      isSetOuterClick: false,
    };
  },
  mixins: [translationMixin],
  mounted() {
    this.input = this.searchTitle;
    this.getHistory();
  },
  computed: {
    reversedHistory() {
      return [...this.history].reverse();
    },
    pathToSeeAllREsults() {
      return `/search/${this.input}/`;
    },
  },

  methods: {
    setNextFocused(array, i, way) {
      if (way == 'ArrowDown')
        if (i == array.length - 1) array[0].focus();
        else array[i + 1].focus();
      if (way == 'ArrowUp')
        if (i == 0) array[array.length - 1].focus();
        else array[i - 1].focus();
    },
    moveFocusToSearch() {
      // Ф-ция для перехода фокуса на первый эл-т выпадающего окна поиска (при нажатии стрелки клавиатуры "вниз"):
      const targetArray = this.$el.querySelectorAll('[data-tabindex]');
      if (targetArray.length) {
        targetArray[0].focus();
        // Вешаем слушатели события нажатия стрелок "вверх-вниз" на пунктах выдачи:
        for (let i = 0; i < targetArray.length; i++)
          targetArray[i].addEventListener('keydown', event => {
            if (event.code == 'ArrowDown' || event.code == 'ArrowUp') {
              event.preventDefault();
              this.setNextFocused(targetArray, i, event.code);
            }
          });
      }
    },
    getHistory() {
      const matches = document.cookie.match(
        new RegExp(
          `(?:^|; )${'shop_searchpro_search_history'.replace(
            /([\.$?*|{}\(\)\[\]\\\/\+^])/g,
            '\\$1',
          )}=([^;]*)`,
        ),
      );
      let history = [];
      try {
        history =
          (matches &&
            JSON.parse(
              decodeURI(matches[1])
                .split('%2C')
                .join(',')
                .split('+')
                .join(' '),
            )) ||
          [];
      } catch (e) {
        // eslint-disable-next-line no-console
        console.log(e);
      }
      // Если куки распарсились с ошибкой ,то подчищаем их
      if (history === [])
        if (
          document.cookie
            .split(';')
            .filter(item =>
              item.trim().startsWith('shop_searchpro_search_history='),
            ).length
        )
          document.cookie = 'shop_searchpro_search_history=; expires=0';

      this.history = history
        .filter(item => item.length > 0)
        .reverse()
        .slice(0, 10)
        .reverse();
    },
    activateQuckSearch() {
      this.inputIsFocused = true;
      //Слушателя ставим только один раз при "активации" инпута и ставим флаг this.isSetOuterClick=true;
      if (!this.isSetOuterClick) {
        document.addEventListener('click', this.checkOuterClickClose);
        this.isSetOuterClick = true;
      }
    },
    // В отдельной ф-ции, так как нужно удалять слушателя:
    checkOuterClickClose(e) {
      if (this.inputIsFocused) {
        const currentEl = this.$vnode.elm;
        if (!currentEl.contains(e.target) && currentEl != e.target) {
          this.inputIsFocused = false;
          document.removeEventListener('click', this.checkOuterClickClose);
          this.isSetOuterClick = false; //чтобы можно было опять поставить checkOuterClickClose
          // при повторнойактивации интупа
        }
      }
    },
    setSearchInput(val) {
      this.input = val;
      const searchInput = this.$vnode.elm.querySelector('input.search_id');
      searchInput.value = val;
      searchInput.focus();

      this.fetchData();
    },
    resultPageShow: function() {
      if (this.input && this.input.trim().length > 0)
        window.location.href = this.pathToSeeAllREsults;
    },
    resultFind: function(response) {
      this.opacity = 1;
      this.isLoading = true; // to hide #inrofmation & to show "no results"
      this.products = response.data.products || [];
      this.populars = response.data.popular.filter(i => i.name != this.input);
      this.categories = response.data.categories;
      this.finded_in_categories = response.data.finded_in_categories;
      const { input } = this;

      //Дополняем историю текущим запросом:
      if (this.products.length > 0 && input.length > 0)
        if (!this.history.find(txt => txt === input)) this.history.push(input);

      if (!input) {
        //to hide previos results tab
        this.products = [];
        this.isLoading = false;
      }
    },
    resultLoad: function() {
      this.msgNoResults = window.translations['No results for your request'];
      this.isLoading = false; // to show #inrofmation
      this.opacity = 0.3;
    },
    errorCatch: function() {
      this.opacity = 1;
      this.isLoading = true;
      this.products = [];
      this.msgNoResults = window.translations['Service unavailable'];
    },
    fetchData: debounce(function() {
      this.resultLoad();
      const { input } = this;
      http
        .get('/searchpro-plugin/dropdown/', {
          params: { q: input, format: 'json' },
        })
        .then(this.resultFind)
        .catch(this.errorCatch);
    }, 1000),
  },
  components: { quickSearchResult },
};
</script>

<style lang="scss">
.top_search.active-search {
  input::-ms-clear {
    display: none;
  }
  input {
    border-radius: 4px 0 0 0;
  }
}
.top_search {
  border-radius: 4px;
  -moz-border-radius: 4px;
  -webkit-border-radius: 4px;
  position: relative;
  height: 100%;
  label.icon-012-closedelete:hover {
    opacity: 1;
  }
  .search,
  .search,
  .input-group {
    height: 100%;
  }
  .search-item {
    text-decoration: none !important;
    display: block;
    text-align: left;
    padding-bottom: 7px;
    padding-top: 7px;
  }
  .search-item .icon-011-search {
    color: #ccc;
    font-size: 16px !important;
    margin-right: 5px;
  }
  .search_result_wrapper > .tc {
    font-weight: 600;
    text-align: left;
    padding: 0 20px;
    a {
      display: block;
    }
  }
  .search_result_wrapper > .tc a:focus,
  .search-item:focus {
    background: darken(#f4f4f4, 5%);
    outline: none;
  }
  .search-item:hover {
    background: #f4f4f4;
  }
  .wait-block {
    padding: 0 20px;
  }
  .search_result_wrapper,
  .populars,
  .categories,
  .finded-in-categories {
    > .text-muted {
      padding-bottom: 10px;
      padding-top: 8px;
      font-size: 12px;
    }
    > .text-muted,
    > a {
      padding-left: 20px;
      padding-right: 20px;
    }
  }
  .history-block {
    .search-item {
      padding: 7px 20px;
      display: flex;
      align-items: center;
      cursor: pointer;
      &:not(.last-searching) {
        border-top: 1px solid #eee;
      }
    }
  }
  label.icon-012-closedelete {
    transition: 0.3s;
    cursor: pointer;
    display: flex;
    align-items: center;
    font-size: 25px;
    margin: 0;
    opacity: 0.5;
    position: relative;
    z-index: 3;
  }
  label.icon-012-closedelete:before {
    position: absolute;
    left: -30px;
    top: 10px;
  }
  .input-group {
    display: flex;
    box-shadow: 0px 3px 6px #c7c7c7;
    border-radius: 4px;
    button {
      border-radius: 0 4px 4px 0;
      line-height: 1;
      padding: 0 20px;
      font-weight: 600;
    }
  }
  form .btn i.icon-011-search {
    display: none;
  }
  .search_id:focus {
    box-shadow: none;
  }
  .search_id {
    padding: 10px 20px;
    border: 1px solid #ccc;
    border-right: none;
    height: auto;
    min-height: 42px;
    line-height: 1;
  }
}
.search_suggestions {
  position: absolute;
  top: 100%;
  left: 0%;
  width: calc(100% - 87px);
  background: #fff;
  z-index: 4;
  border: 1px solid #ccc;
  border-top: none;
  &.only-history {
    padding-left: 0;
    .history-block {
      .text-muted {
        padding: 10px 20px 0;
      }
    }
  }
}
/* Для прокрутки окна результатов поиска */
.quick_search_results {
  overflow-y: auto;
  max-height: 500px;
  padding: 15px 0 20px 0;
}
@media screen and (max-width: 1199px) {
  .search_suggestions {
    width: calc(100% - 62px);
  }
  .fixed-scrolled .search_suggestions {
    width: calc(100% - 87px);
  }
}
@media screen and (max-width: 991px) {
  .fixed-scrolled .search_suggestions {
    width: calc(100% - 60px);
  }
}
@media screen and (max-width: 767px) {
  .fixed-scrolled .search_suggestions {
    width: calc(100% - 62px);
  }
  .quick_search_results {
    max-height: calc(100vh - 220px);
  }
}
@media screen and (max-width: 500px) {
  .fixed-scrolled .search_suggestions,
  .search_suggestions {
    width: 100%;
  }
}
</style>
