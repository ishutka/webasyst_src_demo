<template>
  <li
    v-show="categories || products"
    :id="`category_${category.id}`"
    data-cy="category"
  >
    <a
      :id="`toggleButton_${category.id}`"
      :href="category.frontend_url"
      class="pricelist_cat_btn"
      :disabled="buttonDisabled"
      @click.prevent="showNestedCategories"
    >
      <span
        class="showNestedButton glyphicon "
        :class="[showNested ? 'glyphicon-minus' : 'glyphicon-plus']"
      >
      </span>
      <span>{{ category.name }}</span>
    </a>
    <!-- список продуктов -->
    <div
      v-if="showNested && products"
      :id="`products_${category.id}`"
      class="product pricelist_products"
    >
      <table class="table table-hover table-striped">
        <tbody>
          <tr>
            <th>Наименование</th>
            <th class="pricelist_products_price_default tc">Розница</th>
            <th v-for="price in getPriceCategories" :key="price.category_id">
              {{ price.name }}
            </th>
            <th class="tc">Количество</th>
            <th></th>
          </tr>
          <Product
            v-for="product in products"
            :key="product.id"
            :product="product"
          />
        </tbody>
      </table>
    </div>
    <ul
      v-if="showNested && categories"
      :id="`categories_${category.id}`"
      class="nav pricelist_sub_categories"
    >
      <Category
        v-for="childCategory in categories"
        :key="childCategory.id"
        :category="childCategory"
        class="category"
      >
      </Category>
    </ul>
  </li>
</template>

<script>
import Product from './product/index.vue';
import { mapState, mapGetters, mapMutations } from 'vuex';
const category = {
  name: 'Category',
  components: { Product },
  props: {
    category: {
      type: Object,
      require: false,
      default: () => {
        return {};
      },
    },
  },
  mounted() {
    this.$nextTick(() => {
      this.hideRenderingLoader(); ///Коли всі "вкладені" компоненти будь знищені, то ми приберемо лоадер
    });
  },
  destroyed() {
    this.$nextTick(() => {
      this.hideRenderingLoader(); ///Коли всі "вкладені" компоненти будь створені, то ми приберемо лоадер
    });
  },
  created() {
    this.expandTable(this.pricelistExpanded);
  },
  data() {
    return {
      showNested: false,
    };
  },
  computed: {
    ...mapState('pricelist', ['pricelistExpanded']),
    ...mapState('pricelist', {
      productsArr: 'products',
      categoriesArr: 'categories',
    }),
    ...mapGetters('pricelist', ['getPriceCategories']),
    products() {
      const products = this.productsArr.filter(
        pr => pr.category_id == this.category.id,
      );
      if (products.length) return products;
      return false;
    },
    categories() {
      const сategories = this.categoriesArr.filter(
        ctg => ctg.parent_id == this.category.id,
      );
      if (сategories.length) return сategories;
      return false;
    },
    buttonDisabled() {
      return !this.products && !this.categories;
    },
  },
  methods: {
    ...mapMutations('pricelist', ['hideRenderingLoader']),
    showNestedCategories() {
      this.showNested = !this.showNested;
    },
    expandTable(pricelistExpanded) {
      this.showNested = pricelistExpanded ? true : false;
    },
  },
  watch: {
    pricelistExpanded: function(boolean) {
      this.expandTable(boolean);
    },
  },
};
export default category;
</script>
<style lang="scss">
[data-cy='category'] {
  table {
    display: block;
    overflow-x: auto;
  }
  .nav > li > a {
    display: flex;
    text-decoration: none;
  }
  .showNestedButton {
    margin-right: 5px;
  }
  .categoryName {
    display: inline-block;
  }
  .pricelist_sub_categories,
  .pricelist_products {
    margin-left: 20px;
    margin-top: 10px;
  }
  .pricelist_products_price_default,
  .pricelist_products_count {
    width: 10%;
    white-space: nowrap;
  }
  .pricelist_products_remove {
    width: 10%;
  }
  @media screen and (max-width: 767px) {
    .pricelist_products {
      margin-left: 0px;
    }
    table.table th {
      font-size: 0.75em;
    }
    .nav > li > a {
      padding-left: 8px;
      padding-right: 8px;
    }
    table.table td {
      font-size: 0.75em;
    }
  }
  @media screen and (max-width: 400px) {
    .table > tbody > tr > th {
      padding: 8px 4px;
    }
  }
  @media screen and (max-width: 450px) {
    .table > tbody > tr > td {
      padding: 8px 4px;
    }
  }
  @media screen and (max-width: 350px) {
    .pricelist_products {
      margin-left: -7px;
    }
    .pricelist_sub_categories .pricelist_products {
      margin-left: -23px;
    }
  }
}
</style>
