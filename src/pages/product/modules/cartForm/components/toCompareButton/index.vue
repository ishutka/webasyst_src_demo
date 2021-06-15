<template>
  <div class="row margin-top">
    <div
      v-if="buttonFunction == 'add'"
      data-cy="toCompareButton"
      class="col-xs-12 col-sm-6 col-lg-12"
      @click="compareProduct"
    >
      <div class="compare-add btn-block tl btn btn-default">
        <i class="fa fa-plus"></i> сравнить
      </div>
    </div>
    <div v-if="buttonFunction == 'remove'" class="col-xs-12 col-sm-6 col-lg-12">
      <div
        data-cy="removeFromCompare"
        class="compare-remove  tl  btn-block btn btn-default"
        @click="compareProduct"
      >
        <span class="glyphicon glyphicon-remove"></span> <span>удалить</span>
        <span class="hidden-xs">из сравнения</span>
      </div>
      <a class="btn btn-block tl btn-default" :href="compareHref">
        Сравнить ({{ count }})
      </a>
    </div>
  </div>
</template>

<script>
import toCompareButton from '@/mixins/toCompareButton.js';
import { mapGetters } from 'vuex';
export default {
  mixins: [toCompareButton],
  computed: {
    ...mapGetters('productCompare', ['compareHref', 'count']),
  },
};
</script>
<style>
.margin-top {
  margin-top: 5px;
}
</style>
