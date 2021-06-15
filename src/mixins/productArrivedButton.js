import { mapMutations, mapState } from 'vuex';
import productArrivedForm from '@/components/productArrivedForm/index.vue';
export default {
  props: { id: { type: Number, required: true } },
  components: { productArrivedForm },
  computed: {
    ...mapState('productArrived', ['modalStatus', 'productsId']),
    isProductAwaitCoockie() {
      if (
        document.cookie
          .split(';')
          .find(item => item.trim().startsWith(`AwaitFor-${this.id}-Coockie=`))
      )
        return true;
      return false;
    },
    formIsAlreadySubmit() {
      return this.productsId.includes(this.id) || this.isProductAwaitCoockie;
    },
    buttonText() {
      if (this.formIsAlreadySubmit) return 'Ожидаю';
      return 'Сообщить';
    },
    dataCyDirectiveValue() {
      if (this.formIsAlreadySubmit) return 'arrivedButtonIsSent';
      return 'arrivedButton';
    },
  },
  methods: {
    ...mapMutations('productArrived', ['setProductId', 'setModalStatus']),
  },
};
