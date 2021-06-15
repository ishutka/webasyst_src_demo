<template>
  <span class="rating nowrap">
    <i
      v-for="item in 5"
      :key="item"
      :class="{
        'icon-033-halfrate': value / item < 1 && item - value < 1,
        full: item <= value,
      }"
      class="icon-032-fullrate"
    >
    </i>
  </span>
</template>
<script>
export default {
  props: {
    value: {
      type: Number,
      required: true,
    },
  },
};
</script>
<style lang="scss">
@import '@/mainStylesVariables.scss';
.rating.nowrap {
  .icon-033-halfrate {
    position: relative;
  }
  .icon-032-fullrate {
    font-size: 13px;
    margin-right: 3px;
    color: $huge_text;
  }
  .icon-033-halfrate:before,
  .icon-032-fullrate.full:before {
    color: $yellow_color;
    position: relative;
  }
  .icon-033-halfrate:before {
    z-index: 1;
    overflow: hidden;
    width: 6.5px;
    margin-right: 6.5px;
    display: block;
  }
  .icon-032-fullrate.icon-033-halfrate:after {
    content: '\e01e';
    font-family: 'flip-iconsfont' !important;
    font-style: normal !important;
    font-weight: normal !important;
    font-variant: normal !important;
    text-transform: none !important;
    speak: none;
    line-height: 1;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    position: absolute;
    left: 0;
    top: 0;
  }
}
</style>
