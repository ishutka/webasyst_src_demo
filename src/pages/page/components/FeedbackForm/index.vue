<template>
  <div v-if="successMessage" class="success_msg alert alert-success">
    {{ successMessage }}
  </div>
  <form
    v-else
    class="form-horizontal feedback-form"
    @submit.prevent="validateForm"
  >
    <h3 class="title">Отправить запрос</h3>
    <div class="form-group">
      <label class="col-xs-3 col-sm-3 col-md-3 col-lg-3 tr control-label">
        Имя, Фамилия
      </label>
      <div class="col-xs-6 col-sm-6 col-md-8 col-lg-9">
        <input
          v-model="fieldList.name"
          v-validate="{ required: true }"
          name="name"
          class="form-control"
          placeholder="Введите фамилию"
        />
        <span v-show="errors.has('name')" class="errorMessage">
          {{ errors.first('name') }}
        </span>
      </div>
    </div>

    <div class="form-group">
      <label class="col-xs-3 col-sm-3 col-md-3 col-lg-3 tr control-label">
        Телефон
      </label>
      <div class="col-xs-6 col-sm-6 col-md-8 col-lg-9">
        <input
          v-model="fieldList.phone"
          v-validate="{ required: true, phone: true }"
          name="phone"
          class="form-control"
        />
        <span v-show="errors.has('email')" class="errorMessage">
          {{ errors.first('email') }}
        </span>
      </div>
    </div>
    <div class="form-group">
      <label class="col-xs-3 col-sm-3 col-md-3 col-lg-3 tr control-label">
        Email
      </label>
      <div class="col-xs-6 col-sm-6 col-md-8 col-lg-9">
        <input
          v-model="fieldList.email"
          v-validate="{ required: true, email: true }"
          name="email"
          class="form-control"
          placeholder="Введите e-mail"
        />
        <span v-show="errors.has('email')" class="errorMessage">
          {{ errors.first('email') }}
        </span>
      </div>
    </div>
    <div class="form-group">
      <label class="col-xs-3 col-sm-3 col-md-3 col-lg-3 tr control-label">
        Текст запроса
      </label>
      <div class="col-xs-6 col-sm-6 col-md-8 col-lg-9">
        <textarea
          v-model="fieldList.message"
          v-validate="{ required: true }"
          name="message"
          class="form-control"
        ></textarea>
        <span v-show="errors.has('message')" class="errorMessage">
          {{ errors.first('message') }}
        </span>
      </div>
    </div>

    <div class="form-group">
      <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3"></div>
      <div class="col-xs-6 col-md-8 col-lg-9 wa-value">
        <div class="wa-captcha">
          <div class="row">
            <div class="col-xs-10 col-sm-10 col-md-5 col-lg-5">
              <img
                ref="captcha_img"
                class="wa-captcha-img"
                :src="imgSrc"
                alt="CAPTCHA"
              />
              <p>
                <a
                  href="#"
                  class="wa-captcha-refresh"
                  @click.prevent="captchaRefresh"
                >
                  Обновить капчу (CAPTCHA)
                </a>
              </p>
            </div>
            <div class="col-xs-10 col-sm-10 col-md-6 col-lg-5">
              <input
                ref="captcha_input"
                v-model="captcha"
                type="text"
                name="captcha"
                class="wa-captcha-input form-control"
                autocomplete="off"
              />
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="wa-field form-group">
      <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3"></div>
      <div class="col-xs-8 col-sm-8 col-md-5 col-lg-5 wa-value">
        <input :disabled="loading" type="submit" class="btn btn-success" />
        <img
          v-if="loading"
          src="/wa-apps/shop/themes/flip/img/loading16.gif"
          class="img-responsive"
        />
      </div>
    </div>
    <div v-if="error" class="error_msg alert alert-danger" v-html="error" />
  </form>
</template>

<script>
import HTTP from '../../../../plugins/http.js';
import captchaMixin from '@/mixins/captchaMixin.js';
import { mapState } from 'vuex';

export default {
  mixins: [captchaMixin],
  data() {
    return {
      fieldList: {},
      loading: false,
      error: '',
      successMessage: '',
    };
  },
  created() {
    this.fieldList = {
      name: this.user.firstname,
      email: this.user.email,
      phone: this.user.phone,
      message: '',
    };
  },
  computed: {
    ...mapState('user', ['user']),
  },
  methods: {
    validateForm() {
      this.$validator.validateAll().then(result => {
        if (result) this.sendData();
      });
    },
    async sendData() {
      try {
        this.loading = true;
        const { data } = await HTTP.post('/sendFeedback/', {
          captcha: this.captcha,
          ...this.fieldList,
        });
        if (data.data.error) this.error = data.data.error;
        else if (data.data.success) this.successMessage = data.data.success;
        this.loading = false;
      } catch (e) {
        this.loading = false;
        alert('Произошла ошибка... Перезагрузите страницу');
      }
    },
  },
};
</script>
<style lang="scss">
.feedback-form {
  .title {
    text-align: center;
    margin-bottom: 24px;
  }
  .wa-captcha-input {
    width: 100px !important;
    display: inline-block !important;
    width: 100%;
  }
  .wa-captcha-img {
    margin-bottom: 5px;
  }
  .errorMessage {
    color: #ff0004;
  }
}
</style>
