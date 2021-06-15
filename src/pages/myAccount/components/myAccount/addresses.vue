<template>
  <div>
    <div
      v-if="user.addresses.length === 0"
      data-cy="addressesIsEmpty"
      class="tc alert alert-warning"
    >
      Список ваших адресов пуст
    </div>
    <div v-else>
      <div v-for="(address, key) in user.addresses" :key="key">
        <!-- NOTE: т.к. на беке принимается только адрес доставки, то основной адрес не вывожу -->
        <address-form
          v-if="address.ext === 'shipping'"
          :index="key"
          :address="address"
        >
        </address-form>
      </div>
    </div>

    <!-- 
      NOTE: делал по не знанию, думал, что адресов может быть неограниченное количество, а оказывается, их может быть всего 2 (основной и адрес доставки)
      <div class="tc">
      <button
        data-cy="addressFormAddBtn"
        class="btn btn-sm btn-success"
        @click.prevent="addAddress"
      >
        <i class="fa fa-plus fa-1x fa-inverse"></i>
        Добавить адрес
      </button>
    </div> 
    -->
  </div>
</template>
<script>
import addressForm from '@/components/AddressForm/index.vue';
import { mapState, mapActions, mapMutations } from 'vuex';
export default {
  created() {
    this.fetchCountries();
  },
  components: { addressForm },
  computed: {
    ...mapState('user', ['user']),
  },
  methods: {
    ...mapActions('countries', ['fetchCountries']),
    ...mapMutations('user', ['addAddress']),
  },
};
</script>
