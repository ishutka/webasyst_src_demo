<template>
  <div class="row">
    <div v-if="varchar_id" class=" col-xs-12">
      <div ref="orderSendedSuccess" class="alert alert-success">
        <p>
          Спасибо, Ваш заказ успешно создан, мы свяжемся с Вами в ближайшем
          времени.
        </p>
        <p>
          Номер заказа: <strong>#{{ varchar_id }}</strong>
        </p>

        <div v-html="paymentForm" />
      </div>
    </div>
    <form
      v-else-if="items.length > 0"
      class="form-horizontal col-xs-11"
      @submit.prevent="validateForm"
    >
      <div class="wrapCheckoutFormContact">
        <div class="checkoutFormContact">
          <div class="form-group ">
            <label class="col-xs-5 col-md-4 col-lg-3 control-label ">
              Фамилия <span class="required_star">*</span>
            </label>
            <div class="col-xs-7 col-md-8 col-lg-9 control-label">
              <input
                ref="lastnameInput"
                v-model="fieldsList.lastname"
                v-validate="{ required: true }"
                data-cy="lastnameInput"
                class="form-control"
                name="lastname"
              />
              <span v-if="errors.has('lastname')" class="colorRed">
                {{ errors.first('lastname') }}
              </span>
              <div v-if="backendErrors.lastname" class="alert alert-danger">
                {{ backendErrors.lastname }}
              </div>
            </div>
          </div>

          <div class="form-group ">
            <label class="col-xs-5  col-md-4 col-lg-3 control-label ">
              Имя <span class="required_star">*</span>
            </label>
            <div class="col-xs-7 col-md-8 col-lg-9 control-label ">
              <input
                ref="firstnameInput"
                v-model="fieldsList.firstname"
                v-validate="{ required: true }"
                data-cy="firstnameInput"
                class="form-control"
                name="firstname"
              />
              <span v-if="errors.has('firstname')" class="colorRed">
                {{ errors.first('firstname') }}
              </span>
              <div v-if="backendErrors.firstname" class="alert alert-danger">
                {{ backendErrors.firstname }}
              </div>
            </div>
          </div>

          <div class="form-group ">
            <label class="col-xs-5  col-md-4 col-lg-3 control-label ">
              Отчество
            </label>
            <div class="col-xs-7  col-md-8 col-lg-9 control-label ">
              <input
                ref="middlenameInput"
                v-model="fieldsList.middlename"
                data-cy="middlenameInput"
                class="form-control"
                name="middlename"
              />
              <span v-if="errors.has('middlename')" class="colorRed">
                {{ errors.first('middlename') }}
              </span>
              <div v-if="backendErrors.middlename" class="alert alert-danger">
                {{ backendErrors.middlename }}
              </div>
            </div>
          </div>

          <div class="form-group ">
            <label class="col-xs-5  col-md-4 col-lg-3 control-label ">
              Телефон <span class="required_star">*</span>
            </label>
            <div class="col-xs-7 col-md-8 col-lg-9 control-label ">
              <input
                ref="phoneInput"
                v-model="fieldsList.phone"
                v-mask="phoneInputMask"
                v-validate="{ required: true, phone: true }"
                data-cy="phone_orderInput"
                class="form-control"
                name="phone"
              />
              <span
                v-if="errors.has('phone')"
                class="colorRed"
                data-cy="orderPhoneErrorMessage"
              >
                {{ errors.first('phone') }}
              </span>
              <div v-if="backendErrors.phone" class="alert alert-danger">
                {{ backendErrors.phone }}
              </div>
            </div>
          </div>

          <div class="form-group ">
            <label class="col-xs-5  col-md-4 col-lg-3 control-label ">
              Email
            </label>
            <div class="col-xs-7  col-md-8 col-lg-9 control-label ">
              <input
                ref="emailInput"
                v-model="fieldsList.email"
                v-validate="{ email: true }"
                data-cy="emailInput"
                class="form-control"
                name="email"
              />
              <span v-if="errors.has('email')" class="colorRed">
                {{ errors.first('email') }}
              </span>

              <div v-if="backendErrors.email" class="alert alert-danger">
                {{ backendErrors.email }}
              </div>
            </div>
          </div>

          <AddressForm :address="shippingAddress" class="country">
            <template slot="title">
              <div />
            </template>

            <template slot="region">
              <div />
            </template>

            <template slot="city">
              <div />
            </template>

            <template slot="street">
              <div />
            </template>
          </AddressForm>
        </div>
      </div>
      <ShippingMethods />

      <PaymentMethods />

      <div class="wrapCheckoutFormComment">
        <div>
          <legend>Комментарий к заказу</legend>
          <div class="checkoutCommentTextarea">
            <textarea
              v-model="comment"
              class="checkoutTextarea form-control"
              rows="3"
              name="comment"
              placeholder="Текст вашего сообщения"
            ></textarea>
          </div>

          <div class="blank"></div>

          <div v-if="backendErrors.message" class="alert alert-danger">
            {{ backendErrors.message }}
          </div>

          <div class="checkoutFormCommentBottom">
            <div class="checkoutFormCommentBtn tc">
              <button
                data-cy="btnSendOrder"
                :disabled="loading"
                class="btn btn-success btn-lg checkoutCommentBtn"
              >
                Оформить заказ
              </button>
            </div>
          </div>

          <div class="blank"></div>
          <div class="blank"></div>
        </div>
      </div>
    </form>
  </div>
