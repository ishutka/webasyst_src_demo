<template>
  <button
    type="button"
    class="btn btn--report btn-block"
    :data-cy="dataCyDirectiveValue"
    :disabled="formIsAlreadySubmit"
    :class="{ 'form-is-already-submit': formIsAlreadySubmit }"
    @click="
      setProductId(id);
      setModalStatus(true);
    "
  >
    {{ buttonText }}
  </button>
</template>

<script>
import productArrivedButton from '@/mixins/productArrivedButton.js';
export default {
  mixins: [productArrivedButton],
};
</script>

<style>
.form-is-already-submit {
  background-color: #fff !important;
  border-color: #fb7c00;
  color: #fb7c00;
  &:hover {
    color: #fb7c00;
  }
}
</style>
