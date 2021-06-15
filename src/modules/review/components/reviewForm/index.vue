<template>
  <div v-if="formIsShown && propsParentId == parentId" class="review-form">
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
      <div v-if="!propsParentId" class="form-group row">
        <label for="dignity" class="col-xs-4 col-lg-3 control-label">
          Достоинства
        </label>
        <div class="col-xs-8 col-lg-9">
          <input
            id="dignity"
            v-model="dignity"
            type="text"
            class="form-control"
          />
        </div>
      </div>
      <div v-if="!propsParentId" class="form-group row">
        <label for="shortcomings" class="col-xs-4  col-lg-3 control-label">
          Недостатки
        </label>
        <div class="col-xs-8 col-lg-9">
          <input
            id="shortcomings"
            v-model="shortcomings"
            type="text"
            class="form-control"
          />
        </div>
      </div>
      <div class="form-group row">
        <label for="reviewMessage" class="col-xs-4 col-lg-3 control-label">
          Сообщение
        </label>
        <div class="col-xs-8 col-lg-9">
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
        <div class="col-xs-8 col-lg-9">
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
      <div v-else class="form-group row">
        <div class="col-xs-offset-4  col-lg-offset-3 col-xs-8">
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
      <div class="form-group row">
        <div
          class="col-xs-offset-4  col-lg-offset-3 col-xs-8 col-lg-9 button-wrapper"
        >
          <button
            v-if="requestResult === 'started'"
            type="submit"
            class="btn btn-primary"
            data-cy="sendReviewButton"
          >
            отправить
          </button>
          <div v-if="requestResult === 'loading'" class="image-loader">
            <img
              src="/wa-apps/shop/themes/flip/img/loading16.gif"
              class="img-responsive"
            />
          </div>
          <span class="cursive hidden-xs hidden-sm">Ctrl+Enter</span>
        </div>
      </div>
    </form>
  </div>
</template>

<script>
import { mapState, mapMutations, mapActions } from 'vuex';
import rateWidget from '../rateWidget/index.vue';

export default {
  props: {
    productId: {
      type: Number,
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
      dignity: '',
      shortcomings: '',
      userName: '',
      requestResult: 'started',
    };
  },
  components: { rateWidget },
  computed: {
    ...mapState('review', ['formIsShown', 'parentId']),
    ...mapState('user', { registeredUser: 'user' }),
  },
  methods: {
    ...mapMutations('review', ['closeForm']),
    ...mapActions('review', ['addReview']),
    send() {
      this.$validator.validate().then(isValid => {
        if (isValid) {
          this.requestResult = 'loading';
          this.addReview({
            text: this.text,
            dignity: this.dignity,
            shortcomings: this.shortcomings,
            name: this.registeredUser.name || this.userName,
            product_id: this.productId,
          }).then(() => {
            this.requestResult = 'started';
          });
        }
      });
    },
  },
};
</script>
<style lang="scss">
.review-form {
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
  @media (max-width: 400px) {
    .form-group.row > div,
    .form-group.row .button-wrapper,
    .form-group.row .control-label {
      width: 100% !important;
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
  @media (min-width: 768px) {
    .control-label {
      padding-top: 7px;
      margin-bottom: 0;
    }
  }
}
</style>
