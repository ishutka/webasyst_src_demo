<template>
  <a class=" search-product" :href="product.frontend_url" data-tabindex="0">
    <a :href="product.frontend_url" class="search-result-image" target="_blank">
      <img v-if="product.img" :src="product.img" />
      <img
        v-if="!product.img"
        src="/wa-apps/shop/themes/flip//img/dummy200.png"
      />
    </a>
    <div>
      <a :href="product.frontend_url" class="product-name heading-link">{{
        product.name
      }}</a>
      <span v-if="product.available" class="text_in_stock text-small">
        {{ 'In stock' | translate }}
      </span>
      <span v-else class="out-of-stock text-small">
        {{ 'Discontinued' | translate }}
      </span>
      <div v-if="product.available">
        <span class="price nowrap">{{ format(product.price) }}</span>
        <span
          v-if="code === 'UAH' && product.compare_price > product.price"
          class="compare-at-price nowrap"
        >
          {{ format(product.compare_price) }}
        </span>
      </div>
    </div>
  </a>
</template>
<script>
import { mapGetters, mapState } from 'vuex';
import translationMixin from '@/mixins/translationMixin.js';
export default {
  props: { product: { type: Object, required: true } },
  methods: {
    fetchData() {
      this.$emit('fetchData');
    },
  },
  mixins: [translationMixin],
  computed: {
    ...mapGetters('currency', ['format']),
    ...mapState('currency', ['code']),
  },
};
</script>
<style lang="scss">
@import '@/mainStylesVariables.scss';
.search-product {
  line-height: 1.2;
  display: flex;
  padding: 7px 0;
  &:focus {
    background: darken(#f4f4f4, 5%);
  }
  a {
    display: block;
  }
  .product-name {
    display: block;
  }
  .search-result-image {
    flex: 0 0 60px;
    width: 60px;
    margin-right: 15px;
  }
  img {
    display: block;
    max-width: 100%;
    height: auto;
    margin: 0px auto;
  }
  .text_in_stock,
  .out-of-stock {
    margin-bottom: 5px;
    display: block;
  }
  .text_in_stock {
    color: $green_color;
  }
  .compare-at-price {
    color: $huge_text;
    font-size: 14px;
  }
  .text-small {
    font-size: 12px;
  }
  .price {
    font-size: 16px;
  }
}
</style>
