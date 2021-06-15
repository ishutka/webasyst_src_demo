<template>
  <a
    href="#"
    :data-cy="`compare_${productId}`"
    class="compare-btn compare"
    title="Добавить товар к сравнению"
    @click.prevent="compareProduct"
  >
    <i class="icon-043-compare" title="Добавить для сравнения"></i>
    <img
      v-if="buttonFunction == 'remove'"
      class="compare-btn__svg-check"
      alt="is compared svg"
      src="/wa-apps/shop/themes/flip/img/category/check.svg"
    />
    <span>Добавить для сравнения</span>
  </a>
</template>

<script>
import toCompareButton from '@/mixins/toCompareButton.js';
export default {
  mixins: [toCompareButton],
};
</script>
<style lang="scss">
.compare-btn.compare {
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 12px;
  color: #999;
  i {
    font-size: 24px;
    margin-right: 10px;
  }
  img {
    width: 18px;
    margin: -10px 6px 5px -24px;
  }
}
</style>
