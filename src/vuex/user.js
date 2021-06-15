import cloneDeep from 'lodash/cloneDeep';
import fields from '@/helpers/fields.js';
import HTTP from '../plugins/http';
const getEmptyUser = () => {
  return {
    id: 0,
    category_id: 0,
    name: '',
    firstname: '',
    lastname: '',
    middlename: '',
    photo: '',
    phone: '',
    addresses: [],
    email: '',
    np_area: '',
    np_city: '',
    np_warehouse: '',
  };
};

const getEmptyAddress = ext => {
  return {
    data: {
      country: 'ukr',
      region: '',
      city: '',
      street: '',
    },
    ext,
    value: '',
  };
};
const user = {
  namespaced: true,
  state: {
    user: {
      addresses: [getEmptyAddress(''), getEmptyAddress('shipping')],
    },
    csrf: '',
  },
  getters: {
    address(state) {
      return state.user.addresses.find(a => a.ext === '');
    },
    shippingAddress(state) {
      return state.user.addresses.find(a => a.ext === 'shipping');
    },
  },
  mutations: {
    update(state, { name, value }) {
      state.user[name] = value;
    },
    setUserData(state, data) {
      const emptyUser = getEmptyUser();

      // если не заполнен адрес доставки, добавляю пустой
      if (!data.addresses.find(a => a.ext === 'shipping'))
        data.addresses.push(getEmptyAddress('shipping'));

      // если не заполнен основной адрес, добавляю пустой
      if (!data.addresses.find(a => a.ext === ''))
        data.addresses.push(getEmptyAddress(''));

      for (const key in emptyUser)
        this._vm.$set(state.user, key, data[key] || emptyUser[key]);
    },
    setCsrf(state, csrf) {
      state.csrf = csrf;
    },
    /* 
      NOTE: делал по не знанию, думал, что адресов может быть неограниченное количество, а оказывается, их может быть всего 2 (основной и адрес доставки)
    addAddress(state) {
      state.user.addresses.push({ data: fields.address });
    },
    deleteAddress(state, index) {
      state.user.addresses = state.user.addresses.filter(
        (value, key) => index !== key,
      );
    },
    */

    updateAddress(state, address) {
      const index = state.user.addresses.findIndex(a => a.ext === address.ext);
      const addresses = cloneDeep(state.user.addresses);
      addresses[index] = address;
      state.user.addresses = addresses;
    },
  },
  actions: {
    save({ state }) {
      const customer = cloneDeep(state.user);
      customer['address.shipping'] = state.user.addresses.find(
        a => a.ext === 'shipping',
      ).data;
      customer['address'] = state.user.addresses.find(a => a.ext === '').data;
      delete customer.addresses;
      return HTTP.post('/my/account/', { customer });
    },
  },
};

export default user;
