<template>
  <div class="closedelete" @click="hide(modalName)">
    <i data-v-5ec26f9c="" class="icon-012-closedelete"></i>
  </div>
</template>
<script>
import modalMixin from '@/mixins/modalMixin.js';

export default {
  props: { modalName: { type: String, required: true } },
  mixins: [modalMixin],
};
</script>
<style lang="scss">
@import '@/mainStylesVariables.scss';

.v--modal-overlay {
  .closedelete {
    position: absolute;
    right: 15px;
    top: 15px;
    width: 34px;
    height: 34px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: $link_color;
    color: #fff;
    cursor: pointer;
    z-index: 1;
    i {
      font-size: 16px;
      line-height: 0;
    }
  }
}
</style>
