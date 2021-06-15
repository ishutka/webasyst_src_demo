<template>
  <div
    id="secondLevelWrapper"
    :class="{
      'second-level-mob-opened': isMobile && parentCurrent,
    }"
  >
    <div
      v-if="isMobile"
      id="backToMainManu"
      @click="setCurrentFirstMenuToZerro"
    >
      <i class="icon-014-left"></i> <span>{{ title }}</span>
    </div>
    <div v-for="item in items" :key="item.id" class="ul_level_2">
      <div
        class="menu_heading"
        :class="{
          'empty-third-level': getThirdLevelItems(item.id).length == 0,
        }"
      >
        <a :href="item.url" v-html="item.text"></a>
      </div>
      <ThirdLevel :parent-id="item.id" />
    </div>
  </div>
</template>

<script>
import { mapGetters, mapMutations, mapState } from 'vuex';
import ThirdLevel from './components/thirdLevel/index.vue';
const secondLevel = {
  components: { ThirdLevel },
  methods: {
    ...mapMutations('topMenu', ['setCurrentFirstMenu']),
    setCurrentFirstMenuToZerro() {
      // Cначала удаляем класс и таймаут,чтобы успела пройти
      // transition,пока не изчез контент:
      document
        .querySelector('#secondLevelWrapper')
        .classList.remove('second-level-mob-opened');
      setTimeout(() => {
        this.setCurrentFirstMenu(0);
      }, 700);
    },
  },
  computed: {
    ...mapGetters('topMenu', { items: 'getSecondLevelItems' }),
    ...mapGetters('topMenu', ['getCurrentFirstMenu', 'getThirdLevelItems']),
    ...mapState('topMenu', {
      isMobile: 'isMobile',
      parentCurrent: 'currentFirstMenu',
      secondLevelHeight: 'menuHeight',
    }),
    checkThirdLevel() {
      return this.items.some(i => this.getThirdLevelItems(i.id).length > 0);
    },
    title() {
      return this.getCurrentFirstMenu && this.getCurrentFirstMenu.text;
    },
  },
};
export default secondLevel;
</script>

<style lang="scss">
#secondLevelWrapper {
  max-height: 500px;
  overflow: hidden;
  display: inline-block;
  max-width: calc(100% - 170px);
  color: #5391ce;
  margin: 0px;
  padding: 0px;
  background: #f9f9f9;
  border-radius: 0 0 6px 0px;
  -webkit-border-radius: 0 0 6px 0px;
  -moz-border-radius: 0 0 6px 0px;
  border: 1px solid #f1e4dd;
  border-top: none;
  border-left: none;
  -webkit-writing-mode: vertical-lr;
  -ms-writing-mode: tb-lr;
  writing-mode: vertical-lr;
  position: static;
  align-self: stretch;
  flex: 0 0 auto;
  -ms-flex: 1 0 auto;
  &.second-level-mob-opened {
    transition: right 0.5s linear;
  }
  .ul_level_2 .menu_heading a:hover {
    text-decoration: none;
  }
  .firdLevelMenu {
    margin-right: 15px;
  }
  .ul_level_2 {
    vertical-align: top;
    display: inline-block;
    width: 20vw;
    -webkit-writing-mode: lr-tb;
    -ms-writing-mode: lr-tb;
    writing-mode: lr-tb;
    line-height: 14px;
    margin-left: 15px;
    padding: 5px 0 10px 0;
    font-size: 1em;
    max-width: 200px;
  }

  #backToMainManu:hover {
    background: #5391ce;
    color: #eee;
  }
  #backToMainManu {
    text-align: left;
    width: 100%;
    padding: 15px;
    background: #f1e4dd;
    color: #000;
    line-height: 1;
    display: flex;
    align-items: center;
    -ms-flex-direction: row-reverse;
    span {
      order: 2;
      margin-right: auto;
    }
    i {
      font-size: 18px;
      margin-right: 15px;
      order: 1;
    }
  }
  .ul_level_2 .menu_heading a {
    padding: 10px 15px 10px 5px;
    display: block;
  }
  .ul_level_2 .menu_heading {
    font-weight: bold;
    margin: 0;
  }
  @media screen and (max-width: 991px) {
    max-height: 600px;
    margin-right: -50px;
    max-width: 100%;
    .ul_level_2 {
      width: 22vw;
    }
  }
  @media screen and (max-width: 767px) {
    background: #fff;
    -webkit-writing-mode: initial;
    -ms-writing-mode: rl-tb;
    writing-mode: initial;
    position: absolute;
    padding: 0;
    border: none;
    flex: 0 0 auto;
    right: -100%;
    overflow: auto;
    margin-right: 0;
    max-height: calc(
      100vh - 106px
    ); /*106 - сумма фиксированных верхнего и нижнего блока*/
    min-height: calc(100vh - 106px);
    top: 49px; /*49 - высота верхнего фиксированного блока  "Каталог товаров"*/
    transition: right 0.5s;
    &.second-level-mob-opened {
      right: 0;
    }
    .ul_level_2 {
      padding: 0;
      margin: 0;
      width: 100%;
      max-width: 100%;
    }
    .ul_level_2 .menu_heading a {
      padding: 15px;
    }
    .firdLevelMenu {
      padding: 8px 0 18px;
    }

    .firdLevelMenu > div:first-child {
      border-top: none;
    }
    .ul_level_2 .menu_heading {
      padding: 0px;
      border-top: solid 1px #aaa;
    }
    .ul_level_2:hover .menu_heading a {
      color: #f16522;
    }
    .ul_level_2 .menu_heading:not(.empty-third-level) {
      border-bottom: solid 1px #aaa;
    }
  }
}
</style>
