import HTTP from '../plugins/http';
import cloneDeep from 'lodash/cloneDeep';

export default {
  namespaced: true,
  state: {
    filters: [],
    priceRange: { min: 0, max: 0 },
    selectedFilters: {},
    count: 0,
    countAllInCategories: 0,
    categoryUrl: '',
    mobileFiltersAreOpened: false,
    categoryFiltersName: '', //String for category page with selected filters
  },
  getters: {
    selectedFilters(state) {
      return cloneDeep(state.selectedFilters);
    },
    selectedFiltersArray(state) {
      const items = [];
      for (const alias in state.selectedFilters) {
        const value = state.selectedFilters[alias];
        if (alias === 'drop_out_of_stock') {
          if (value === 2)
            items.push({
              featureName: 'Наличие на складе',
              alias,
              title: `есть на складе`,
              value,
            });
          continue;
        }

        if (alias === 'price_min' || alias === 'price_max') {
          if (alias === 'price_min' && value > 0)
            items.push({
              featureName: '',
              alias: 'price_min',
              title: `Цена от ${value}`,
              value: value.price_min,
            });

          if (alias === 'price_max' && value > 0)
            items.push({
              featureName: '',
              alias: 'price_max',
              title: `Цена до ${value}`,
              value: value.price_max,
            });

          continue;
        }
        const filter = state.filters.find(f => f.alias === alias);
        if (filter && filter.name)
          // if (filter.multiple)

          value.forEach(id => {
            const valueData = filter.values.find(v => v.id === id);
            items.push({
              featureName: filter.name,
              alias: filter.alias,
              title: valueData.value,
              value: id,
            });
          });
        // else {
        //   const valueData = filter.values.find(v => v.id === value);
        //   if (valueData && valueData.value)
        //     items.push({
        //       featureName: filter.name,
        //       alias: filter.alias,
        //       title: valueData.value,
        //       value,
        //     });
        // }
      }
      return items;
    },
    selectedFeatures(state) {
      return Object.keys(state.selectedFilters)
        .map(alias => {
          return state.filters.find(f => f.alias === alias);
        })
        .filter(f => f);
    },
  },
  mutations: {
    toggleMobileFiltersAreOpened(state) {
      state.mobileFiltersAreOpened = !state.mobileFiltersAreOpened;
    },
    setMobileFiltersAreOpened(state, val) {
      state.mobileFiltersAreOpened = val;
    },
    updateState(state, items) {
      items.forEach(({ name, value }) => {
        state[name] = value;
      });
    },
  },
  actions: {
    /*eslint camelcase: "off"*/
    fetchFilters({ commit }, { $route, withUpdateHtmlBlocks }) {
      const params = { withUpdateHtmlBlocks };
      const additionalGetParams = [
        'drop_out_of_stock',
        'price_min',
        'price_max',
      ];

      additionalGetParams.forEach(name => {
        if ($route.query[name]) params[name] = $route.query[name];
      });

      return HTTP.post(`/siteproffilters/items${$route.fullPath}`, params).then(
        ({ data }) => {
          const items = [];
          items.push({
            name: 'categoryFiltersName',
            value: data.data.category_filters_name,
          });
          items.push({ name: 'filters', value: data.data.items });
          items.push({ name: 'count', value: data.data.count });
          items.push({ name: 'priceRange', value: data.data.price_range });
          items.push({
            name: 'countAllInCategories',
            value: data.data.countAllInCategories,
          });

          if (data.data.selected.length === 0) data.data.selected = {}; // если в php массив пуст, то в js тоже приходит как массив
          items.push({
            name: 'selectedFilters',
            value: data.data.selected,
          });
          items.push({
            name: 'currentUrl',
            value: $route.fullPath,
          });
          items.push({
            name: 'categoryUrl',
            value: data.data.category_url,
          });

          commit('updateState', items);
          return data;
        },
      );
      // .catch(() => {
      //   // TODO: global error handler?
      // });
    },
    /* eslint-enable */
  },
};
