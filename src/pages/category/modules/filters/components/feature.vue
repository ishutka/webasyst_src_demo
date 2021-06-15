<template>
  <div
    v-show="feature.values.length > 0 || feature.alias === 'price'"
    class="feature"
    :class="{ 'is-closed': !isOpened }"
  >
    <Component :is="type" v-if="feature.alias === 'price'" />
    <div v-else>
      <p
        :data-cy="`feature-heading-${feature.alias}`"
        class="feature-heading"
        tabindex="0"
        @click="isOpened = !isOpened"
      >
        <span :title="feature.name">{{ feature.name }}</span>
        <i v-show="isOpened" class="icon-013-down"></i>
        <i v-show="!isOpened" class="icon-016-up"></i>
      </p>
      <div class="filter_content" :class="{ active: showAll }">
        <div>
          <div
            v-for="(value, index) in feature.values"
            :key="`${value.id}_${value.value}`"
            :data-cy="value.alias"
            class="check-or-radio"
            :class="{
              'opened-feature': isOpened && (index < 6 || showAll),
              available: !(value.count === 0 && !isChecked(value.id)),
            }"
          >
            <Component
              :is="type"
              v-model="selected"
              :is-multiple="isMultiple"
              :is-checked="isChecked"
              :class="{ checked_item: isChecked(value.id) }"
              :feature="feature"
              :value-obj="value"
              :disabled="
                listThumbsIsLoading ||
                  (value.count === 0 && !isChecked(value.id))
              "
              :value="value.id"
            >
              {{ value.value }}

              <span
                v-show="!isChecked(value.id) && !listThumbsIsLoading"
                class="additional-quantity"
              >
                {{
                  feature.search_logic === 1 && selected.length > 0
                    ? `(+${value.count})`
                    : `(${value.count})`
                }}
              </span>
            </Component>
          </div>
        </div>
        <div
          v-if="feature.values.length > 6"
          class="moreAndLess"
          @click.prevent="showAll = !showAll"
        >
          <a v-if="!showAll" href="#" class="moreLess">
            <span>показать все</span>
            <i class="icon-013-down"></i>
          </a>
          <a v-else href="#" class="moreLess">
            <span>популярные</span>
            <i class="icon-016-up"></i>
          </a>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import { mapState, mapMutations } from 'vuex';
import featurePrice from './featurePrice.vue';
import featureCheckbox from './featureCheckbox.vue';

export default {
  props: {
    feature: { type: Object, required: true },
  },
  data() {
    return {
      isOpened: true,
      showAll: false,
    };
  },
  mounted() {
    this.checkScreenWidth();
    window.addEventListener('resize', this.checkScreenWidth);
  },
  computed: {
    ...mapState('category', ['selectedFilters']),
    ...mapState('products', ['listThumbsIsLoading']),

    isMultiple() {
      return this.feature.multiple === 1;
    },
    type() {
      if (this.feature.alias === 'price') return featurePrice;
      return featureCheckbox;
    },

    selected: {
      get() {
        return this.selectedFilters[this.feature.alias] || [];
      },
      set(value) {
        /* 
          const selectedFilters = cloneDeep(this.selectedFilters);
          const values = selectedFilters[this.feature.alias];
          if (value) values.push();
          else {
          }
          selectedFilters[this.feature.alias] = values;
        */
        /*
        
        this.updateState([{ name: 'selectedFilters', value: selectedFilters }]);
*/
      },
    },
  },
  methods: {
    checkScreenWidth() {
      const length = this.selected.length || this.selected.toString().length;
      const width = window.innerWidth;
      if (this.feature.alias !== 'price')
        if (767 < width && width < 992 && length == 0) this.isOpened = false;
        else this.isOpened = true;
    },
    checkAllShow() {
      if (!this.showAll) this.isOpened = !this.isOpened;
    },
    isChecked(id) {
      return this.selected.includes(id); // if (this.isMultiple)
      // return this.selected.toString() === id.toString();
    },
    ...mapMutations('category', ['updateState']),
  },
};
</script>
<style lang="scss">
.feature {
  transition: padding 0.5s ease;
  &.is-closed {
    padding: 25px 20px 0 !important;
  }
  p:focus {
    outline: none;
  }
  p {
    margin-bottom: 15px;
    font-size: 16px;
    overflow: hidden;
    text-overflow: ellipsis;
  }
  &:not(#filter_item_drop_out_of_stock) .feature-heading:hover {
    cursor: pointer;
  }
  .feature-heading {
    white-space: nowrap;
    position: relative;
    text-transform: uppercase;
    font-size: 18px;
    margin-bottom: 25px;
    span {
      margin-right: 20px;
    }
  }
  .feature-heading i {
    position: absolute;
    right: 0;
    background: #f5f5f5;
    top: 2px;
    height: 14px;
    font-size: 20px;
  }

  #filter_item_price.is-closed .filter_content,
  &.is-closed .filter_content {
    max-height: 0;
  }
  .filter_content {
    transition: all 0.5s ease;
    max-height: 2000px;
    overflow: hidden;
  }
  .filter_content > div:not(.slider-wrapper):first-child {
    max-height: 250px;
    transition: all 0.5s ease;
    overflow: hidden;
    margin-bottom: 5px;
  }
  .filter_content.active > div:first-child {
    max-height: 2000px;
  }
  .moreLess {
    text-decoration: none;
    margin-left: 5px;
    margin-bottom: 5px;
    display: block;
  }
  .moreAndLess i {
    font-size: 18px;
  }
  .check-or-radio.opened-feature {
    max-height: 100px;
  }
  .check-or-radio label {
    margin: 8px 5px;
    line-height: 15px;
  }
  .check-or-radio {
    overflow: hidden;
    max-height: 0;
    transition: max-height 0.5s ease;
  }
  @media screen and (max-width: 991px) {
    &.is-closed {
      padding: 30px 20px 0 !important;
    }
    p:active {
      background: #f4f4f4;
    }
    p {
      text-transform: uppercase;
      font-size: 14px;
      margin: 0;
      display: flex;
      align-items: center;
      max-width: 100%;
    }
  }
}
</style>