</template>

<script>
import cloneDeep from 'lodash/cloneDeep';
import { mapState, mapMutations, mapActions, mapGetters } from 'vuex';
import ShippingMethods from './components/shippingMethods/index.vue';
import PaymentMethods from './components/paymentMethods/index.vue';
import AddressForm from '@/components/AddressForm/index.vue';
import eventsBus from '@/eventsBus.js';
import HTTP from '../../../../plugins/http.js';
import phoneValidateFormWithAddress from '@/mixins/phoneValidateFormWithAddress.js';

export default {
  mixins: [phoneValidateFormWithAddress],
  created() {
    this.fetchCountries();

    this.fetchShippingMethods();

    this.fieldsList = {
      firstname: this.user.firstname,
      middlename: this.user.middlename,
      lastname: this.user.lastname,
      phone: this.user.phone,
      email: this.user.email,
    };
  },
  computed: {
    ...mapState('user', ['user']),
    ...mapState('cart', ['items']),
    ...mapState('orderForm', ['shipping_id', 'payment_id']),
    ...mapGetters('user', ['shippingAddress']),
    ...mapGetters('orderForm', ['shippingMethod']),
    phoneInputMask() {
      return this.getMask(this.shippingAddress.data.country);
    },
  },
  data: function() {
    return {
      fieldsList: {},
      backendErrors: {},
      comment: '',
      loading: false,
      varchar_id: '',
      paymentForm: '',
    };
  },
  components: { AddressForm, ShippingMethods, PaymentMethods },
  methods: {
    ...mapActions('countries', ['fetchCountries']),
    ...mapActions('orderForm', ['fetchShippingMethods']),
    ...mapActions('cart', ['getCartData']),
    ...mapMutations('user', ['updateAddress']),

    scrollToError() {
      let firstField = Object.keys(this.errors.collect())[0];
      if (!firstField)
        firstField = Object.keys(this.backendErrors).filter(
          name => name != 'message',
        )[0];

      if (firstField) this.$refs[`${firstField}Input`].scrollIntoView();
    },
    validateForm() {
      window.ga('send', 'event', 'checkout', 'clickToButtonOrderSend');
      this.$validator.validateAll().then(result => {
        if (result) this.sendOrder();
        else this.scrollToError();
      });
    },
    sendOrder() {
      if (this.shippingMethod.name.toLowerCase().indexOf('самовывоз') > -1) {
        /* 
          если самовывоз, то адрес сохранять не нужно, поэтому сохраняю пустой адрес (на случай, если у пользователя уже был какой-то адрес.)
        */
        const address = {
          ...cloneDeep(this.shippingAddress),
        };
        address.data.country = 'ukr';
        address.data.region = '';
        address.data.city = '';
        address.data.street = '';
        this.updateAddress(address);
      }

      eventsBus.$emit('beforeOrderCreated');
      this.$nextTick(() => {
        this.loading = true;
        const postData = {
          shipping_id: this.shipping_id,
          payment_id: this.payment_id,
          customer: {
            ...this.fieldsList,
            'address.shipping': this.shippingAddress.data,
          },
          comment: this.comment,
        };
        postData[`customer_${this.shipping_id}`] = postData.customer;

        postData[`shipping_${this.shipping_id}`] = this.shippingAddress.data;

        HTTP.post('/json/checkout/sendOrder/', postData).then(response => {
          this.loading = false;
          if (response.data.status === 'ok') {
            eventsBus.$emit('orderCreated', response.data.data);
            this.varchar_id = response.data.data.order.varchar_id;
            this.paymentForm = response.data.data.payment_form;
            this.getCartData();
            setTimeout(() => {
              this.$refs.orderSendedSuccess.scrollIntoView();
            }, 200);
            window.ga('send', 'event', 'checkout', 'orderSendedSuccess');
          } else {
            this.backendErrors = response.data.errors;
            this.scrollToError();
          }
        });
      }, 100);
    },
  },
};
</script>

<style>
@media screen and (min-width: 992px) {
  .country label + div {
    width: 66.666%;
  }
  .country label {
    width: 33.33333333%;
  }
}
@media screen and (min-width: 1200px) {
  .country label + div {
    width: 75%;
  }
  .country label {
    width: 25%;
  }
}
@media screen and (min-width: 500px) and (max-width: 767px) {
  .country label + div {
    width: 58.333%;
  }
  .country label {
    width: 41.666%;
  }
}
@media screen and (max-width: 499px) {
  form {
    width: 100% !important;
  }
}
</style>
