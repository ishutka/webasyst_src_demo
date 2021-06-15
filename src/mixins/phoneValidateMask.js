import { mapState, mapGetters, mapMutations } from 'vuex';
// миксин для форм где нет явного выбора адреса пользователем
export default {
  data() {
    return {
      phoneInputMask: 'NXXXXXXXXX?XXXXXX',
    };
  },
  mounted() {
    // Устанавливаем общее сообщение валидации поля "телефон"(не только для Украины):
    if (this.user.firstname) {
      if (this.address.data.country === 'ukr')
        // Меняю дефолтную маску на украинскую,если страна пользователя Украина:
        this.phoneInputMask = '+38 (0##) ###-##-##';
      this.$store.commit('setPhoneValidMsg', this.address.data.country);
    } else this.$store.commit('setPhoneValidMsg', '');
  },
  computed: {
    ...mapState('user', ['user']),
    ...mapGetters('user', ['address']),
  },
  methods: {
    ...mapMutations(['setPhoneValidMsg']),
  },
};
