export default {
  namespaced: true,
  state: {
    productsId: [],
  },
  getters: {
    compareHref(state, getters) {
      let url = '/compare/';
      if (getters.count > 0) url += `${state.productsId.join(',')}/`;

      return url;
    },
    count(state) {
      return state.productsId.length;
    },
  },
  mutations: {
    addProduct(state, productId) {
      state.productsId.push(productId);
    },
    removeProduct(state, idToRemove) {
      state.productsId = state.productsId.filter(id => id !== idToRemove);
    },
    setProductsId(state, matches) {
      if (matches) {
        const productsIdInString = decodeURIComponent(matches[1]).split(',');
        state.productsId = productsIdInString.filter(i => !!i).map(i => +i);
      } else state.productsId = [];
    },
  },
  actions: {
    setCompareCookies({ state }) {
      document.cookie = `shopCompare=${state.productsId.join(
        ',',
      )}; path=/; expires=${30}`;
    },
    getCompareCookies({ commit }) {
      const matches = document.cookie.match(
        new RegExp(
          `(?:^|; )${'shopCompare'.replace(
            /([\.$?*|{}\(\)\[\]\\\/\+^])/g,
            '\\$1',
          )}=([^;]*)`,
        ),
      );
      commit('setProductsId', matches);
    },
  },
};
