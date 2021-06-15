<template>
  <!-- 
  NOTE: TODO: изменения здесь необходимо дублировать на страницах:
  * редактирование информации, в личном кабинете (@/pages/myAccount)
  * страница оформления заказа (@/pages/cart)
  * страница сотрудничество (@/pages/partnership)
 -->
  <form
    class="form-horizontal signupForm"
    data-cy="signupForm"
    @submit.prevent="validateForm"
  >
    <div class="wa-value">
      <p>
        Зарегистрируйтесь и станьте постоянным пользователем нашего сайта. Для
        зарегистрированных пользователей действует накопительная скидка до 3%.
      </p>
      <p class="see-more" @click="setVisibilityDiscountInfo()">
        подробнее<i
          :class="{ active: showMoreDiscountInfo }"
          class="icon-013-down"
        ></i>
      </p>

      <div class="see-more-content" :class="{ active: showMoreDiscountInfo }">
        <p>
          Накопительная скидка зависит от суммы всех заказов сделанных начиная с
          дня регистрации.
        </p>
        <p>При сумме заказов:</p>
        <ul>
          <li>более 10000 грн. - скидка составит 1%;</li>
          <li>более 15000 грн. - скидка составит 2%;</li>
          <li>
            более 20000 грн. - скидка составит 3%
            <span class="redactor-invisible-space"></span>
          </li>
        </ul>
        <p>
          Подписывайтесь на новости и получайте информацию о свежих поступлениях
          и акциях, а также скидочные купоны.
        </p>
      </div>
    </div>
    <div class="wa-value">
      <input
        ref="firstname_input"
        v-model="contactFields.firstname"
        v-validate="{ required: true }"
        autocomplete="firstname"
        name="firstname"
        class="form-control"
        placeholder="Имя"
      />
      <span v-if="errors.has('firstname')" class="colorRed">
        {{ errors.first('firstname') }}
      </span>
      <span v-else-if="hasBackendError('firstname')" class="colorRed">
        {{ showBackendError('firstname') }}
      </span>
    </div>
    <div class="wa-value">
      <input
        ref="phone_input"
        v-model="contactFields.phone"
        v-mask="phoneInputMask"
        v-validate="{ phone: true }"
        name="phone"
        class="form-control"
        autocomplete="phone"
        placeholder="Телефон"
      />
      <span v-if="errors.has('phone')" class="colorRed">
        {{ errors.first('phone') }}
      </span>
      <span v-else-if="hasBackendError('phone')" class="colorRed">
        {{ showBackendError('phone') }}
      </span>
    </div>

    <div class="wa-value">
      <input
        ref="email_input"
        v-model="contactFields.email"
        v-validate="{ email: true }"
        name="email"
        class="form-control"
        placeholder="Email адрес"
        autocomplete="email"
      />
      <span v-if="errors.has('email')" class="colorRed">
        {{ errors.first('email') }}
      </span>
      <span v-else-if="hasBackendError('email')" class="colorRed">
        {{ showBackendError('email') }}
      </span>
    </div>

    <div class="wa-value">
      <span v-if="isEmailAndPhoneAreEmpty" class="colorRed">
        обязательно укажите телефон или email-адрес.
      </span>
    </div>

    <div class="wa-value">
      <input
        ref="password_input"
        v-model="contactFields.password"
        v-validate="{ required: true, password: true, alpha_dash: true }"
        :type="passwordInputType"
        autocomplete="current-password"
        name="password"
        class="form-control"
        placeholder="Пароль"
      />
      <i
        v-if="!showPassword"
        class="icon-060-pwd-invisible"
        @click="showPassword = !showPassword"
      ></i>
      <i
        v-else
        class="icon-059-pwd-visible"
        @click="showPassword = !showPassword"
      ></i>
      <span v-if="errors.has('password')" class="colorRed">
        {{ errors.first('password') }}
      </span>
      <span v-else-if="hasBackendError('password')" class="colorRed">
        {{ showBackendError('password') }}
      </span>
    </div>
    <div class="wa-captcha wa-value">
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
          v-validate="{ required: true }"
          type="text"
          name="captcha"
          class="wa-captcha-input form-control"
          autocomplete="off"
        />
      </div>
      <span v-if="errors.has('captcha')" class="colorRed">
        {{ errors.first('captcha') }}
      </span>
      <p>
        <a href="#" class="wa-captcha-refresh" @click.prevent="captchaRefresh">
          Обновить капчу (CAPTCHA)
        </a>
      </p>
      <span v-if="hasBackendError('captcha')" class="colorRed">
        {{ showBackendError('captcha') }}
      </span>
    </div>

    <div class="wa-value">
      <button
        type="submit"
        :disabled="loading"
        class="btn-success submit-signup btn btn-block"
      >
        Регистрация
        <img
          v-if="loading"
          src="/wa-apps/shop/themes/flip/img/loading16.gif"
          class="img-responsive image-loader"
        />
      </button>
      <a class="loginBtn" href="#" @click.prevent="show('modal-signin')">
        Уже есть аккаунт? Авторизироваться
      </a>
    </div>
    <modal
      :name="errorModalName"
      class="signup-backendError"
      :resizable="true"
      adaptive
      :min-width="300"
      :max-width="450"
      width="90%"
      height="auto"
      scrollable
    >
      <i class="fa fa-times" @click="hide(errorModalName)"></i>
      <ul>
        <h4 class="row">
          При заполнении формы были допущены следующие ошибки:
        </h4>
        <li v-for="(error, index) in backendErrors" :key="index">
          <span v-for="(errorText, key) in error" :key="key">{{
            errorText
          }}</span>
        </li>
      </ul>
    </modal>
  </form>
