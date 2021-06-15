<template>
  <button
    id="compare-leash"
    data-cy="compareProducts"
    title="Сравнить выбранные продукты"
    :class="{ 'are-comparing': count > 0 }"
    :disabled="count == 0"
    @click="goToComparePage()"
  >
    <i class="icon-043-compare"></i>
    <span v-if="count > 0" class="comparing-count badge">{{ count }}</span>
  </button>
</template>

<script>
import { mapActions, mapGetters } from 'vuex';
export default {
  created() {
    this.getCompareCookies();
  },
  computed: {
    ...mapGetters('productCompare', ['compareHref', 'count']),
  },
  methods: {
    ...mapActions('productCompare', ['getCompareCookies']),
    goToComparePage() {
      window.location = this.compareHref;
    },
  },
};
</script>
<style lang="scss">
@import '@/mainStylesVariables.scss';
#compare-leash {
  border: none;
  background: transparent;
  position: relative;
  display: flex;
  width: 100%;
  height: 100%;
  align-items: center;
  justify-content: center;
  opacity: 0.45;
  border-radius: 3px;
  &.are-comparing {
    opacity: 1;
  }
  &[disabled] {
    opacity: 0.2;
  }
  &:active,
  &:focus {
    outline: none;
  }
  .comparing-count {
    position: absolute;
    background: $main_brand_color;
    color: #fff;
    bottom: -5px;
    right: -5px;
    padding: 3px 6px;
  }
}
</style>
