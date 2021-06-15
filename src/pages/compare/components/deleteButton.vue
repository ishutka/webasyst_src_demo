<template>
  <p>
    <button class="btn btn-xs btn-default" @click.prevent="deleteItem()">
      <i class="fa fa-close"></i>
      удалить
    </button>
  </p>
</template>

<script>
import { mapGetters, mapActions, mapMutations } from 'vuex';
export default {
  props: {
    productId: {
      type: Number,
      required: true,
    },
  },
  computed: {
    ...mapGetters('productCompare', ['compareHref']),
  },
  methods: {
    deleteItem() {
      this.removeProduct(this.productId);
      this.setCompareCookies();
      window.location.href = this.compareHref;
    },
    ...mapMutations('productCompare', ['removeProduct']),
    ...mapActions('productCompare', ['setCompareCookies']),
  },
};
</script>
