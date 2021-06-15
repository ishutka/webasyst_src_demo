<template>
  <transition name="back-to-top-fade">
    <button
      title="Прокрутить вверх страницы"
      :class="{ active: isVisible }"
      class="btn button-to-top"
      @click="backToTop"
    >
      <i class="icon-016-up"></i>
    </button>
  </transition>
</template>
<script>
export default {
  data() {
    return {
      isVisible: false,
    };
  },
  mounted() {
    window.addEventListener('scroll', this.checkIsVisible);
    window.smoothscroll = () => {
      const currentScroll =
        document.documentElement.scrollTop || document.body.scrollTop;
      if (currentScroll > 0) {
        window.requestAnimationFrame(window.smoothscroll);
        window.scrollTo(0, Math.floor(currentScroll - currentScroll / 5));
      }
    };
  },
  methods: {
    /**
     * The function who make the magics
     * @return {void}
     */
    backToTop() {
      window.smoothscroll();
      this.$emit('scrolled');
    },
    checkIsVisible() {
      if (window.pageYOffset > 500) this.isVisible = true;
      else this.isVisible = false;
    },
  },
};
</script>
<style lang="scss">
.button-to-top {
  transition: opacity 0.5s;
  position: fixed;
  right: 15px;
  bottom: 70px;
  background: #000;
  padding: 0px;
  border-radius: 50%;
  width: 35px;
  height: 35px;
  opacity: 0;
  z-index: 1;
  &.active {
    opacity: 1;
    box-shadow: none;
  }

  &:active {
    box-shadow: none;
    background: #f88c58;
  }
  &:focus {
    outline: none !important;
    background: #f88c58;
  }
  i {
    font-size: 25px;
    color: #000;
  }
  @media screen and (max-width: 767px) {
    i {
      color: #fff;
    }
  }
}
</style>
