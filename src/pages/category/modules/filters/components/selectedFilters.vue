<template>
  <div v-if="selectedFiltersArray.length" id="selectedFiltersInfo">
    <p>
      АКТИВНЫЕ ФИЛЬТРЫ
    </p>
    <div v-for="f in selectedFiltersArray" :key="f.id" class="selected-filters">
      <a
        href="#"
        :title="`${f.featureName}: ${f.title}`"
        @click.prevent="deleteItem(f)"
      >
        <i class="icon-012-closedelete"></i> {{ f.title }}
      </a>
    </div>

    <a href="#" @click.prevent="clearFilters">
      <i class="icon-012-closedelete"></i> СБРОСИТЬ ВСЕ ФИЛЬТРЫ
    </a>
  </div>
</template>
<script>
import { mapState, mapGetters, mapMutations } from 'vuex';
import cloneDeep from 'lodash/cloneDeep';
/* 
  TODO: убрать debounce обновления данных (стоит вотчер на изменение роута)
  * т.к. нет смысла тут в debounce
*/
export default {
  computed: {
    ...mapState('category', ['filters', 'selectedFilters', 'categoryUrl']),
    ...mapGetters('category', ['selectedFiltersArray']),
    ...mapState('products', ['listThumbsIsLoading']),
  },
  methods: {
    ...mapMutations('category', ['updateState']),
    deleteItem({ alias, value }) {
      const filter = this.filters.find(f => f.alias === alias);
      if (filter) {
        const valueObj = filter.values.find(v => v.id === value);
        const query = this.$route.query;
        // Удаляем параметр страницы при обновлении фильтров
        if (query.page) delete query.page;
        this.$router.push({
          path: valueObj.url_without,
          query,
        });
        return;
      }
      const selectedFilters = cloneDeep(this.selectedFilters);
      delete selectedFilters[alias];
      this.updateState([{ name: 'selectedFilters', value: selectedFilters }]);

      const query = cloneDeep(this.$route.query); // потому что не обновляется роут в браузере, если без cloneDeep
      delete query[alias];
      // Удаляем параметр страницы при обновлении фильтров
      if (query.page) delete query.page;
      this.$router.push({ query });
    },
    clearFilters() {
      this.updateState([{ name: 'selectedFilters', value: [] }]);
      this.$router.push({ path: this.categoryUrl });
    },
  },
};
</script>
<style lang="scss">
#selectedFiltersInfo {
  .selected-filters {
    margin-bottom: 10px;
  }
  a {
    text-transform: uppercase;
    white-space: nowrap;
  }
  p {
    margin-bottom: 25px;
    font-size: 16px;
  }
}
</style>
