import { currentTheme, currentThemePath } from '@/helpers/path.js';
export default {
  namespaced: true,
  state: {
    currentTheme,
    currentPageType: '',
  },
  getters: {
    currentThemePath: () => currentThemePath,
  },
  mutations: {
    getCurrentPageType(state, val) {
      state.currentPageType = val;
    },
  },
};
