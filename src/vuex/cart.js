import http from '../plugins/http';
import sumBy from 'lodash/sumBy';
export default {
  namespaced: true,
  state: {
    items: [],
    loading: false,
    cartIsLoading: false,
    total: 0,
    count: 0,
    discount: '',
    discountСoupon: '',
    discountNumeric: 0,
    recommendedProducts: [],
    discountCouponData: {},
  },
  getters: {
    itemsTotal(state, getters) {
      return sumBy(getters.items, 'total');
    },
    isOnlyIntime(state) {
      return !!state.items.find(i => i.product.only_intime === 1);
    },
    items(state) {
      return state.items.slice(0).map(i => {
        let servicesSum = 0;
        if (i.services.length > 0)
          servicesSum = i.services.reduce((accumulator, s) => {
            const { price } = i.all_services.find(ss => ss.id === s.service_id);

            return accumulator + price;
          }, 0);

        const price = Math.max(i.price, i.product.price) + servicesSum;
        /* специально, для комплектов, т.к. комплекты изначально в корзину добаляют товар с ценой уже включенной скидкой
          а потом ещё эта скидка отображается как скидка, и поэтому скидка может посчитаться 2 раза. поэтому я беру бОльшую цену.
        */
        i.total = price * i.quantity;
        return i;
      });
    },
  },
  mutations: {
    setRecommendedProducts(state, products) {
      state.recommendedProducts = products;
    },
    setTotal(state, value) {
      state.total = value;
    },
    setCount(state, value) {
      state.count = value;
    },
    setCartData(state, data) {
      state.items = data.items;
      state.discount = data.discount;
      state.discountNumeric = data.discount_numeric;
      state.discountСoupon = data.discount_coupon;
      state.discountCouponData = data.discount_coupon_data;
      state.total = data.total;
      state.count = data.count;
    },
    setCouponCode(state, code) {
      state.discountCouponData.coupon_code = code;
    },
    deleteItem(state, { id, data }) {
      // если есть среди товаров, удаляем из товаров
      if (state.items.find(item => item.id === id))
        state.items = state.items.filter(item => item.id !== id);
      // в ином случае проверяем все услуги, и удаляем из услуг + обновляем данные корзины
      else
        state.items = state.items.map(item => {
          const service = item.services.find(service => service.id === id);
          if (service) {
            item.services = item.services.filter(service => service.id !== id);
            item.full_price = data.data.item_total;
          }
          return item;
        });
    },
    updateItem(state, { id, quantity, full_price }) {
      const item = state.items.find(item => item.id === id);
      item.quantity = quantity;
      item.full_price = full_price;
    },
    changeLoadingStatus(state, status) {
      state.cartIsLoading = status;
    },
    addService(state, data) {
      const itemIndex = state.items.findIndex(i => i.id === data.parent_id);
      const item = state.items[itemIndex];

      const service = item.all_services.find(s => s.id === data.service_id);

      const newService = Object.assign({}, service, data);
      item.services.push(newService);
    },
    setLoading(state, value) {
      state.loading = value;
    },
  },
  actions: {
    fetchRecommendedProducts({ commit }) {
      return http
        .get('/json/getRecommendedProductsInCart/')
        .then(({ data }) => {
          commit('setRecommendedProducts', data.data.products);
        });
    },
    getCartData({ commit }) {
      commit('setLoading', true);
      commit('changeLoadingStatus', true);
      return http
        .get('/json/cart/')
        .then(({ data }) => {
          commit('setCartData', data.data);
          // commit('setCount', data.data.count);
          commit('changeLoadingStatus', false);
        })
        .finally(() => {
          commit('changeLoadingStatus', false);
          commit('setLoading', false);
        });
    },
    deleteFromCart({ dispatch }, id) {
      return http.post('/cart/delete/', { id, html: 1 }).then(() => {
        dispatch('getCartData');
        dispatch('fetchRecommendedProducts');
      });
    },
    // добавление услуги  товара в корзину
    addToCart({ commit, dispatch }, data) {
      return http.post('/cart/add/', { ...data, html: 1 }).then(response => {
        window.ga('send', 'event', 'checkout', 'addToCart');

        if (data.service_id) {
          // если добавляется услуга (чекбокс)
          data.id = response.data.data.id;
          commit('addService', data);
        }
        dispatch('getCartData');
      });
    },
    updateCart({ dispatch }, { id, quantity }) {
      return http.post('/cart/save/', { id, quantity }).then(({ data }) => {
        dispatch('getCartData');
        return 'notStarted';
      });
      // .catch(() => {
      //   // TODO: global error handler?
      // });
    },
  },
};
