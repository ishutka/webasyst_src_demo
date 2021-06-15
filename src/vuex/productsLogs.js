import maxBy from 'lodash/maxBy';
import HTTP from '@/plugins/http.js';
const productsLogs = {
  namespaced: true,
  state: {
    logs: [],
    cutLogs: [],
    loading: false,
  },
  getters: {
    lastId: state => {
      const cutCount = state.logs.length - 1;
      state.cutLogs = state.logs.slice(cutCount);
      const lastLog = maxBy(state.cutLogs, 'id');
      if (lastLog && lastLog.id > 0) return lastLog.id;
      return 0;
    },
  },
  mutations: {
    addLogs(state, logs) {
      state.logs = state.logs.concat(logs);
    },
    changeLoading(state) {
      state.loading = !state.loading;
    },
  },
  actions: {
    async fetchLogs({ commit, getters }) {
      commit('changeLoading');
      const { data } = await HTTP.post('/json/products_logs/', {
        // TODO: this.$axios
        last_id: getters.lastId,
      });
      commit('changeLoading');
      commit('addLogs', data.data.logs);

    },
  },
};

export default productsLogs;
