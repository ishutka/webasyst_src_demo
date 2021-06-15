import translate from '@/filters/translate.js';
export default {
  filters: { translate },
  computed: {
    translations() {
      return window.translations;
    },
  },
};
