import { mapActions, mapState, mapGetters } from 'vuex';
import debounce from 'lodash/debounce';
export default {
  props: {
    product: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
      quantity: 1,
      loading: false,
    };
  },
  computed: {
    ...mapState('cart', ['items']),
    ...mapGetters('currency', ['format']),
    selectedServiceVariants: {
      get() {
        return this.product.services.map(s => s.service_variant_id);
      },
      set: debounce(function(services) {
        this.loading = true;
        if (services.length > this.selectedServiceVariants.length) {
          // добавление новой услуги
          const newServiceVariantId = services.find(
            id => !this.selectedServiceVariants.includes(id),
          );
          const service = this.product.all_services.find(
            s => s.variant_id === newServiceVariantId,
          );
          this.addToCart({
            service_variant_id: newServiceVariantId,
            service_id: service.id,
            parent_id: this.product.id,
          }).finally(() => {
            this.loading = false;
          });
        } else {
          // удаление услуги

          // находим id услуги (сущность услуги)
          const service_variant_id = this.selectedServiceVariants.find(
            id => !services.includes(id),
          );

          // находим id услуги добавленной в корзине (сущность элемента в корзине)
          const { id } = this.product.services.find(
            s => s.service_variant_id === service_variant_id,
          );
          this.deleteFromCart(id).finally(() => {
            this.loading = false;
          });
        }
      }, 50),
    },
    quantityWrapper: {
      get() {
        return this.product.quantity;
      },
      set: debounce(function(value) {
        if (!value) this.deleteFromCartWrapper(this.product.id);
        else {
          this.loading = true;
          this.updateCart({
            id: this.product.id,
            quantity: value,
          }).finally(() => (this.loading = false));
        }
      }, 1500),
    },
  },

  methods: {
    ...mapActions('cart', ['deleteFromCart', 'updateCart', 'addToCart']),
    deleteFromCartWrapper() {
      this.loading = true;
      this.deleteFromCart(this.product.id).finally(
        () => (this.loading = false),
      );
    },
  },
};
