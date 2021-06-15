<template>
  <div class="arrived-form-wrapper">
    <div class="h2">Сообщить о поступлении товара</div>
    <modal-close-button modal-name="container"></modal-close-button>
    <form
      class="form-horizontal"
      data-cy="productArrivedForm"
      @submit.prevent="validateForm"
    >
      <div :data-cy="dataCyValue">
        <template
          v-if="requestResult === 'notStarted' || requestResult === 'loading'"
        >
          <div v-if="isShowField('email')" class="wa-value">
            <input
              id="product_arrived_email_input"
              v-model="formData.email"
              v-validate="getFieldValidationRules('email')"
              name="email"
              placeholder="Ваш E-mail"
            />
            <span
              v-show="errors.has('email')"
              class="help colorRed"
              data-cy="isInvalidEmailError"
            >
              {{ errors.first('email') }}
            </span>
          </div>

          <div v-if="isShowField('sms')" class="wa-value">
            <input
              id="sms_input"
              v-model="formData.phone"
              v-mask="phoneInputMask"
              v-validate="getFieldValidationRules('sms')"
              autocomplete="off"
              data-cy="phone_productArrivedInput"
              name="regex"
              placeholder="Телефон (для SMS-оповещения)"
            />
            <span
              v-show="errors.has('regex')"
              class="colorRed"
              data-cy="isInvalidNumberError"
            >
              {{ errors.first('regex') }}
            </span>
          </div>

          <div
            v-show="alertMessageIsVisible && isAllFieldsAreEmpty"
            data-cy="one-or-other-alert"
          >
            <div class="alert alert-danger">
              Заполните хотя бы одно из контактных полей
            </div>
          </div>

          <div v-if="settings.expiration" class="wa-value ">
            <label class="control-label">
              Актуальность
            </label>
            <input
              :value="`${expiration} дней`"
              readonly
              class="dropdown__input-holder"
              @mouseenter.stop="isHoveredDropdownList = true"
              @click.stop="isHoveredDropdownList = !isHoveredDropdownList"
            />
            <span
              class="dropdown-arrow icon icon-013-down "
              :class="{ opened: isHoveredDropdownList }"
              @click.stop="isHoveredDropdownList = !isHoveredDropdownList"
            ></span>
            <div
              class="dropdown-container"
              :class="{ opened: isHoveredDropdownList }"
            >
              <div
                v-for="item in expirationTerms"
                :key="item"
                :value="item"
                class="list-item"
                @mouseenter.stop="isHoveredDropdownList = true"
                @mouseleave="isHoveredDropdownList = false"
                @click.stop="
                  expiration = item;
                  hideDropdownWithSelection();
                "
              >
                {{ `${item} дней` }}
              </div>
            </div>
          </div>
          <div class="wa-value">
            <img
              v-if="requestResult === 'loading'"
              src="/wa-apps/shop/themes/flip/img/loading16.gif"
              class="img-responsive"
            />
            <button v-else class="btn btn-success btn-block" type="submit">
              Уведомить меня
            </button>
          </div>
        </template>
        <div
          v-if="requestResult === 'success'"
          class="alert alert-success"
          v-html="settings.popup_success"
        />
        <template v-if="requestResult === 'error'" class="alert alert-danger">
          <h4>Произошла ошибка!</h4>
          <p>Перезагрузите страницу и повторите запрос</p>
        </template>
      </div>
    </form>
  </div>
</template>

<script>
import phoneValidateMask from '@/mixins/phoneValidateMask.js';
import modalCloseButton from '@/components/modalCloseButton/index.vue';
import { mapState, mapMutations, mapActions } from 'vuex';
export default {
  mixins: [phoneValidateMask],
  components: { modalCloseButton },
  data() {
    return { isHoveredDropdownList: false };
  },
  computed: {
    ...mapState('productArrived', [
      'settings',
      'requestResult',
      'validationRules',
      'formData',
      'alertMessageIsVisible',
    ]),

    getFieldValidationRules() {
      return fieldName => {
        const item = this.validationRules.find(el => el.name === fieldName);
        const { name, ...rules } = item;
        return rules;
      };
    },
    expiration: {
      get: function() {
        return this.formData.expiration;
      },
      set: function(value) {
        this.setExpiration(value);
      },
    },
    expirationTerms() {
      return this.settings.expiration.split(',');
    },
    isShowField() {
      return input => this.settings.send_type.includes(input);
    },
    isAllFieldsAreEmpty() {
      return (
        !this.formData.email &&
        !this.formData.phone &&
        this.settings.send_type.includes('or')
      );
    },
    dataCyValue() {
      if (this.requestResult === 'success') return 'modalWithSuccessResult';
      return 'modal';
    },
  },
  methods: {
    ...mapMutations('productArrived', ['showAlertMessage', 'setExpiration']),
    ...mapActions('productArrived', ['sendData']),
    hideDropdownWithSelection() {
      this.$el.querySelector('.dropdown-container').classList.add('hidden');
      this.isHoveredDropdownList = false;
      setTimeout(() => {
        this.$el
          .querySelector('.dropdown-container')
          .classList.remove('hidden');
      }, 250);
    },
    validateForm() {
      if (this.isAllFieldsAreEmpty) {
        this.showAlertMessage();
        return;
      }
      this.$validator.validateAll().then(result => {
        if (result) this.sendData();
      });
    },
  },
};
</script>
<style lang="scss">
@import '@/dropdownSelectList.scss';
.arrived-form-wrapper {
  max-width: 400px;
  margin: auto;
  .closedelete {
    right: 20px;
  }
  .h2 {
    font-size: 24px;
    padding: 30px;
    @media screen and (max-width: 767px) {
      padding: 20px 30px;
    }
  }
}
form[data-cy='productArrivedForm'] {
  .wa-value {
    margin-bottom: 15px;
    position: relative;
  }
  .alert-danger {
    margin: 0;
  }
  input {
    outline: none;
    border: 1px solid #d9d9d9;
    border-radius: 3px;
    color: #000;
    font-weight: 400;
    padding: 14px 16px;
    min-height: 46px;
    box-shadow: none;
    width: 100%;
    margin-bottom: 0;
  }
  button {
    margin-top: 30px;
    height: 46px;
  }
  label {
    font-weight: 500;
    padding: 0 !important;
    margin-bottom: 5px !important;
  }
}
</style>
