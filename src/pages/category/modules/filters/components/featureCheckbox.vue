<template>
  <Checkbox
    v-model="selected"
    :disabled="
      listThumbsIsLoading || (valueObj.count === 0 && !isChecked(valueObj.id))
    "
    :value="valueObj.id"
  >
    <div>
      {{ valueObj.value }}

      <span
        v-show="!isChecked(valueObj.id) && !listThumbsIsLoading"
        class="additional-quantity"
      >
        {{
          feature.search_logic === 1 && selected.length
            ? `(+${valueObj.count})`
            : `(${valueObj.count})`
        }}
      </span>
    </div>
  </Checkbox>
</template>

<script>
import cloneDeep from 'lodash/cloneDeep';
import { Checkbox } from 'vue-checkbox-radio';
import { mapState, mapMutations } from 'vuex';

export default {
  props: {
    isChecked: {
      type: Function,
      required: true,
    },
    disabled: {
      type: Boolean,
      required: true,
    },
    isMultiple: {
      type: Boolean,
      required: true,
    },
    valueObj: {
      type: Object,
      required: true,
    },
    feature: {
      type: Object,
      required: true,
    },
  },
  components: { Checkbox },
  computed: {
    ...mapState('products', ['listThumbsIsLoading']),
    ...mapState('category', ['selectedFilters']),
    selected: {
      get() {
        return this.selectedFilters[this.feature.alias] || '';
      },
      set(value) {
        const selectedFilters = cloneDeep(this.selectedFilters);
        let values = selectedFilters[this.feature.alias] || [];
        let url = '';
        if (value === true || value.includes(this.valueObj.id)) {
          values.push(this.valueObj.id);
          url = this.valueObj.url_with;
        } else {
          values = values.filter(v => v !== this.valueObj.id);
          url = this.valueObj.url_without;
        }
        const query = this.$route.query;
        // Удаляем параметр страницы при обновлении фильтров
        if (query.page) delete query.page;
        this.$router.push({ path: url, query });
        this.updateState([{ name: 'selectedFilters', value: selectedFilters }]);
      },
    },
  },
  methods: {
    ...mapMutations('category', ['updateState']),
  },
};
</script>
<style lang="scss">
.check-or-radio .additional-quantity {
  font-size: 13px;
  margin-left: 5px;
}
.check-or-radio.available:active .additional-quantity {
  color: #000;
}
</style>
