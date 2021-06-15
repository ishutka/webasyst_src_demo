import HTTP from '../plugins/http.js';

export default {
  namespaced: true,
  state: {
    shipping_id: 0,
    payment_id: 0,
    shippingMethods: [],
    paymentMethods: [],
  },
  getters: {
    shippingMethods(state, getters, rootState, rootGetters) {
      if (rootGetters['cart/isOnlyIntime'])
        return state.shippingMethods.slice(0).map(s => {
          s.disabled =
            !(s.name.indexOf('по Киеву') > -1) &&
            !(s.name.indexOf('Новая') > -1) &&
            !(s.name.indexOf('Самовывоз') > -1);
          return s;
        });

      return state.shippingMethods.slice(0).map(s => {
        s.disabled = false;
        return s;
      });
    },
    shippingMethod(state) {
      return state.shippingMethods.find(s => s.id === state.shipping_id);
    },
  },
  mutations: {
    setShippingMethods(state, shippingMethods) {
      state.shippingMethods = shippingMethods;
    },
    setShippingMethod(state, shipping_id) {
      state.shipping_id = shipping_id;
    },
    setPaymentMethods(state, paymentMethods) {
      state.paymentMethods = paymentMethods;
    },
    setPaymentMethod(state, payment_id) {
      state.payment_id = payment_id;
    },
  },
  actions: {
    fetchShippingMethods({ commit, state }) {
      HTTP.get('/json/checkout/getShippingMethods/').then(({ data }) => {
        commit('setShippingMethods', data.data.shipping_methods);
        if (!state.shipping_id) {
          let inHouse = data.data.shipping_methods.find(
            s => s.name.indexOf('Самовывоз') > -1,
          );
          if (!inHouse) inHouse = data.data.shipping_methods[0];

          commit('setShippingMethod', inHouse.id);
        }
      });
    },
    fetchPaymentMethods({ commit, state }) {
      HTTP.post('/json/checkout/getPaymentMethods/', {
        shipping_id: state.shipping_id,
      }).then(({ data }) => {
        commit('setPaymentMethods', data.data.payment_methods);

        if (!state.payment_id)
          commit('setPaymentMethod', data.data.payment_methods[0].id);
      });
    },
  },
};
