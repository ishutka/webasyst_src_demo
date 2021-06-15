import currencyFormatter from 'currency-formatter';
import clone from 'lodash/clone';
const UAHFormat = currencyFormatter.findCurrency('UAH');
UAHFormat.symbol = ' грн';
UAHFormat.decimalDigits = 2;
UAHFormat.decimalSeparator = '.';

const USDFormat = currencyFormatter.findCurrency('USD');
USDFormat.decimalDigits = 2;
USDFormat.decimalSeparator = '.';

const currencies = {
  UAH: UAHFormat,
  USD: USDFormat,
};

const currency = {
  namespaced: true,
  state: {
    code: 'UAH',
  },
  getters: {
    format: state => (price, code = '') => {
      code = code || state.code;
      const formatParams = currencies[code];
      return currencyFormatter.format(price, formatParams);
    },
  },
  mutations: {
    setCode(state, value) {
      state.code = value;
    },
  },
  actions: {
    //
  },
};

export default currency;
