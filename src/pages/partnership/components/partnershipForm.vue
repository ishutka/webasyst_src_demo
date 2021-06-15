<template>
  <div class="form_outer">
    <div v-if="sended" class="alert alert-success">
      Спасибо, мы обязательно свяжемся с Вами!
    </div>
    <form
      v-if="!sended"
      class="form-horizontal"
      data-cy="`partnershipForm_${tab.name}`"
      @submit.prevent="validateForm"
    >
      <div class="form-group">
        <label class="control-label col-xs-12 col-sm-5  col-md-3 col-lg-4">
          Тип сотрудничества
        </label>
        <div class="col-xs-12 col-sm-7 col-md-7">
          <p v-if="tab.name === 'dealer'" class="form-control-static">
            Я хочу покупать товары по специальной цене.
          </p>
          <p v-if="tab.name === 'provider'" class="form-control-static">
            Я хочу выставить свой товар в вашем магазине.
          </p>
        </div>
      </div>

      <div class="form-group">
        <label class="control-label col-xs-12 col-sm-5  col-md-3 col-lg-4">
          Фамилия
        </label>
        <div class="col-xs-12 col-sm-7 col-md-7">
          <input
            v-model="contactFields.lastname"
            name="lastname"
            class="form-control"
            placeholder="Введите фамилию"
          />
          <span v-if="hasBackendError('lastname')" class="colorRed">
            {{ showBackendError('lastname') }}
          </span>
        </div>
      </div>
      <div class="form-group">
        <label class="control-label col-xs-12 col-sm-5  col-md-3 col-lg-4">
          Имя <em class="required_star">*</em>
        </label>
        <div class="col-xs-12 col-sm-7 col-md-7">
          <input
            ref="firstname_input"
            v-model="contactFields.firstname"
            v-validate="{ required: true }"
            name="firstname"
            class="form-control"
            placeholder="Введите имя"
          />
          <span v-if="errors.has('firstname')" class="colorRed">
            {{ errors.first('firstname') }}
          </span>
          <span v-else-if="hasBackendError('firstname')" class="colorRed">
            {{ showBackendError('firstname') }}
          </span>
        </div>
      </div>
      <div class="form-group">
        <label class="control-label col-xs-12 col-sm-5  col-md-3 col-lg-4">
          Телефон <em class="required_star">*</em>
        </label>
        <div class="col-xs-12 col-sm-7 col-md-7">
          <input
            ref="phone_input"
            v-model="contactFields.phone"
            v-validate="{ required: true, phone: true }"
            name="phone"
            class="form-control"
          />
          <span v-if="errors.has('phone')" class="colorRed">
            {{ errors.first('phone') }}
          </span>
          <span v-else-if="hasBackendError('phone')" class="colorRed">
            {{ showBackendError('phone') }}
          </span>
          <span v-else class="help-block">
            Укажите телефон для sms-уведомлений
          </span>
        </div>
      </div>
      <hr v-if="!user.id" />
      <div class="form-group">
        <label class="control-label col-xs-12 col-sm-5  col-md-3 col-lg-4">
          Email (Логин) <em class="required_star">*</em>
        </label>
        <div class="col-xs-12 col-sm-7 col-md-7">
          <input
            ref="email_input"
            v-model="contactFields.email"
            v-validate="{ required: true, email: true }"
            name="email"
            class="form-control"
            placeholder="Введите e-mail"
          />
          <span v-if="errors.has('email')" class="colorRed">
            {{ errors.first('email') }}
          </span>
          <span v-else-if="hasBackendError('email')" class="colorRed">
            {{ showBackendError('email') }}
          </span>
        </div>
      </div>
      <div v-if="!user.id" class="form-group">
        <label class="control-label col-xs-12 col-sm-5  col-md-3 col-lg-4">
          Пароль <em class="required_star">*</em>
        </label>
        <div class="col-xs-12 col-sm-7 col-md-7">
          <input
            ref="password_input"
            v-model="contactFields.password"
            v-validate="{ required: true, password: true, alpha_dash: true }"
            type="password"
            name="password"
            class="form-control"
          />
          <span v-if="errors.has('password')" class="colorRed">
            {{ errors.first('password') }}
          </span>
          <span v-else-if="hasBackendError('password')" class="colorRed">
            {{ showBackendError('password') }}
          </span>
        </div>
      </div>
      <div v-if="!user.id" class="form-group">
        <label class="control-label col-xs-12 col-sm-5  col-md-3 col-lg-4">
          Подтвердите пароль <em class="required_star">*</em>
        </label>
        <div class="col-xs-12 col-sm-7 col-md-7">
          <input
            ref="password_confirm_input"
            v-model="contactFields.password_confirm"
            v-validate="{
              required: true,
              password_confirm: contactFields.password,
            }"
            type="password"
            name="password_confirm"
            class="form-control"
          />
          <span v-if="errors.has('password_confirm')" class="colorRed">
            {{ errors.first('password_confirm') }}
          </span>
          <span
            v-else-if="hasBackendError('password_confirm')"
            class="colorRed"
          >
            {{ showBackendError('password_confirm') }}
          </span>
        </div>
      </div>
      <hr v-if="!user.id" />

      <AddressForm :address="address">
        <div slot="title" class=" form-group ">
          <div class="control-label col-xs-12 col-sm-5  col-md-3 col-lg-4" />
          <div class="col-xs-12 col-sm-12 col-md-7">
            <h4 class="tc">Адрес</h4>
          </div>
        </div>
      </AddressForm>

      <div v-if="!user.id" class=" form-group ">
        <div class="control-label col-xs-12 col-sm-5  col-md-3 col-lg-4"></div>

        <div class="wa-captcha col-xs-12 col-sm-7 col-md-7">
          <div>
            <img
              ref="captcha_img"
              class="wa-captcha-img "
              :src="imgSrc"
              alt="CAPTCHA"
            />
            <strong>→</strong>
            <input
              ref="captcha_input"
              v-model="captcha"
              type="text"
              name="captcha"
              class="wa-captcha-input form-control"
              autocomplete="off"
            />
          </div>
          <p>
            <a
              href="#"
              class="wa-captcha-refresh"
              @click.prevent="captchaRefresh"
            >
              Обновить капчу (CAPTCHA)
            </a>
          </p>
          <span v-if="hasBackendError('captcha')" class="colorRed">
            {{ showBackendError('captcha') }}
          </span>
        </div>
      </div>

      <div class="form-group">
        <div class="control-label col-xs-12 col-sm-5  col-md-3 col-lg-4"></div>

        <div class="control-label col-xs-8  col-md-5  ">
          <button
            :disabled="loading"
            type="submit"
            class="btn btn-success btn-lg"
          >
            Отправить форму
            <img
              v-if="loading"
              src="/wa-apps/shop/themes/flip/img/loading16.gif"
              class="img-responsive"
            />
          </button>
        </div>
      </div>
    </form>
  </div>
