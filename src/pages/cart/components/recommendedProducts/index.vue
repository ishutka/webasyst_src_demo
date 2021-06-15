<template>
  <div v-if="recommendedProducts.length" class="col-xs-12 col-md-4 related ">
    <div class="row">
      <h5 class="col-xs-12">Вместе с этим товаром покупают:</h5>
      <Product
        v-for="p in recommendedProducts"
        :id="p.id"
        :key="p.id"
        :init-data="p"
      >
      </Product>
    </div>
  </div>
</template>

<script>
import { mapActions, mapState } from 'vuex';
import Product from './Product.vue';

export default {
  created() {
    this.fetchRecommendedProducts();
  },
  components: { Product },
  computed: {
    ...mapState('cart', ['recommendedProducts']),
  },
  methods: {
    ...mapActions('cart', ['fetchRecommendedProducts']),
  },
};
</script>
<style>
.related .row {
  display: flex;
  flex-wrap: wrap;
}
.related h5 {
  font-weight: bold;
  margin-top: 30px;
  margin-bottom: 20px;
}
</style>
