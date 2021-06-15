<template>
  <!-- NOTE: абсолютно такая же форма должна быть при регистрации пользователя, поэтому изменения здесь - нужно дублировать там -->
  <div>
    <form
      class="form-horizontal"
      data-cy="signupForm"
      @submit.prevent="validateForm"
    >
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
            @change="updateUserWrapper('firstname')"
          />
          <div v-if="errors.has('firstname')" class="alert alert-danger">
            {{ errors.first('firstname') }}
          </div>
          <div
            v-else-if="showBackendError('firstname')"
            class="alert alert-danger"
          >
            {{ showBackendError('firstname') }}
          </div>
        </div>
      </div>

      <div class="form-group">
        <label class="control-label col-xs-12 col-sm-5  col-md-3 col-lg-4">
          Отчество
        </label>
        <div class="col-xs-12 col-sm-7 col-md-7">
          <input
            ref="middlename_input"
            v-model="contactFields.middlename"
            name="middlename"
            class="form-control"
            @change="updateUserWrapper('middlename')"
          />
          <div v-if="errors.has('middlename')" class="alert alert-danger">
            {{ errors.first('middlename') }}
          </div>
          <div v-if="showBackendError('middlename')" class="alert alert-danger">
            {{ showBackendError('middlename') }}
          </div>
        </div>
      </div>

      <div class="form-group">
        <label class="control-label col-xs-12 col-sm-5  col-md-3 col-lg-4">
          Фамилия
        </label>
        <div class="col-xs-12 col-sm-7 col-md-7">
          <input
            ref="lastname_input"
            v-model="contactFields.lastname"
            name="lastname"
            class="form-control"
            placeholder="Введите фамилию"
            @change="updateUserWrapper('lastname')"
          />
          <div v-if="errors.has('lastname')" class="alert alert-danger">
            {{ errors.first('lastname') }}
          </div>
          <div v-if="showBackendError('lastname')" class="alert alert-danger">
            {{ showBackendError('lastname') }}
          </div>
        </div>
      </div>

      <div class="form-group">
        <label class="control-label col-xs-12 col-sm-5  col-md-3 col-lg-4">
          Email
        </label>
        <div class="col-xs-12 col-sm-7 col-md-7">
          <input
            ref="email_input"
            v-model="contactFields.email"
            v-validate="{ email: true }"
            name="email"
            class="form-control"
            placeholder="Введите e-mail"
            @change="updateUserWrapper('email')"
          />
          <div v-if="errors.has('email')" class="alert alert-danger">
            {{ errors.first('email') }}
          </div>
          <div v-else-if="showBackendError('email')" class="alert alert-danger">
            {{ showBackendError('email') }}
          </div>
        </div>
      </div>

      <div class="form-group">
        <label class="control-label col-xs-12 col-sm-5  col-md-3 col-lg-4">
          Телефон
        </label>
        <div class="col-xs-12 col-sm-7 col-md-7">
          <input
            ref="phone_input"
            v-model="contactFields.phone"
            v-validate="{ phone: true }"
            name="phone"
            class="form-control"
            @change="updateUserWrapper('phone')"
          />
          <div v-if="errors.has('phone')" class="alert alert-danger">
            {{ errors.first('phone') }}
          </div>
          <div v-else-if="showBackendError('phone')" class="alert alert-danger">
            {{ showBackendError('phone') }}
          </div>
        </div>
      </div>

      <addresses> </addresses>

      <div class="tc">
        <input
          :disabled="loading"
          type="submit"
          class="btn btn-success btn-lg"
          value="Сохранить"
        />

        <img v-if="loading" src="/wa-apps/shop/themes/flip/img/loading16.gif" />
      </div>
    </form>
  </div>
</template>
<script>
import { mapState, mapActions, mapMutations } from 'vuex';
import fields from '@/helpers/fields.js';
import addresses from './addresses.vue';
export default {
  created() {
    for (const name in this.contactFields)
      this.contactFields[name] = this.user[name] || this.contactFields[name];
  },
  components: { addresses },
  computed: {
    ...mapState('user', ['user']),
  },
  data() {
    return {
      backendErrors: {},
      contactFields: Object.assign({}, fields.signUp),
      loading: false,
    };
  },
  methods: {
    scrollToFirstError() {
      let firstField = Object.keys(this.errors.collect())[0];
      if (!firstField) firstField = Object.keys(this.backendErrors)[0];

      this.$refs[`${firstField}_input`].scrollIntoView();
    },
    showBackendError(name) {
      return this.backendErrors[name];
    },
    validateForm() {
      this.$validator.validateAll().then(result => {
        if (result) this.saveWrapper();
        else this.scrollToFirstError();
      });
    },
    updateUserWrapper(name) {
      this.update({ name, value: this.contactFields[name] });
    },
    saveWrapper() {
      this.loading = true;
      this.save().then(response => {
        if (response.data) this.backendErrors = response.data;
        else window.location.reload();

        this.loading = false;
      });
    },
    ...mapActions('user', ['save']),
    ...mapMutations('user', ['update']),
  },
};
</script>
<style>
[data-cy='signupForm'] .alert-danger {
  margin-top: 10px;
}
</style>
