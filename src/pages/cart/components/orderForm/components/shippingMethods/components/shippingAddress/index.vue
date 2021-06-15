<template>
  <div class="wa-form">
    <AddressForm :address="shippingAddress">
      <template slot="title">
        <div />
      </template>

      <template slot="country">
        <div />
      </template>
      <!-- eslint-disable -->
      <template
        v-if="
          !method.requested_address_fields.region ||
            (method.requested_address_fields.region &&
              method.requested_address_fields.region.hidden === true)
        "
        slot="region"
      >
        <div />
      </template>

      <template
        v-if="
          !method.requested_address_fields.city ||
            (method.requested_address_fields.city &&
              method.requested_address_fields.city.hidden === true)
        "
        slot="city"
      >
        <div />
      </template>

      <template
        v-if="
          !method.requested_address_fields.street ||
            (method.requested_address_fields.street &&
              method.requested_address_fields.street.hidden === true)
        "
        slot="street"
      >
        <div />
      </template>
    <!-- eslint-enable -->
    </AddressForm>
  </div>
</template>
<script>
import AddressForm from '@/components/AddressForm/index.vue';
import { mapGetters } from 'vuex';
export default {
  props: {
    method: {
      type: Object,
      required: true,
    },
  },
  components: { AddressForm },
  computed: {
    ...mapGetters('user', ['shippingAddress']),
  },
};
</script>
