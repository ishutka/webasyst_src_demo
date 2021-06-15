<template>
  <div id="filter_item_drop_out_of_stock" class="feature">
    <p class="feature-heading">Наличие на складе</p>
    <Checkbox
      v-model="selected"
      :disabled="listThumbsIsLoading"
      :value="2"
      :class="{ checked_item: selected }"
    >
      есть на складе
    </Checkbox>
  </div>
</template>
<script>
import { mapState, mapMutations } from 'vuex';
import { Checkbox } from 'vue-checkbox-radio';
import cloneDeep from 'lodash/cloneDeep';

export default {
  components: { Checkbox },
  computed: {
    ...mapState('category', ['selectedFilters']),
    ...mapState('products', ['listThumbsIsLoading']),
    selected: {
      get() {
        return this.selectedFilters[this.alias];
      },
      set(value) {
        const selectedFilters = cloneDeep(this.selectedFilters);
        const query = cloneDeep(this.$route.query); // потому что не обновляется роут в браузере, если без cloneDeep
        if (value === true) {
          selectedFilters.drop_out_of_stock = 2; // т.к. нам нужно передавать значение именно 2, а Checkbox нам возвращает буль
          query.drop_out_of_stock = 2;
        } else {
          delete selectedFilters.drop_out_of_stock;
          delete query.drop_out_of_stock;
        }
        this.updateState([{ name: 'selectedFilters', value: selectedFilters }]);
        // Удаляем параметр страницы при обновлении фильтров
        if (query.page) delete query.page;
        this.$router.push({ query });
      },
    },
  },
  data() {
    return { alias: 'drop_out_of_stock' };
  },
  methods: {
    ...mapMutations('category', ['updateState']),
  },
};
</script>
