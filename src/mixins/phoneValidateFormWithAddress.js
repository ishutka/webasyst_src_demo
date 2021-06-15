export default {
  methods: {
    getMask(country) {
      // ставлю дефолтную маску ,чтобы при "переключении" страны обновлялось сообщении об ошибке:
      //   X-любой символ;#- только цифры; N- или цифра или буква
      // Если вначале маски стоит "Х", то маска меняется после ввода в поле,а не при выборе другой страны
      let mask = 'NXXXXXXXXX?XXXXXX';
      this.$store.commit('setPhoneValidMsg', country);
      if (country === 'ukr') mask = '+38 (0##) ###-##-##';
      return mask;
    },
  },
};
