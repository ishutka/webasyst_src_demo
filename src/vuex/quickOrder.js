import HTTP from '@/plugins/http.js';

export default {
  namespaced: true,
  state: {
    //можливо варто заповнити ці поля дефолтними данними
    fieldsList: [],
    // formIsShown: false,
    enableUserComment: null,
    orderText: null,
    buttonName: null,
    settingsLoaded: false,
  },
  getters: {
    settingsAreLoaded(state) {
      return state.fieldsList.length > 0;
    },
  },
  mutations: {
    setFields(state, fields) {
      state.fieldsList = fields.map(f => {
        return {
          type: f.field_type,
          title: f.field_name,
          name: f.field_value,
          value: '',
          required: f.required,
        };
      });
    },
    setAdditionalParams(state, data) {
      state.enableUserComment = data.enable_user_comment;
      state.orderText = data.order_text;
      state.buttonName = data.button_name;
    },
  },
  actions: {
    async fetchSettings({ commit }) {
      const { data } = await HTTP.get('/json/getQuickOrderSettings/');
      commit('setFields', data.data.fields);
      commit('setAdditionalParams', data.data);
    },
  },
};