</template>
<script>
import { mapActions, mapState, mapGetters } from 'vuex';
import fields from '@/helpers/fields.js';
import captchaMixin from '@/mixins/captchaMixin.js';
import handleBackendErrors from '@/mixins/handleBackendErrors.js';
import HTTP from '@/plugins/http.js';
import AddressForm from '@/components/AddressForm/index.vue';

export default {
  props: {
    tab: {
      type: Object,
      required: true,
    },
  },

  components: { AddressForm },
  mixins: [captchaMixin, handleBackendErrors],
  data() {
    return {
      contactFields: {},
      isShowAgrement: false,
      loading: false,
      sended: false,
    };
  },
  computed: {
    ...mapState('user', ['user']),
    ...mapGetters('user', ['address']),
  },
  created() {
    for (const name in fields.signUp)
      this.contactFields[name] = this.user[name] || fields.signUp[name];
    this.fetchCountries();
  },
  methods: {
    ...mapActions('countries', ['fetchCountries']),
    validateForm() {
      this.$validator.validateAll().then(result => {
        if (result) this.sendData();
        else this.scrollToError();
      });
    },

    sendData() {
      const postData = {
        ...this.contactFields,
        address: [this.address.data],
      };
      const params = {
        ...postData,
        captcha: this.captcha,
        type: this.tab.name,
      };
      //   if (!this.user.id)
      //   params.data = postData;
      this.loading = true;
      HTTP.post('/partnership/', params)
        .then(({ data }) => {
          this.handleBackendError(data);
        })
        .catch(e => {
          alert('Что-то пошло не так... Перезагрузите страницу');
        })
        .finally(() => {
          this.loading = false;
          this.sended = true;
        });
    },
  },
};
</script>
