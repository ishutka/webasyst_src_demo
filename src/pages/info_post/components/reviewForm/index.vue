<template>
  <div
    v-if="formIsShown && propsParentId == parentId"
    class="info-page-review-form"
  >
    <form
      class="productReviewForm well"
      :data-cy="`reviewForm_${propsParentId}`"
      @submit.prevent="send"
      @keyup.ctrl.13="send"
    >
      <span class="fa-stack fa-lg tc closeForm" @click="closeForm()">
        <i calss="fa fa-circle fa-stack-2x"></i>
        <i class="fa fa-close fa-inverse"></i>
      </span>
      <rateWidget v-if="!propsParentId"></rateWidget>

      <div class="form-group row">
        <label for="reviewMessage" class="col-xs-4 col-lg-3 control-label">
          Сообщение
        </label>
        <div class="col-xs-8 col-lg-9 control-label">
          <textarea
            id="reviewMessage"
            v-model="text"
            v-validate="'required'"
            name="reviewMessage"
            rows="4"
            cols="50"
            class="form-control"
            :class="{ redBorder: errors.has('reviewMessage') }"
          />
          <div
            v-if="errors.has('reviewMessage')"
            data-cy="messageIsAbsentError"
            class="fieldError"
          >
            {{ errors.first('reviewMessage') }}
          </div>
        </div>
      </div>
      <div v-if="!registeredUser.name" class="form-group row">
        <label
          for="userNameProductReview"
          class="col-xs-4 col-lg-3 control-label"
        >
          Ваше имя
        </label>
        <div class="col-xs-8 col-lg-9 control-label">
          <input
            id="userNameProductReview"
            v-model="userName"
            v-validate="'required'"
            name="userName"
            class="form-control"
            :class="{ redBorder: errors.has('userName') }"
          />
          <div v-if="errors.has('userName')" class="fieldError">
            {{ errors.first('userName') }}
          </div>
        </div>
      </div>
      <div v-if="!registeredUser.id" class="form-group row">
        <label for="emailProductReview" class="col-xs-4 col-lg-3 control-label">
          Email
        </label>
        <div class="col-xs-8 col-lg-9 control-label">
          <input
            id="emailProductReview"
            v-model="email"
            v-validate="'required|email'"
            name="email"
            class="form-control"
            :class="{ redBorder: errors.has('email') }"
          />
          <div v-if="errors.has('email')" class="fieldError">
            {{ errors.first('email') }}
          </div>
        </div>
      </div>
      <div v-else class="form-group row">
        <div class="user-block">
          <div>
            <img
              v-if="registeredUser.photo"
              :src="registeredUser.photo"
              class="userpic"
            />
          </div>
          <strong>{{ registeredUser.name }}</strong>
          <a href="?logout"> Выйти </a>
        </div>
      </div>

      <div v-if="!registeredUser.id" class=" form-group row">
        <div class=" col-xs-4 col-lg-3 wa-captcha control-label">
          <img
            ref="captcha_img"
            class="wa-captcha-img "
            :src="imgSrc"
            alt="CAPTCHA"
          />
          <strong>→</strong>
        </div>
        <div class="col-xs-8 col-lg-9 control-label">
          <input
            ref="captcha_input"
            v-model="captcha"
            type="text"
            name="captcha"
            class="wa-captcha-input form-control "
            autocomplete="off"
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
          <span
            v-if="hasBackendError('captcha')"
            data-cy="captchaError"
            class="colorRed"
          >
            {{ showBackendError('captcha') }}
          </span>
        </div>
      </div>

      <div class="form-group row">
        <div
          class="col-xs-offset-4  col-lg-offset-3 col-xs-8 col-lg-9 button-wrapper"
        >
          <button
            v-if="!loading"
            type="submit"
            class="btn btn-primary"
            data-cy="sendReviewButton"
          >
            отправить
          </button>
          <div v-if="loading" class="image-loader">
            <img
              src="/wa-apps/shop/themes/flip/img/loading16.gif"
              class="img-responsive"
            />
          </div>
          <span class="cursive hidden-xs hidden-sm">Ctrl+Enter</span>
        </div>
      </div>
    </form>
    <modal
      data-cy="reviews-backendError"
      name="reviews-backendError"
      :resizable="true"
      adaptive
      :min-width="300"
      :max-width="650"
      width="90%"
      height="auto"
      scrollable
    >
      <i class="fa fa-times" @click="hide('reviews-backendError')"></i>
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
  </div>
</template>

<script>
import modalMixin from '@/mixins/modalMixin.js';
import captchaMixin from '@/mixins/captchaMixin.js';
import handleBackendErrors from '@/mixins/handleBackendErrors.js';

import { mapState, mapMutations, mapActions } from 'vuex';
import rateWidget from '../rateWidget/index.vue';

