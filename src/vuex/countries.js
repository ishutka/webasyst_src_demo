import HTTP from '../plugins/http.js';

export default {
  namespaced: true,
  state: {
    countries: [],
    countriesIsLoaded: false,
  },
  mutations: {
    setCountries(state, countries) {
      state.countries = countries;
    },
    disableSecondLoadind(state) {
      state.countriesIsLoaded = true;
    },
  },
  actions: {
    async fetchCountries({ commit, state }) {
      if (!state.countriesIsLoaded)
        try {
          commit('disableSecondLoadind', true);
          const { data } = await HTTP.get('/json/countries/');
          commit('setCountries', data.data.countries);
        } catch (e) {
          console.error(e);
        }
    },
  },
};
