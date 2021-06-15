import Vuex from 'vuex';
import Vue from 'vue';
import products from './products';
import cart from './cart';
import miniCart from './miniCart';
import currency from './currency';
import user from './user';
import review from './review';
import postReviews from './postReviews';
import category from './category';
import pricelist from './pricelist';
import productsLogs from './productsLogs';
import quickOrder from './quickOrder';
import VeeValidate, { Validator } from 'vee-validate';
import productArrived from './productArrived';
import countries from './countries';
import productCompare from './productCompare';
import topMenu from './topMenu';
import orderForm from './orderForm';
import index from './index';

// import signUp from './signUp';
let phoneValidMsg = '';
const requiredMessage = 'Это поле обязательно к заполнению';
const dictionary = {
  en: {
    messages: {
      email: () => 'Email введен не корректно',
      phone: () => phoneValidMsg,
      password: () => 'Пароль должен содержать больше 6 символов',
      alpha_dash: () =>
        'Для пароля используйте только буквенно-цифровые символы ',
      password_confirm: () => 'Пароли не совпадают',
      required: () => requiredMessage,
    },
    // TODO:
    // не знаю, зачем Антон создавал кастомные правила, скорее всего для страницы регистрации. я их закоментил, вроде норм.
    // custom: {
    //   email: {
    //     required: () => requiredMessage,
    //   },
    //   // userName: {
    //   //   required: () => requiredMessage,
    //   // },
    //   street: {
    //     required: () => requiredMessage,
    //   },
    //   phone: {
    //     required: () => requiredMessage,
    //   },
    //   firstname: {
    //     required: () => requiredMessage,
    //   },
    //   middlename: {
    //     required: () => requiredMessage,
    //   },
    //   password: {
    //     required: () => requiredMessage,
    //   },
    //   password_confirm: {
    //     required: () => requiredMessage,
    //   },
    // },
  },
};

Validator.extend('phone', {
  validate: value =>
    new Promise(resolve => {
      resolve({
        valid: !!value
          .toString()
          .match(
            /^[\+]?[0-9]{0,1}[-\s\.]?[0-9]{1,3}[-\s\.]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{2,5}[-\s\.]?[0-9]{2}[-\s\.]?[0-9]{2}$/im,
          ),
      });
    }),
});
Validator.extend('password', {
  validate: value =>
    new Promise(resolve => {
      resolve({
        valid: value.split('').length > 5,
      });
    }),
});
Validator.extend('password_confirm', {
  validate: (value, second) =>
    new Promise(resolve => {
      resolve({
        valid: value === second[0],
      });
    }),
});

Validator.localize(dictionary);
Vue.use(VeeValidate);

Vue.use(Vuex);

const store = new Vuex.Store({
  mutations: {
    // Функция для валидации телефона запускается в миксинах при установлении масок на поле телефона:
    setPhoneValidMsg(state, val) {
      if (val == 'ukr')
        phoneValidMsg =
          'Номер телефона не соответствует формату:+38 (0xx) xxx-xx-xx';
      else phoneValidMsg = 'Телефонный номер должен содержать 10-16 цифр';
    },
  },
  modules: {
    postReviews,
    category,
    products,
    cart,
    miniCart,
    currency,
    user,
    topMenu,
    productArrived,
    review,
    pricelist,
    productsLogs,
    quickOrder,
    countries,
    productCompare,
    orderForm,
    index,
    // signUp,
  },
});

export default store;
