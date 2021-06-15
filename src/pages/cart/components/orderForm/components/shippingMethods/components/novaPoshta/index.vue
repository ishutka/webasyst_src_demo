<template>
  <div class="wa-form">
    <slot name="area">
      <div>
        <span style="font-weight: bold;">Регион</span>
        <div>
          <VueSelect
            v-model="np_area"
            index="Ref"
            label="DescriptionRu"
            :options="areas"
          />
        </div>
      </div>
    </slot>

    <slot name="city">
      <div>
        <span style="font-weight: bold;">Город</span>
        <div>
          <VueSelect
            v-model="np_city"
            index="Ref"
            label="DescriptionRu"
            :options="cities"
          />
        </div>
      </div>
    </slot>

    <slot name="warehouse">
      <div>
        <span style="font-weight: bold;">Склад</span>
        <div>
          <VueSelect
            v-model="np_warehouse"
            index="Ref"
            label="DescriptionRu"
            :options="warehouses"
          />
        </div>
      </div>
    </slot>
  </div>
</template>
<script>
import HTTP from '@/plugins/http.js';
import VueSelect from 'vue-select';
import cloneDeep from 'lodash/cloneDeep';
import { mapGetters, mapMutations, mapState } from 'vuex';
import eventsBus from '@/eventsBus.js';

export default {
  created() {
    this.fetchAreas();
  },
  components: { VueSelect },
  props: {
    /*
      id метода доставки, для которого осуществляется подбор отделения
    */
    shippingId: {
      type: Number,
      required: true,
    },
  },
  data() {
    return {
      np_area: '',
      np_city: '',
      np_warehouse: '',
      areas: [],
      cities: [],
      warehouses: [],
    };
  },
  mounted() {
    this.np_area = this.user.np_area;
    this.np_city = this.user.np_city;
    this.np_warehouse = this.user.np_warehouse;

    eventsBus.$on('beforeOrderCreated', () => {
      /* 
        если пользователь выбрал текущий способ доставки, то перед созданием заказа, я записываю в адрес информацию о регионе, городе, складе.
      */
      if (this.shippingId === this.shipping_id) {
        const address = {
          ...cloneDeep(this.shippingAddress),
        };
        address.data.country = 'ukr';
        address.data.region = this.area.DescriptionRu || address.data.region;
        address.data.city = this.city.DescriptionRu || address.data.city;
        address.data.street =
          this.warehouse.DescriptionRu || address.data.street;

        address.data.np_area = this.np_area;
        address.data.np_city = this.np_city;
        address.data.np_warehouse = this.np_warehouse;
        this.updateAddress(address);
      }
    });
  },
  computed: {
    area() {
      return this.areas.find(a => a.Ref === this.np_area) || {};
    },
    city() {
      return this.cities.find(c => c.Ref === this.np_city) || {};
    },
    warehouse() {
      return this.warehouses.find(w => w.Ref === this.np_warehouse) || {};
    },
    ...mapGetters('user', ['shippingAddress']),
    ...mapState('user', ['user']),
    ...mapState('orderForm', ['shipping_id']),
  },
  methods: {
    fetchAreas() {
      HTTP.get('/json/novaPoshtaAreas/').then(response => {
        this.areas = response.data.data.areas;
        if (this.areas.length > 0 && !this.np_area)
          this.np_area = this.areas[0].Ref;
      });
    },
    fetchCities() {
      HTTP.post('/json/novaPoshtaCities/', {
        area: this.np_area,
      }).then(response => {
        this.cities = response.data.data.cities;
        if (
          this.cities.length > 0 &&
          !this.cities.find(c => c.Ref === this.np_city)
        )
          this.np_city = this.cities[0].Ref;
      });
    },
    fetchWarehouses() {
      HTTP.post('/json/novaPoshtaWarehouses/', {
        city: this.np_city,
      }).then(response => {
        this.warehouses = response.data.data.warehouses;
        if (
          this.warehouses.length > 0 &&
          !this.warehouses.find(w => w.Ref === this.np_warehouse)
        )
          this.np_warehouse = this.warehouses[0].Ref;
      });
    },
    ...mapMutations('user', ['updateAddress', 'update']),
  },
  watch: {
    np_area: function() {
      this.fetchCities();
    },
    np_city: function() {
      this.fetchWarehouses();
    },
    np_warehouse: function() {
      this.update({
        name: 'np_area',
        value: this.np_area,
      });

      this.update({
        name: 'np_city',
        value: this.np_city,
      });

      this.update({
        name: 'np_warehouse',
        value: this.np_warehouse,
      });
    },
  },
};
</script>
