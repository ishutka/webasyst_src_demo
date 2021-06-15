<template>
  <div class="mini-cart-product">
    <div class="product-image">
      <a :href="product.frontend_url">
        <img :src="product.image_url" :alt="product.name" />
      </a>
    </div>
    <div class="product-content">
      <div>
        <a class="heading-link" :href="product.frontend_url">
          {{ product.name }}
        </a>
      </div>
      <span class="quantity">
        {{ product.quantity }} ×
        <span>
          {{ format(product.price) }}
        </span>
      </span>
      <div v-if="selectedServiceVariants.length" class="services">
        <strong>Дополнительно: </strong> <br />
        <span v-for="service in services" :key="service.id">
          {{ service.name }}
          <span class="service-price">{{ format(service.price) }};<br /> </span>
        </span>
      </div>
    </div>
    <div v-if="loading" class="loader-image">
      <img
        src="/wa-apps/shop/themes/flip/img/loading16.gif"
        class="img-responsive "
      />
    </div>
    <div
      v-else
      :data-cy="`deleteFromCart_${product.product_id}`"
      class="item-remove"
      @click.prevent="deleteFromCartWrapper"
    >
      <i title="удалить из корзины" class="icon-012-closedelete"></i>
    </div>
  </div>
</template>

<script>
import productInCartMixin from '@/mixins/productInCartMixin.js';

export default {
  mixins: [productInCartMixin],
  computed: {
    services() {
      // Так как в selectedServiceVariants указаны только service.id,то создаем массив
      // с полной информацией о выбраном сервисе,чтобы отобразить название и стоимость
      const services = [];
      this.selectedServiceVariants.forEach(s => {
        this.product.all_services.forEach(service => {
          if (service.variant_id === s) services.push(service);
        });
      });
      return services;
    },
  },
};
</script>

<style lang="scss">
.cart-list li:last-child .mini-cart-product {
  border-bottom: none;
}
.mini-cart-product {
  display: flex;
  justify-content: space-between;
  position: relative;
  border-bottom: 1px solid #e5e5e5;
  padding: 15px 0;
  a {
    display: block;
  }
  img {
    float: left;
    width: 100%;
    margin-left: 0;
  }
  .product-image {
    flex: 0 0 60px;
  }
  .item-remove i:hover {
    color: #000;
    transition: color 0.5s;
  }
  .item-remove {
    width: 20px;
    flex-shrink: 0;
    i {
      cursor: pointer;
      color: #ccc;
      font-size: 20px;
    }
  }
  .product-content {
    flex-grow: 1;
    padding: 0 15px;
  }
  .quantity {
    white-space: nowrap;
  }
  .services {
    margin-top: 5px;
    span {
      color: #999;
    }
  }
  @media screen and (max-width: 767px) {
    padding: 20px 15px;
  }
}
</style>
