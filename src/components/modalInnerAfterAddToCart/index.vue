<template>
  <div class="modal-inner-after-add-to-cart">
    <modal-close-button modal-name="container"></modal-close-button>
    <div class="h2">Товар успешно добавлен в корзину!</div>
    <a class="btn btn-block btn-success" @click="$modal.hide('container')">
      Продолжить покупки</a>
    <a class="btn btn-block btn-grey" href="/cart/">Перейти в корзину</a>
  </div>
</template>
<script>
import modalCloseButton from '@/components/modalCloseButton/index.vue';

export default {
  components: { modalCloseButton },
};
</script>
<style lang="scss">
@import '@/mainStylesVariables';
.modal-inner-after-add-to-cart {
  width: 270px;
  margin: 0 auto;
  .h2 {
    font-size: 24px;
    padding-left: 0;
    padding-right: 0;
  }
  .btn {
    font-size: 18px;
    margin: 0 0 15px;
  }
  .btn-grey {
    background: $huge_text;
    font-weight: 600;
    color: #fff;
  }
  @media screen and (max-width: 460px) {
    width: 240px;
  }
}
</style>
