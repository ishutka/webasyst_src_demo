import modalInnerAfterAddToCart from '@/components/modalInnerAfterAddToCart/index.vue';
import { mapGetters, mapActions, mapState } from 'vuex';
import sumBy from 'lodash/sumBy';
// TODO: Коля, если у артикула своя цена на услугу, как быть
export default {
  data() {
    return { requestResult: 'notStarted', itemLoading: false };
  },
  components: { modalInnerAfterAddToCart },
  props: {
    initData: {
      type: Object,
      required: true,
    },
    id: {
      type: Number,
      required: true,
    },
  },
  created() {
    this.setProductData(this.initData);
  },
  computed: {
    ...mapState('products', ['loading']),
    ...mapGetters('products', [
      'preparePrice',
      'getPrice',
      'getPriceUsd',
      'getProductById',
    ]),
    ...mapState('currency', ['code']),
    ...mapGetters('currency', ['format']),
    requestIsLoading() {
      return this.requestResult === 'loading';
    },
    product() {
      return this._product.info;
    },
    selected() {
      return this._product.selected;
    },

    services: {
      get() {
        return this.selected.services;
      },
      set(value) {
        this.setSelectedParam({
          id: this.product.id,
          name: 'services',
          value,
        });
      },
    },
    sku_id: {
      get() {
        return this.selected.sku_id;
      },
      set(value) {
        this.setSelectedParam({
          id: this.product.id,
          name: 'sku_id',
          value,
        });
      },
    },
    quantityWrapper: {
      get() {
        return this.selected.quantity;
      },
      set(value) {
        this.setSelectedParam({
          id: this.product.id,
          name: 'quantity',
          value,
        });
      },
    },
    cost() {
      return this.price * this.selected.quantity;
    },
    costUsd() {
      return this.priceUsd * this.selected.quantity;
    },
    sku() {
      const { sku_id } = this.selected;
      return this.product.skus.find(row => sku_id === row.id);
    },
    _product() {
      return this.getProductById(this.id);
    },
    // цена выбранного артикула
    _sku_price() {
      return (
        (this.sku && this.sku.price && this.getPrice(this.sku)) ||
        this.getPrice(this.product)
      );
    },
    // цена в долларах выбранного артикула
    _sku_price_usd() {
      return (
        (this.sku && this.sku.price_usd && this.getPriceUsd(this.sku)) ||
        this.getPriceUsd(this.product)
      );
    },
    // сумарная цена выбранных услуг
    _services_price() {
      const selectedServices = this.product.services.filter(row => {
        return this.services.indexOf(row.variant_id) >= 0;
      });

      if (selectedServices.length > 0)
        return sumBy(selectedServices, row => this.getPrice(row));

      return 0;
    },
    // сумарная цена выбранных услуг в долларах (для розницых)
    _services_price_usd() {
      const selectedServices = this.product.services.filter(
        row => this.services.indexOf(row.id) >= 0,
      );

      if (selectedServices.length > 0)
        return sumBy(selectedServices, row => this.getPriceUsd(row));

      return 0;
    },
    price() {
      return +this._sku_price + +this._services_price;
    },
    priceUsd() {
      return +this._sku_price_usd + this._services_price_usd;
    },
  },
  methods: {
    ...mapActions('products', [
      'addToCart',
      'setProductData',
      'setSelectedParam',
    ]),
    addToCartWrapper(params) {
      this.itemLoading = true;
      return this.addToCart(params).then(() => {
        this.itemLoading = false;
        if (!params.notShowModalAfterAdd) {
          let modalWidth = '100%';
          if (window.innerWidth > 460) modalWidth = '430';
          this.$modal.show(
            modalInnerAfterAddToCart,
            {},
            { width: modalWidth, height: 'auto', name: 'container' },
            {
              opened: () => {
                setTimeout(() => {
                  this.$modal.hide('container');
                }, 3000);
              },
            },
          );
        }
      });
    },
  },
};
