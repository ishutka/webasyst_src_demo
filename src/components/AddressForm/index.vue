<template>
  <!-- на случай кастомизации, имеет слоты для каждого поля -->
  <div class="address-form">
    <slot name="title">
      <h3>{{ title }}</h3>
    </slot>

    <slot name="country">
      <div class="form-group">
        <label class="control-label col-xs-12 col-sm-5  col-md-3 col-lg-4">
          Страна
        </label>
        <div class="col-xs-12 col-sm-7 col-md-7">
          <select
            v-model="addressWrapper.data.country"
            :data-cy="`addressFormCountry_${index}`"
            class="form-control"
            @change="
              fetchRegions();
              updateAddressHandler();
            "
          >
            <option
              v-for="item in countries"
              :key="item.isonumeric"
              :selected="
                item.isonumeric === addressWrapper.data.country && 'selected'
              "
              :value="item.iso3letter"
            >
              {{ item.name }}
            </option>
          </select>
        </div>
      </div>
    </slot>

    <slot name="region">
      <div class="form-group">
        <label class="control-label col-xs-12 col-sm-5  col-md-3 col-lg-4">
          Регион
        </label>

        <div class="col-xs-12 col-sm-7 col-md-7">
          <div v-if="regionsAreLoading === true" class="loader-wrapper">
            <img
              src="/wa-apps/shop/themes/flip/img/loading16.gif"
              class="img-responsive"
            />
          </div>
          <select
            v-else-if="regions.length"
            v-model="addressWrapper.data.region"
            :data-cy="`addressFormRegionSelect_${index}`"
            class="form-control"
            @change="updateAddressHandler"
          >
            <option
              v-for="item in regions"
              :key="item.value"
              :value="item.value"
              :selected="item.value === addressWrapper.data.region"
            >
              {{ item.name }}
            </option>
            >
          </select>
          <input
            v-else
            v-model="addressWrapper.data.region"
            :data-cy="`addressFormRegionInput_${index}`"
            class="form-control"
            @change="updateAddressHandler"
          />

          <!-- <span v-if="showError('region')" class="colorRed">
          </span> -->
        </div>
      </div>
    </slot>

    <slot name="city">
      <div class="form-group">
        <label class="control-label col-xs-12 col-sm-5  col-md-3 col-lg-4">
          Город
        </label>
        <div class="col-xs-12 col-sm-7 col-md-7">
          <input
            v-model="addressWrapper.data.city"
            :data-cy="`addressFormCity_${index}`"
            class="form-control"
            @change="updateAddressHandler"
          />
          <!-- <span v-if="showError('city')" class="colorRed">
          </span> -->
        </div>
      </div>
    </slot>

    <slot name="street">
      <div class="form-group">
        <label class="control-label col-xs-12 col-sm-5  col-md-3 col-lg-4">
          Адрес
        </label>
        <div class="col-xs-12 col-sm-7 col-md-7 ">
          <input
            v-model="addressWrapper.data.street"
            :data-cy="`addressFormStreet_${index}`"
            class="form-control"
            @change="updateAddressHandler"
          />
          <!-- <span v-if="showError('street')" class="colorRed">
          </span> -->
        </div>
      </div>
    </slot>

    <!-- 
      NOTE: делал по не знанию, думал, что адресов может быть неограниченное количество, а оказывается, их может быть всего 2 (основной и адрес доставки)
        <slot name="delete">
        <div class="tc">
            <button
            class="btn btn-danger btn-sm"
            :data-cy="`addressFormDeleteBtn_${index}`"
            @click.prevent="deleteAddress(index)"
            >
            <span class="glyphicon glyphicon-remove"></span>
            удалить адрес
            </button>
        </div>
        </slot> 
    -->
  </div>
</template>
<script>
import cloneDeep from 'lodash/cloneDeep';
import HTTP from '@/plugins/http.js';
import { mapState, mapMutations } from 'vuex';
export default {
  props: {
    /*
        непосредственно сам адрес
    */
    address: {
      type: Object,
      required: true,
    },

    /*
        обновление адреса, по умолчанию функция из стора
    */
    updateAddressHandlerProp: {
      type: [Function, Boolean],
      required: false,
      default: false,
    },

    /*
        индекс адреса в списке адресов
    */
    index: {
      type: Number,
      required: false,
      default: 0,
    },
  },
  computed: {
    ...mapState('countries', ['countries']),
    addressWrapper() {
      return cloneDeep(this.address);
    },
    title() {
      if (this.address.ext === '')
        return 'Физический адрес (ваше местонахождение)';

      return 'Адрес доставки';
    },
  },
  created() {
    this.fetchRegions();
  },
  data() {
    return {
      regions: [],
      regionsAreLoading: false,
    };
  },
  methods: {
    updateAddressHandler() {
      if (this.updateAddressHandlerProp)
        this.updateAddressHandlerProp(this.addressWrapper);
      else this.updateAddress(this.addressWrapper);
    },
    async fetchRegions() {
      this.regionsAreLoading = true;
      const { data } = await HTTP.post('/data/regions/', {
        country: this.addressWrapper.data.country,
      });
      const options = Object.entries(data.data.options);
      this.regions = data.data.oOrder.map(value => {
        return {
          name: options.find(o => +o[0] === +value)[1],
          value: value,
        };
      });
      if (
        this.regions.length === 0 &&
        typeof this.addressWrapper.data.region === 'number'
      ) {
        this.addressWrapper.data.region = '';
        this.updateAddressHandler();
      }
      this.regionsAreLoading = false;
    },
    ...mapMutations('user', ['deleteAddress', 'updateAddress']),
  },
  watch: {
    'address.data.country'() {
      this.fetchRegions();
    },
  },
};
</script>
<style lang="scss">
.address-form {
  .loader-wrapper {
    display: inline-block;
    width: 35px;
    padding: 5px;
    margin: 0 10px;
  }
}
</style>
