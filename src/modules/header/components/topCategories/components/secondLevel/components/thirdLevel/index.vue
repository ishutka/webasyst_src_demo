<template>
  <div v-if="items.length > 0" class="firdLevelMenu">
    <div v-for="item in items" :key="item.id" class="ul_level_3">
      <a :href="item.url" v-html="item.text"></a>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex';
const thirdLevel = {
  props: {
    parentId: {
      type: Number,
      required: true,
    },
  },
  computed: {
    ...mapGetters('topMenu', ['getThirdLevelItems']),
    items() {
      return this.getThirdLevelItems(this.parentId);
    },
  },
};
export default thirdLevel;
</script>

<style>
.ul_level_3:first-child {
  border-top: solid 1px #d2d4ce;
  padding-top: 5px;
}

.ul_level_3 {
  display: block;
  font-size: 0.95em;
  position: relative;
  padding: 5px 3px 5px 15px;
}
@media screen and (max-width: 767px) {
  .ul_level_3:first-child {
    border-top: none;
  }
  .ul_level_3 {
    font-size: 1em;
  }
  .ul_level_3 a {
    padding: 5px 0;
    display: block;
  }
}
</style>
