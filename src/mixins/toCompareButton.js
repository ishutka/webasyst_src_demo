import { mapMutations, mapActions, mapState } from 'vuex';
export default {
  props: {
    productId: {
      required: true,
      type: Number,
    },
  },
  created() {
    this.determineButtonFunction();
  },
  data() {
    return {
      buttonFunction: 'add',
    };
  },
  computed: {
    ...mapState('productCompare', ['productsId']),
  },
  methods: {
    ...mapMutations('productCompare', ['addProduct', 'removeProduct']),
    ...mapActions('productCompare', ['setCompareCookies']),
    compareProduct() {
      if (this.buttonFunction === 'add') this.addProduct(this.productId);
      else this.removeProduct(this.productId);
      this.determineButtonFunction();
      this.setCompareCookies();
    },
    determineButtonFunction() {
      const isProductInCompareList = this.productsId.find(
        id => id === this.productId,
      );
      if (isProductInCompareList) this.buttonFunction = 'remove';
      else this.buttonFunction = 'add';
    },
  },
};
