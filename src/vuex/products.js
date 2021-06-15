import http from '../plugins/http';
import eventsBus from '../eventsBus';

const getEmptyProduct = () => {
  return {
    info: {
      id: 0,
      count: 0,
      services: [],
      skus: [],
      price: 0,
      compare_price: 0,
      price_usd: 0,
      is_old: 0,
      name: '',
      img: '',
      thumb: '',
      frontend_url: '',
    },
    selected: {
      services: [],
      sku_id: null,
      quantity: 1,
    },
  };
};

export default {
  namespaced: true,
  state: {
    items: [],
    loading: false,
    listThumbsIsLoading: false,
  },
  getters: {
    getProductById: (state, getters) => id => {
      const product =
        state.items.find(p => p.info.id === id) || getEmptyProduct();
      product.info.avalaible = getters.isAvalaible(product);
      if (!product.info.thumb) product.info.thumb = '/images/no-photo.gif';
      if (!product.info.img) product.info.img = '/images/no-photo.gif';
      return product;
    },
    getPrice: (state, getters, rootState) => product => {
      return product.price;
    },
    getPriceUsd: (state, getters, rootState) => product => {
      return product.price_usd;
    },
    preparePrice: (state, getters, rootState, rootGetters) => (
      id,
      price,
      code = '',
    ) => {
      const product = getters.getProductById(id);
      if (!price) price = product.info.price;

      return rootGetters['currency/format'](price, code);
    },
    isAvalaible: () => product => {
      return (
        product.info.count > 0 && product.info.price > 0 && !product.info.is_old
      );
    },
  },
  mutations: {
    loadingChange(state, value) {
      state.loading = value;
    },
    setListThumbsIsLoading(state, value) {
      state.listThumbsIsLoading = value;
    },
  },
  actions: {
    setSelectedParam({ getters }, { id, name, value }) {
      const product = getters.getProductById(id);
      product.selected[name] = value;
    },
    addToCart({ getters, commit }, { id, quantity }) {
      commit('loadingChange', true);

      const product = getters.getProductById(id);
      const service_variant = {};
      for (const key in product.selected.services) {
        const variant_id = product.selected.services[key];
        const service = product.info.services.find(
          s => s.variant_id === variant_id,
        );
        service_variant[service.id] = variant_id;
      }

      const data = {
        product_id: id,
        quantity: quantity || product.selected.quantity,
        sku_id: product.selected.sku_id,
        service_variant,
        services: Object.keys(service_variant),
      };
      return http
        .post('/cart/add/', data)
        .then(() => {
          eventsBus.$emit('addedToCart', {
            id,
            price: getters.getPrice(product.info), // TODO: как получить именно выбранную цену покупателем, а не стандартную цену товара?
            name: product.info.name,
          });

          this.dispatch('cart/getCartData').then(() => {
            commit('loadingChange', false);
          });
          return 'success';
        })
        .catch(() => {
          commit('loadingChange', false);
          return 'error';
        });
    },
    setProductData({ state, getters }, product) {
      const data = getters.getProductById(product.id);
      for (const key in data.info)
        data.info[key] = product[key] || data.info[key];

      if (data.selected.sku_id === null) {
        const sku = data.info.skus[0];
        data.selected.sku_id = (sku && sku.id) || data.selected.sku_id;
      }
      const index = state.items.findIndex(p => p.info.id === data.info.id);

      if (index < 0) state.items.push(data);
    },
  },
};
