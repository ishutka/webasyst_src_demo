export default {
  namespaced: true,
  state: {
    showCartContent: false,
  },
  mutations: {
    setShowCartContent(state, value) {
      state.showCartContent = value;
    },
  },
};
