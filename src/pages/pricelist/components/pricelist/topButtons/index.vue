<template>
  <div>
    <a
      id="PriceListBtnShowAll"
      href="#"
      class="btn  btn-primary"
      @click.prevent="expandPricelist"
    >
      {{ buttonText }}
      <span
        class="glyphicon"
        :class="{
          'glyphicon-triangle-top': pricelistExpanded,
          'glyphicon-triangle-bottom': !pricelistExpanded,
        }"
      ></span>
    </a>
    <a
      id="PriceListBtnDownloadPrice"
      href="/pricelist_xls/"
      class="btn btn-primary"
    >
      <i class="fa fa-file-excel-o"></i> скачать прайс <strong>.xlsx</strong>
    </a>
  </div>
</template>

<script>
import { mapState, mapMutations } from 'vuex';

export default {
  computed: {
    ...mapState('pricelist', ['pricelistExpanded']),
    buttonText() {
      return this.pricelistExpanded ? 'свернуть все' : 'развернуть все';
    },
  },
  methods: {
    ...mapMutations('pricelist', ['expandPricelist']),
  },
};
</script>
