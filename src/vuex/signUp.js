// большой необходимости в настройках списка полей и их названиях я не вижу, поэтому не подключаю стор.

import HTTP from '../plugins/http.js';

const user = {
  namespaced: true,
  state: {
    fields: [],
  },
  getters: {},
  mutations: {
    setFields(state, data) {
      /*                               
      приходит объект, массивов. (каждый массив из двух элементов.)                             
      первый элемент нам не нужен, это ошибки, и их никогда не будет. 
      второй элемент - это настройки он нам нужен. 
      1. перевожу объект в массив  
      2. получаю второй элемент      
      */
      const fields = [];
      for (const name in data) {
        const value = data[name];
        fields.push({
          name,
          data: value[1],
        });
      }
      state.fields = fields;
    },
  },
  actions: {
    fetchFields({ commit }) {
      return HTTP.get('/json/signup/').then(({ data }) => {
        debugger;
        commit('setFields', data.data.fields);
      });
    },
  },
};

export default user;
