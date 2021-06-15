<template>
  <div class="mini-cart-content" @mouseleave="setShowCartContent(false)">
    <h4>
      Моя корзина
      <i
        class="icon-015-right visible-xs"
        @click="setShowCartContent(false)"
      ></i>
    </h4>
    <ul class=" cart-list">
      <li v-for="item in items" :key="item.id">
        <product-in-mini-cart :product="item"></product-in-mini-cart>
      </li>
    </ul>
    <div class="cart-panel-footer">
      <p class="total">
        <strong>Общая сумма:</strong>
        <span class="price"> {{ format(total) }} </span>
      </p>

      <p class="to-cart-button">
        <a class="btn--report" href="/cart/">
          Оформить заказ
        </a>
      </p>
    </div>
  </div>
</template>

<script>
import { mapState, mapGetters, mapMutations } from 'vuex';
import productInMiniCart from './productInMiniCart.vue';

export default {
  components: { productInMiniCart },
  mounted() {
    // Watcher нужен,чтобы повесить событие,когда "подгрузится" count и появится fogBackOfMobileMiniCart
    const fogBackOfMobileMiniCart = document.querySelector(
      '#header-phones-and-cart .mini-cart-content',
    );
    if (fogBackOfMobileMiniCart)
      // При клике на фоновую  прозрачную маску,корзина закрывается
      fogBackOfMobileMiniCart.addEventListener('click', e => {
        if (e.target == fogBackOfMobileMiniCart) this.setShowCartContent(false);
      });
  },
  computed: {
    ...mapState('miniCart', ['showCartContent']),
    ...mapGetters('cart', ['items']),
    ...mapState('cart', ['total']),
    ...mapGetters('currency', ['format']),
  },
  methods: {
    ...mapMutations('miniCart', ['setShowCartContent']),
  },
};
</script>

<style lang="scss">
.mini-cart-content::before {
  content: '';
  position: absolute;
  top: 0%;
  right: 16px;
  width: 13px;
  height: 13px;
  -webkit-transform: rotate(45deg);
  -ms-transform: rotate(45deg);
  transform: rotate(45deg);
  border-left: 1px solid #ccc;
  border-top: 1px solid #ccc;
  background-color: #fff;
  padding: 0;
  margin-top: -7px;
}
@media screen and (min-width: 768px) {
  .mini-cart-content {
    min-width: 370px;
    border: 1px solid #ccc;
    background-color: #fff;
    padding: 10px 20px 0;
    transition: top 0.3s ease 0s, opacity 0.3s;
    position: absolute;
    right: 0;
    top: 110%;
    opacity: 0;
    z-index: -1;
    transform: scaleX(0);
    display: block;
    border-radius: 0;
    box-shadow: none;
    max-width: 400px;
    .cart-list {
      max-height: 350px;
    }
  }
}
.mini-cart-content {
  h4 {
    color: #666;
    font-weight: 600;
    margin: 0;
    padding: 10px 0 15px;
    font-size: 20px;
  }
  a:hover {
    text-decoration: none;
    transition: color 0.3s;
  }
  .cart-list {
    padding-left: 20px;
    padding-right: 20px;
    margin: 0 -20px;
    overflow-y: auto;
    overflow-x: hidden;
  }
  .to-cart-button {
    padding: 20px 0 25px;
    margin: 0;
    text-align: center;
    a:hover {
      text-decoration: none;
    }
    a {
      border-radius: 3px;
      height: 45px;
      display: inline-flex;
      align-items: center;
      justify-content: center;
      font-size: 16px;
      font-weight: 600;
      border: none;
      padding: 0 20px;
      margin: 0 auto;
    }
  }
  .total strong {
    color: #000;
    font-weight: 600;
  }
  .total {
    margin-top: 20px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    font-size: 18px;
    margin-bottom: 0;
  }
}
@media screen and (max-width: 767px) {
  .mini-cart-content {
    background-color: rgba(0, 0, 0, 0);
    position: fixed;
    height: calc(100vh - 58px);
    width: 100%;
    top: 0;
    z-index: 3;
    right: -100%;
    display: flex;
    flex-direction: column;
    flex-wrap: wrap;
    max-width: 100%;
    align-content: flex-end;
    margin: 0;
    padding: 0;
    transition: right 0.3s ease 0s, background-color 0s ease 0s;
    &::before {
      content: none;
    }
    > * {
      background: #fff;
    }
    h4 {
      display: inline-flex;
      align-items: center;
      padding: 20px 15px;
      justify-content: space-between;
      i {
        font-size: 20px;
        &::before {
          font-weight: 900 !important;
        }
      }
    }
    .cart-panel-footer {
      padding: 0 15px;
    }
    .cart-list {
      max-width: 350px;
      -ms-max-width: 100%;
      margin: 0;
      display: inline-block;
      flex: 1 0;
      padding: 0;
      border-bottom: 1px solid #e5e5e5;
    }
  }
}
@media screen and (max-width: 360px) {
  .mini-cart-content {
    .cart-list {
      max-width: 100%;
    }
  }
}
</style>