export default {
  mixins: [captchaMixin, handleBackendErrors, modalMixin],
  props: {
    postId: {
      type: Number,
      required: true,
    },
    commentLink: {
      type: String,
      required: true,
    },
    propsParentId: {
      type: Number,
      required: false,
      default: 0,
    },
  },
  data() {
    return {
      text: '',
      userName: '',
      email: '',
      loading: false,
      customCaptchaApp: 'blog',
    };
  },
  mounted() {
    if (this.registeredUser && this.registeredUser.id > 0) {
      this.userName = this.registeredUser.name;
      this.email = this.registeredUser.email;
    }
  },
  components: { rateWidget },
  computed: {
    ...mapState('postReviews', ['formIsShown', 'parentId']),
    ...mapState('user', { registeredUser: 'user' }),
  },
  methods: {
    ...mapMutations('postReviews', ['closeForm']),
    ...mapActions('postReviews', ['addReview']),
    send() {
      this.backendErrors = {};
      this.$validator.validate().then(isValid => {
        if (isValid) {
          this.loading = true;
          this.addReview({
            text: this.text,
            email: this.email,
            name: this.userName,
            postId: this.postId,
            commentLink: this.commentLink,
            captcha: this.captcha,
          })
            .then(data => {
              if (data) {
                // Перевожу полученный массив с ошибками(data.errors) в вид обекта
                // перед тем как передать его в handleBackendError():
                const errors = {};
                data.errors.forEach(error => {
                  const field = Object.keys(error)[0];
                  const text = error[field];
                  errors[field] = text;
                });
                this.handleBackendError(errors);
                // Открытие окна с ошибками:
                this.show('reviews-backendError');
              }
            })
            .then(() => {
              if (!Object.keys(this.backendErrors).length) this.closeForm();
            })
            .finally(() => {
              this.loading = false;
            });
        }
      });
    },
  },
};
</script>
<style lang="scss">
.info-page-review-form {
  .image-loader {
    display: inline-block;
    width: 22px;
    margin-right: 5px;
  }
  .button-wrapper {
    display: inline-flex;
    align-items: center;
  }
  button {
    margin-right: 5px;
  }
  form {
    position: relative;
    padding-right: 40px;
    margin-top: 10px;
  }
  .user-block {
    display: flex;
    align-items: center;
    flex-wrap: wrap;
    margin-left: 25%;
    padding: 0 15px;
    a,
    strong {
      margin: 5px 7px 0 0;
      display: inline-block;
    }
  }
  .wa-captcha-img {
    min-width: 80px;
    margin-bottom: 0;
    width: 100%;
    max-width: 130px;
  }
  .wa-captcha {
    display: flex;
    justify-content: flex-end;
    position: relative;
    strong {
      position: absolute;
      top: 15%;
      right: -7px;
      align-self: center;
    }
  }
  .wa-captcha-input {
    display: inline-block;
  }
  .userpic {
    width: 20px;
    height: 20px;
    float: left;
    margin-right: 5px;
  }
  .closeForm {
    right: 0;
    cursor: pointer;
    position: absolute;
    top: 0;
  }
  .fieldError {
    color: #fb515d;
    font-size: 12px;
  }
  .redBorder {
    border: solid #fb515d 1px;
  }
  .control-label {
    text-align: right;
  }
  .fa-inverse {
    color: #fb515d;
  }
  .cursive {
    font-family: cursive;
  }
  // Стили для модального окна reviews-backendError
  .v--modal-box {
    position: relative;
    padding: 30px;
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
    ul {
      list-style: none;
      li:before {
        content: '- ';
      }
    }
  }
  //--the end of modal reviews-backendError--//
  @media (min-width: 768px) {
    .control-label {
      padding-top: 7px;
      margin-bottom: 0;
    }
    .control-label.wa-captcha {
      padding-top: 4px;
    }
    .wa-captcha {
      strong {
        top: calc(7px + 10%);
      }
    }
  }

  @media (max-width: 1199px) {
    .user-block {
      margin-left: 33.33%;
    }
  }
  @media (max-width: 500px) {
    .wa-captcha {
      margin-bottom: 10px;
      justify-content: flex-start;
      img {
        min-width: 130px;
        margin-bottom: 0;
      }
      strong {
        position: static;
        margin-left: 7px;
      }
    }
    .user-block {
      margin-left: 0;
    }
    .form-group.row > div,
    .form-group.row .button-wrapper,
    .form-group.row .control-label {
      width: 100%;
      text-align: left;
      margin-left: 0;
    }
    .form-group.row .button-wrapper {
      text-align: right;
      margin-bottom: -15px;
    }
    form {
      padding-right: 20px;
    }
  }
}
</style>
