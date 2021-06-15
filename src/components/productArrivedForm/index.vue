<template>
  <div></div>
</template>

<script>
import ArrivedForm from './form.vue';
import { mapMutations, mapState } from 'vuex';
export default {
  props: {
    initSettings: {
      type: Object,
      required: true,
    },
  },
  created() {
    this.setSettings(this.initSettings);
    this.setValidationRules();
    this.setUserDataFromRootState();
  },
  computed: {
    ...mapState('productArrived', ['modalStatus']),
  },
  methods: {
    ...mapMutations('productArrived', [
      'setSettings',
      'setValidationRules',
      'setUserDataFromRootState',
      'setModalStatus',
    ]),
  },
  watch: {
    modalStatus(val) {
      if (val === true) {
        let modalWidth = '100%';
        if (window.innerWidth > 650) modalWidth = '600';
        this.$modal.show(
          ArrivedForm,
          {},
          {
            width: modalWidth,
            height: 640,
            name: 'container',
            classes: ['arrived-form', 'v--modal'],
            scrollable: true,
          },
          {
            closed: () => {
              this.setModalStatus(false);
            },
          },
        );
      }
    },
  },
};
</script>
<style lang="scss">
.arrived-form {
  background: #fff;
  display: flex;
  align-items: center;
}
</style>
