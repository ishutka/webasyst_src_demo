import http from '../plugins/http';
const pricelist = {
  namespaced: true,
  state: {
    products: [],
    categories: [],
    contactCategories: [],
    pricelistExpanded: false, //ця змінна потрібна аби розуміти чи натиснута кнопка "показать все" 
    pricelistRendered: false //ця змінна потрібна аби ми могли керувати лоадером, що відображає процес рендерингу
  },
  getters: {
    getProductPrices: (state, getters) => product => {
      return product.prices.filter(
        p => p.category_id <= getters.userCategoryId,
      );
    },
    getPriceCategories (state, getters) {
      return state.contactCategories.filter(
        cat => cat.id <= getters.userCategoryId,
      );
    },
    userCategoryId (state, getters, { user }) {
      return user.user.category_id || 1;
    },
  },
  mutations: {
    setProducts (state, products) {
      state.products = products;
    },
    setCategories (state, categories) {
      state.categories = categories;
    },
    setContactCategories (state, contactCategories) {
      state.contactCategories = contactCategories;
    },
    expandPricelist (state) {
      state.pricelistRendered = true;
      setTimeout(() => {
        state.pricelistExpanded = !state.pricelistExpanded;
      }, 300)
    },
    hideRenderingLoader (state) {
      state.pricelistRendered = false;
    }
  },
  actions: {
    getPriceData: ({ commit }) => {
      return http
        .get('/json/pricelist/')
        .then(({ data }) => {
          commit('setCategories', data.data.categories);
          commit('setProducts', data.data.products);
          commit('setContactCategories', data.data.contact_categories);
        })
        .catch(error => {
          console.error(error);
        });
    },
  },
};

export default pricelist;