</template>
<script>
import fields from '@/helpers/fields.js';
import { mapActions, mapState, mapGetters } from 'vuex';
import HTTP from '@/plugins/http.js';
import captchaMixin from '@/mixins/captchaMixin.js';
import modalMixin from '@/mixins/modalMixin.js';
import handleBackendErrors from '@/mixins/handleBackendErrors.js';
import phoneValidateFormWithAddress from '@/mixins/phoneValidateFormWithAddress.js';

export default {
  name: 'SignUpForm',
  computed: {
    ...mapState('user', ['user']),
    ...mapGetters('user', ['address']),
    passwordInputType() {
      return this.showPassword ? '' : 'password';
    },
    phoneInputMask() {
      return this.getMask(this.address.data.country);
    },
    errorModalName() {
      // Чтобы не было "двойного" открытия формы на странице с формой регистрации
      // добавляем префикс,если форма регистрации в модальном окне( в ком-те UserButtons):
      let name = 'signup-backendError';
      if (this.$parent.$options.name == 'VueJsModal')
        name = 'modal-signup-backendError';
      return name;
    },

    isEmailAndPhoneAreEmpty() {
      /* флажек о том, что и телефон и емайл пуст,  и нужно заполнить что-то одно из них */
      return (
        this.contactFields.phone.trim().length === 0 &&
        this.contactFields.email.trim().length === 0
      );
    },
  },
  created() {
    this.fetchCountries();
  },
  mixins: [
    captchaMixin,
    handleBackendErrors,
    modalMixin,
    phoneValidateFormWithAddress,
  ],
  data() {
    /*eslint camelcase: "off"*/
    return {
      contactFields: Object.assign(
        { password: '', password_confirm: '' },
        fields.signUp,
      ),
      isShowAgrement: false,
      loading: false,
      showMoreDiscountInfo: false,
      showPassword: false,
    };
  },

  methods: {
    ...mapActions('countries', ['fetchCountries']),
    validateForm() {
      this.$validator.validateAll().then(result => {
        if (result && !this.isEmailAndPhoneAreEmpty) this.sendData();
        else this.scrollToError();
      });
    },
    setVisibilityDiscountInfo() {
      this.showMoreDiscountInfo = !this.showMoreDiscountInfo;
    },
    sendData() {
      this.loading = true;
      this.subscribe = (this.subscribe && 1) || 0;
      // Так как бек ждет от нас и  поле подтверждения пароля:
      this.contactFields.password_confirm = this.contactFields.password;
      const postData = {
        ...this.contactFields,
        address: this.address,
      };
      HTTP.post('/signup/', { data: postData, captcha: this.captcha })
        .then(({ data }) => {
          // NOTE: если пустая строка, значит регистрация успешна
          if (typeof data === 'object') {
            window.ga('send', 'event', 'debug', 'SignupError', data);
            this.handleBackendError(data); // если это обьект, то значит обьект с ошибками с бека
            this.show(this.errorModalName, false);
          } else {
            /*
              после регистрации сразу авторизирую пользователя
            */
            postData.login = postData.email;
            HTTP.post('/login/', postData).then(response => {
              if (
                response.data.includes('<login-form></login-form>') === true
              ) {
                // если авторизация вернула ошибку, то посылаю сообщение в GA
                window.ga(
                  'send',
                  'event',
                  'debug',
                  'AuthErrorAfterSignup',
                  response.data,
                );
                alert(
                  'Упс, произошла ошибка, мы уже знаем о ней. Перезагрузите пожалуйста страницу и попробуйте ещё раз.',
                );
              } else window.location.reload();
            });
          }

          // console.log(data); // TODO: send to GA event about error
        })
        // .catch(e => { т.к. бек отправляет респонс с ошибками заполнения формы со статусом 200, то нечего ловить.
        // // TODO: send to GA event about error
        // debugger;
        //   this.handleBackendError(e);
        //   this.show(this.errorModalName, false);
        // })
        .finally(() => {
          this.loading = false;
        });
    },
  },
};
</script>

