<template>
  <div>
    <div class="hat_pricelist">
      <h1 class="page_title">
        Прайс-лист
      </h1>
      <div id="PriceListBtns">
        <top-buttons></top-buttons>
      </div>
    </div>
    <div class="clearfix"></div>
    <div id="pricelist" data-cy="pricelist">
      <ul class="nav">
        <img
          v-show="pricelistRendered"
          src="/wa-apps/shop/themes/flip/img/loading16.gif"
          class="img-responsive"
        />
        <Category
          v-for="category in parentCategories"
          v-show="!pricelistRendered"
          :key="category.id"
          :category="category"
        />
      </ul>
    </div>
  </div>
</template>

<script>
import { mapActions, mapState } from 'vuex';
import Category from './category/index.vue';
import topButtons from './topButtons/index.vue';

const pricelist = {
  components: { Category, topButtons },
  computed: {
    ...mapState('pricelist', ['categories', 'pricelistRendered']),
    parentCategories() {
      return this.categories.filter(c => c.parent_id == 0);
    },
  },
  methods: {
    ...mapActions('cart', ['getCartData']),
  },
};
export default pricelist;
</script>
<style>
#pricelist {
  margin-bottom: 20px;
}
</style>
