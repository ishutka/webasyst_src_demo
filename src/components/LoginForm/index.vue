<template>
  <form
    class="login-form"
    action="/login/"
    method="post"
    data-cy="loginForm"
    @submit.prevent="fetchLogin"
  >
    <div class="h3">Войти в аккаунт</div>
    <div class="wa-value">
      <input
        v-model="login"
        autocomplete="username"
        type="text"
        name="login"
        placeholder="Email или телефон"
      />
    </div>
    <div class="wa-value pass">
      <input
        v-model="password"
        autocomplete="current-password"
        type="password"
        name="password"
        placeholder="Пароль"
      />
      <a href="/forgotpassword/" class="forgot-password">Забыли?</a>
    </div>
    <div class="remember-me">
      <input v-model="remembeMe" type="checkbox" name="remembe" />
      <span>Запомнить меня</span>
    </div>

    <div v-if="error" class="alert alert-danger" v-html="error"></div>
    <div class="wa-value">
      <input type="hidden" name="wa_auth_login" value="1" />
      <button type="submit" class="btn btn-success btn-block">
        <span v-if="!loading"> Войти </span>
        <span v-if="loading"> Загрузка... </span>
      </button>
      <a class="reg" href="#" @click.prevent="show('modal-register')">
        Нет аккаунта? Зарегистрироваться
      </a>
    </div>
  </form>
</template>
<script>
import HTTP from '@/plugins/http.js';
import modalMixin from '@/mixins/modalMixin.js';

export default {
  data: () => {
    return {
      login: '',
      password: '',
      error: '',
      loading: false,
      remembeMe: false,
    };
  },
  mixins: [modalMixin],
  methods: {
    async fetchLogin() {
      this.loading = true;
      /* eslint-disable */  
      const postData = {
        login: this.login,
        password: this.password,
        wa_auth_login: 1,
        remembe: +this.remembeMe,
      };
      /* eslint-enable */

      const response = await HTTP.post('/login/', postData);
      this.loading = false;

      if (response.data.includes('<login-form></login-form>') === true) {
        const html = document.createElement('div');
        html.innerHTML = response.data;
        this.error = html.querySelector('#error').outerHTML;
      } else window.location.reload();
    },
  },
};
</script>
<style lang="scss">
@import '@/mainStylesVariables.scss';
form.login-form {
  padding: 30px;
  max-width: 430px;
  margin: 0 auto;
  .pass {
    position: relative;
  }
  .reg {
    text-align: center;
    display: block;
  }
  .forgot-password,
  .reg {
    @include link_color_animate($small_link_color, $main_brand_color);
  }
  .forgot-password {
    position: absolute;
    right: 0;
    top: 0;
    padding: 12px 30px;
  }
  .remember-me {
    display: flex;
    align-items: center;
    position: relative;
    span {
      position: absolute;
      left: 25px;
      top: 25%;
    }
    span:before {
      content: '';
      display: block;
      width: 18px;
      height: 18px;
      border-radius: 2px;
      border: 1px solid #333;
      position: absolute;
      top: 2px;
      left: -25px;
      color: #333;
    }
    input:checked + span:before {
      content: '\e039';
      font-family: 'flip-iconsfont' !important;
      font-size: 12px;
      font-weight: bolder;
      text-align: center;
    }
    input {
      margin: 0 7px 0 0;
      position: relative;
      -webkit-appearance: none;
      outline: none;
      border: none;
      width: 100%;
      opacity: 0;
      z-index: 1;
    }
  }
  input {
    border: 1px solid #d9d9d9;
    border-radius: 3px;
    color: #000;
    font-weight: 400;
    padding: 14px 16px;
    min-height: 46px;
    box-shadow: none;
    width: 100%;
    margin-bottom: 15px;
  }
  .btn-block {
    min-height: 46px;
    margin-bottom: 15px;
  }
  @media screen and (max-width: 767px) {
    padding: 30px 0px;
  }
}
</style>
