<template>
  <div id="firstLevelWrapper" :class="getActiveClass">
    <div
      v-for="item in items"
      :key="item.id"
      class="ul_level_1"
      :class="{ current: isCurrent(item.id) }"
      @mouseover="handleClick(item.id)"
    >
      <div class="ul_level_1_text" v-html="item.text"></div>
      <i class="icon-015-right"></i>
    </div>
  </div>
</template>

<script>
import { mapGetters, mapMutations, mapState } from 'vuex';
const firstLevel = {
  computed: {
    ...mapGetters('topMenu', { items: 'getFirstLevelItems' }),
    ...mapState('topMenu', {
      _current: 'currentFirstMenu',
      isMobile: 'isMobile',
    }),
    getActiveClass() {
      if (!this._current) return '';
      return `current_${this._current}`;
    },
    isCurrent() {
      return id => this._current === id;
    },
  },
  methods: {
    ...mapMutations('topMenu', { setCurrent: 'setCurrentFirstMenu' }),
    //Ставим задержку ,для того чтобы событие не передалось на
    //ссылки ,которые находяться за/под компонентом
    handleClick(id) {
      setTimeout(() => {
        this.setCurrent(id);
      }, 0);
    },
  },
};
export default firstLevel;
</script>

<style>
#firstLevelWrapper {
  background: #fff;
  padding: 0 0 10px 0;
  border: 1px solid #f1e4dd;
  border-radius: 0 0 0px 6px;
  -webkit-border-radius: 0 0 0px 6px;
  -moz-border-radius: 0 0 0px 6px;
  border-top: none;
  flex: 0 0 200px;
}
.ul_level_1 {
  display: block;
  padding: 11px 5px 11px 10px;
  font-size: 0.95em;
  position: relative;
  margin-top: 0;
}
.ul_level_1 i {
  position: absolute;
  top: 35%;
}
.ul_level_1 i:first-child {
  left: 15px;
}
.ul_level_1 i.icon-015-right {
  right: 12px;
}
.ul_level_1_text {
  margin-right: 30px;
  line-height: 1.3;
}
.current.ul_level_1 {
  color: #fff;
  background: #ccc;
}
@media screen and (max-width: 991px) and (min-width: 768px) {
  #firstLevelWrapper {
    flex: 0 0 170px;
  }
}
@media screen and (max-width: 767px) {
  .ul_level_1 i.icon-015-right {
    font-size: 20px;
  }
  .ul_level_1 {
    padding: 15px;
    font-size: 1em;
  }
  .ul_level_1:not(:first-child) {
    border-top: 1px solid #aaa;
  }
  #firstLevelWrapper {
    min-height: 100%;
    padding: 0;
    padding-bottom: 80px;
    border: none;
    border-radius: 0 0 6px 6px;
    -webkit-border-radius: 0 0 6px 6px;
    -moz-border-radius: 0 0 6px 6px;
  }
}
</style>
