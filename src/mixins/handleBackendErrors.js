export default {
  data: () => {
    return {
      backendErrors: {},
    };
  },
  methods: {
    hasBackendError(name) {
      return !!this.backendErrors[name];
    },
    showBackendError(name) {
      if (typeof this.backendErrors[name] === 'object') {
        if (this.backendErrors[name].length > 0)
          return this.backendErrors[name].join(' ');

        return Object.values(this.backendErrors[name]).join(' ');
      }
      return this.backendErrors[name];
    },
    handleBackendError(data) {
      if (data) this.backendErrors = data;
    },
    scrollToError() {
      let firstField = Object.keys(this.errors.collect())[0];
      if (!firstField) firstField = Object.keys(this.backendErrors)[0];

      this.$refs[`${firstField}_input`].scrollIntoView();
    },
  },
};
