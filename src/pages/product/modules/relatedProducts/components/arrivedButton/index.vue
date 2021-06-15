<template>
  <button
    type="button"
    class="btn btn--report btn-block"
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
