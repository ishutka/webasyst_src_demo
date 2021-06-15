import HTTP from '../plugins/http.js';
const productArrived = {
  namespaced: true,
  state: {
    product_id: 0, // id продукта, для уведомления о том, что товар появился в наличии
    modalStatus: false,
    formData: {
      email: '',
      phone: '',
      expiration: '30',
      plugin_arrived_pid: '',
      plugin_arrived_skuid: '',
    }, // данные, которые будут уходить на сервер
    settings: {}, // настройки, который указаны в админке
    requestResult: 'notStarted',
    alertMessageIsVisible: false,
    validationRules: [],
    productsId: [],
  },
  mutations: {
    setProductId(state, id) {
      state.product_id = id;
    },
    setModalStatus(state, modalStatus) {
      state.modalStatus = modalStatus;
      if (state.productsId.includes(state.product_id))
        state.requestResult = 'success';
      else state.requestResult = 'notStarted';
    },
    setExpiration(state, expiration) {
      state.formData.expiration = expiration;
    },
    setSettings(state, settings) {
      state.settings = settings;
    },
    setValidationRules(state) {
      const sendType = state.settings.send_type.split('_');
      /* eslint-disable */
      sendType.forEach(name =>
        state.validationRules.push({
          name: name,
          required: sendType.includes('or') ? false : true,
          email: name.includes('email') ? true : false,
          phone:
            name.includes('sms') &&
            true,
        }),
      );
      /* eslint-enable */
    },
    setRequestStatus(state, result) {
      state.requestResult = result;
    },
    pushToProductsId(state) {
      state.productsId.push(state.product_id);
    },
    addProductParamsToFormData(state) {
      const getProductById = this.getters['products/getProductById'];
      const product = getProductById(state.product_id);
      state.formData.plugin_arrived_skuid = product.selected.sku_id;
      state.formData.plugin_arrived_pid = state.product_id;
      if (!state.settings.expiration) state.formData.expiration = '';
    },
    setUserDataFromRootState(state) {
      const user = this.state.user;
      state.formData.email = user.email;
      state.formData.phone = user.phone;
    },
    showAlertMessage(state) {
      state.alertMessageIsVisible = true;
    },
    setProductAwaitCoockie(state) {
      const maxCookieAge = 60 * 60 * 24 * 7;
      document.cookie = `AwaitFor-${state.product_id}-Coockie=; max-age=${maxCookieAge}`;
    },
  },
  actions: {
    sendData({ commit, state }) {
      commit('addProductParamsToFormData');
      commit('setRequestStatus', 'loading');
      HTTP.post('/arrivedAdd/', state.formData)
        .then(response => {
          if (response.data.status == 'ok') {
            commit('setRequestStatus', 'success');
            commit('pushToProductsId');
            commit('setProductAwaitCoockie');
          } else commit('setRequestStatus', 'error');
        })
        .catch(error => {
          commit('setRequestStatus', 'error');
        });
    },
  },
};

export default productArrived;