<style lang="scss">
.signup-backendError .v--modal-box {
  position: relative;
  padding: 30px;
}
@media screen and (max-width: 767px) {
  .addresses-fields .control-label {
    text-align: left;
  }
}
@import '@/mainStylesVariables.scss';

form.signupForm {
  padding: 30px;
  max-width: 450px;
  margin: 0 auto;
  position: relative;
  .wa-value {
    margin-bottom: 15px;
    position: relative;
    .icon-060-pwd-invisible {
      color: #ccc;
    }
    .icon-060-pwd-invisible,
    .icon-059-pwd-visible {
      position: absolute;
      right: 15px;
      top: 14px;
      font-size: 20px;
      cursor: pointer;
    }
  }
  > .wa-value:first-child {
    display: none;
  }
  .loginBtn {
    display: block;
    text-align: center;
  }
  .loginBtn,
  .see-more {
    @include link_color_animate($small_link_color, $main_brand_color);
  }
  .see-more {
    cursor: pointer;
    text-align: right;
    margin: -10px 0 0 !important;
    i.active {
      transform: rotate(-180deg) translateY(2px);
    }
    i {
      transition: 0.3s;
      vertical-align: middle;
      &::before {
        font-size: 16px;
        font-weight: 600 !important;
      }
    }
  }
  .see-more-content.active {
    max-height: 500px;
    opacity: 1;
    transition: 0.5s;
  }
  .see-more-content {
    max-height: 0;
    opacity: 0;
    transition: 0.5s;
    overflow: hidden;
  }
  /* Стили для модального окна reviews-backendError */
  .v--modal-box {
    position: relative;
    padding: 30px;
    form > .wa-value:first-child {
      display: block;
    }
    .fa-times:hover,
    .fa-times:active {
      color: red;
    }
    .fa-times {
      position: absolute;
      right: 13px;
      top: 10px;
    }
    h4 {
      color: #f88c58;
    }
    p {
      margin-bottom: 10px;
    }
    ul {
      list-style: none;
      li:before {
        content: '- ';
      }
    }
  }
  input {
    outline: none;
    border: 1px solid #d9d9d9;
    border-radius: 3px;
    color: #000;
    font-weight: 400;
    padding: 14px 16px;
    height: 46px;
    box-shadow: none;
    width: 100%;
    margin-bottom: 0;
  }
  /* the end of modal reviews-backendError */
  .login,
  .image-loader {
    display: inline-block;
  }
  .colorRed {
    color: red;
  }
  .wa-captcha {
    margin-top: 30px;
  }
  .wa-captcha strong {
    margin: 0 12px;
  }
  .wa-captcha > div {
    display: flex;
    align-items: center;
    margin-bottom: 10px;
  }
  .wa-captcha-input,
  .wa-captcha-img {
    height: 46px;
    display: inline-block;
    max-width: 120px;
    margin-bottom: 0;
  }
  .submit-signup {
    margin: 10px 0;
    display: flex;
    align-items: center;
    justify-content: center;
    position: relative;
    input {
      height: 100%;
      width: 100%;
      background: transparent;
      border: none;
      color: #fff;
      padding: 0;
      font-weight: inherit;
    }
    img {
      top: 10px;
      right: 20%;
      position: absolute;
    }
  }
  .checkbox {
    text-align: left;
  }
  @media screen and (max-width: 767px) {
    padding: 30px 15px;
  }
}
</style>
