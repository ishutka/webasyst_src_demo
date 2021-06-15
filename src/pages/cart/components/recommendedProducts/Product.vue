<template>
  <div class="col-xs-6 col-md-12 recomended-item ">
    <a
      :href="initData.frontend_url"
      target="_blank"
      :title="initData.name"
      class="image-wrapper "
    >
      <img class="image" :src="product.thumb" />
    </a>
    <div class="col-xs-8 ">
      <div class="" target="_blank">
        <a :href="initData.frontend_url" :title="product.name">
          {{ product.name }}
        </a>
      </div>
      <Rating :value="initData.rating" />
      <span
        v-if="product.avalaible"
        class="price nowrap"
        v-html="preparePrice(product.id, cost)"
      />
      <!-- <span
        v-if="product.avalaible && product.price_usd"
        class="usd_price nowrap"
      >
        ( {{ format(costUsd, 'USD') }} )
      </span> -->
      <div>
        <button
          v-if="product.avalaible"
          type="button"
          class="btn  btn-success"
          :title="`Купить ${initData.name}`"
          data-cy="addToCartButton"
          @click="addToCartWrapperWrapper({ id: product.id })"
        >
          <i class="fa fa-shopping-cart"></i><span>Купить</span>
          <div v-if="requestIsLoading" class="loader-image">
            <img
              src="/wa-apps/shop/themes/flip/img/loading16.gif"
              class="img-responsive "
            />
          </div>
        </button>
        <arrived-button v-if="!product.avalaible" :id="product.id" />
      </div>
    </div>
  </div>
</template>
<script>
import arrivedButton from './components/arrivedButton/index.vue';
import productMixin from '@/mixins/productMixin.js';
import Rating from '@/modules/globals/rating/rating.vue';
import { mapActions } from 'vuex';
export default {
  mixins: [productMixin],
  components: { Rating, arrivedButton },
  methods: {
    addToCartWrapperWrapper(params) {
      params.notShowModalAfterAdd = true;
      this.requestResult = 'loading';
      this.addToCartWrapper(params).then(() => {
        // after add to cart, we should update recommendedProducts
        this.requestResult = 'notStarted';
        this.fetchRecommendedProducts();
      });
    },
    ...mapActions('cart', ['fetchRecommendedProducts']),
  },
};
</script>
<style lang="scss">
.recomended-item {
  display: flex;
  flex-wrap: wrap;
  margin-bottom: 15px;
  button {
    line-height: 1;
    vertical-align: middle;
    min-width: 115px;
    font-size: 16px;
    margin-top: 10px;
  }
  .loader-image {
    display: inline-flex;
    align-items: center;
    width: 18px;
  }
  > div {
    padding-left: 30px;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
  }

  .image-wrapper {
    display: flex;
    align-items: center;
    max-width: 33%;
  }
  .image-wrapper .image {
    flex: 0 0 auto;
  }
  button span {
    margin-left: 5px;
  }
  @media screen and (max-width: 991px) {
    margin-bottom: 30px;
  }
  @media screen and (max-width: 500px) {
    width: 100%;
    margin-bottom: 40px;
  }
}
</style>
