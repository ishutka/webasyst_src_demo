<template>
  <div class="cart-wrapp">
    <a
      href="/cart/"
      class="mobile-btn-cart"
      :class="{ hovered: showCartContent }"
      @click.prevent="
        {
          if (isTouchScreen) toggleMiniCartProducts();
          else goToCart();
        }
      "
      @mouseenter="
        {
          if (!isTouchScreen) toggleMiniCartProducts();
        }
      "
    >
      <i class="icon-001-cart"></i>
      <span class="icon-cart-total-count badge badge-count">{{ count }}</span>
    </a>
    <miniCartContent v-if="count" />
  </div>
</template>

<script>
import { mapState, mapActions, mapMutations } from 'vuex';
import miniCartContent from './miniCartContent.vue';
const miniCartMobileLink = {
  components: { miniCartContent },
  created() {
    this.getCartData();
    this.setWidthWatcher();
  },
  computed: {
    ...mapState('topMenu', ['isTouchScreen']),
    ...mapState('miniCart', ['showCartContent']),
    ...mapState('cart', ['count']),
    activeMiddleFloatingCart() {
      if (
        // window.topOffsetMainContainer обьявляется и используется в header.js
        window.topOffsetMainContainer < 0 &&
        window.innerWidth > 767 &&
        window.innerWidth < 992
      )
        return true;
      return false;
    },
  },
  methods: {
    ...mapMutations('miniCart', ['setShowCartContent']),
    ...mapActions('cart', ['getCartData']),
    ...mapActions('topMenu', ['setWidthWatcher']),
    toggleMiniCartProducts() {
      if (this.showCartContent) this.setShowCartContent(false);
      else {
        if (!this.activeMiddleFloatingCart && !this.showCartContent)
          this.setShowCartContent(true);
        if (this.activeMiddleFloatingCart && !this.showCartContent)
          this.setShowCartContent(true);
      }
    },
    goToCart() {
      window.location = '/cart';
    },
  },
};
export default miniCartMobileLink;
</script>
<style lang="scss">
.mobile-btn-cart i {
  font-size: 30px;
}
.mobile-btn-cart {
  position: relative;
}
.icon-cart-total-count {
  position: absolute;
  bottom: -7px;
  right: -3px;
}
@media screen and (min-width: 768px) {
  .hovered + .mini-cart-content {
    opacity: 1;
    z-index: 5;
    top: 100%;
    transform: scaleX(1);
  }
}

@media screen and (max-width: 767px) {
  .hovered + .mini-cart-content {
    top: 0;
    right: 0;
    background-color: rgba(0, 0, 0, 0.75);
    transition: right 0.3s, background-color 0.2s ease-in 0.15s;
  }
}
</style>
