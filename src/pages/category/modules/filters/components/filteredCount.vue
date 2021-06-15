<template>
  <div class="filtered-items-count">
    <div v-if="countAllInCategories && countAllInCategories !== count">
      Найдено <span>{{ count }}</span> из
      <span>{{ countAllInCategories }}</span>
    </div>
    <div v-else>
      Найдено <span>{{ count || productsCount }}</span>
    </div>
  </div>
</template>
<script>
import { mapState } from 'vuex';
export default {
  props: {
    productsCount: { type: Number, required: true },
  },
  computed: {
    ...mapState('category', ['countAllInCategories', 'count']),
  },
};
</script>
<style lang="scss">
.filtered-items-count {
  span {
    font-weight: 600;
  }
}
</style>
