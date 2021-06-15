<template>
  <div
    id="category-menu"
    :class="{
      'mobile-menu-slide': isMobile, //по классу .mobile-menu-slide  на моб.устройствах реализуется transition
      'hide-on-full-screen': !isMobile && !menuIsSwitched, //класс .hide-on-full-screen прячет меню на full-screen уст-вах
    }"
  >
    <div class="main-menus-wrapper">
      <div class="h3">
        <h3>Каталог товаров</h3>
        <i class="icon-012-closedelete" @click="pushMenuButton()"></i>
      </div>
      <first-level></first-level>
      <second-level></second-level>
    </div>
  </div>
</template>

<script>
import { mapActions, mapState, mapMutations } from 'vuex';
import firstLevel from './components/firstLevel/index.vue';
import secondLevel from './components/secondLevel/index.vue';
export default {
  components: {
    firstLevel,
    secondLevel,
  },
  created() {
    this.getMenu();
    this.setWidthWatcher();
  },
  computed: {
    ...mapState('topMenu', ['menuIsSwitched', 'isMobile']),
  },
  methods: {
    ...mapActions('topMenu', ['getMenu', 'setWidthWatcher']),
    ...mapMutations('topMenu', ['pushMenuButton']),
  },
};
</script>
<style lang="scss">
#category-menu {
  &.hide-on-full-screen {
    display: none;
  }
  &.mobile-menu-slide {
    transition: right 0.3s linear;
    .main-menus-wrapper {
      display: flex;
      flex-wrap: wrap;
      max-height: 100%;
      height: 100%;
      position: relative;
    }
    .h3 {
      margin: 0;
      padding: 15px;
      background: #f16522;
      flex: 0 0 100%;
      align-self: end;
      display: none;
      align-items: center;
      justify-content: space-between;
      max-width: 100%;
      h3 {
        margin: 0;
        color: #fff;
        font-size: 18px;
        font-weight: 600;
      }
      i {
        font-size: 18px;
        color: #000;
      }
    }
  }

  .main-menus-wrapper {
    display: flex;
    justify-content: flex-start;
    max-height: 600px;
    flex: 0;
    -ms-flex: 0 0 auto;
    .h3 {
      display: none;
    }
  }
  @media screen and (max-width: 767px) {
    .main-menus-wrapper .h3 {
      display: flex;
    }
    #secondLevelWrapper,
    #firstLevelWrapper {
      min-width: 310px;
      width: 100%;
      flex: 0 0 auto;
    }

    #firstLevelWrapper {
      width: 100%;
    }
  }
  @media screen and (max-width: 360px) {
    .main-menus-wrapper {
      flex: 1;
    }
    #secondLevelWrapper,
    #firstLevelWrapper {
      width: 100%;
      max-width: 100%;
    }
  }
}
</style>
