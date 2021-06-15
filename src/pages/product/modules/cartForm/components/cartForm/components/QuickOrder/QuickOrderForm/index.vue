<template>
  <div class="quickorder-wrap">
    <modal-close-button modal-name="container"></modal-close-button>
    <div class="h2">{{ product.info.name }}</div>
    <form
      class="quickorder-form"
      data-cy="quickOrderForm"
      @submit.prevent="submitForm"
    >
      <div
        v-if="!successHtml"
        data-cy="quickOrderModal"
        class="form-horizontal "
      >
        <div class="row">
          <div
            class="col-xs-12 col-sm-5 col-md-4 col-lg-3 control-label image-wrap"
          >
            <lazy-image
              class="img-responsive"
              :src="product.info.img"
              :alt="product.info.name"
            />
          </div>

          <div class="col-xs-12 col-sm-7 col-md-8 col-lg-9">
            <div class="form-group">
              <label
                class="col-xs-12 col-sm-4 col-md-3 control-label quickorder-quantity"
              >
                Количество:
              </label>
              <div class="col-xs-12 col-sm-8 col-lg-9 ">
                <div class="row price-wrapp">
                  <div
                    class="quickorder-quantity control-label col-xs-6 col-sm-4  col-md-3 col-lg-2"
                  >
                    <input
                      v-model="quantityWrapper"
                      min="1"
                      type="number"
                      class="form-control"
                      aria-label="количество"
                    />
                  </div>
                  <div
                    class="quickorder-quantity control-label col-xs-6 col-sm-8 "
                  >
                    <p
                      class="form-control-static price plugin_quickorder_product_price"
                    >
                      {{ preparePrice(productId, price) }}
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <hr />
        <div
          class="alert alert-danger alert-dismissible backend-error"
          :class="{ faded: !failedServerValid }"
        >
          <p v-for="error in errors.error" :key="error.field">
            {{ error.text }}
          </p>
          <button
            type="button"
            class="close"
            data-cy="quickOrderWarningClose"
            @click="failedServerValid = false"
          >
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div v-for="field in fieldsData" :key="field.name" class="form-group">
          <label class="col-xs-6 col-sm-4 col-lg-3 tr control-label">
            {{ field.title }}

            <template v-if="field.required">
              <span class="required_star">*</span>
            </template>
          </label>
          <div class="col-xs-6 col-sm-8 col-lg-9 control-label">
            <input
              v-if="field.name == 'phone'"
              v-model="field.value"
              v-mask="phoneInputMask"
              v-validate="getValidationRule(field)"
              class="form-control"
              :name="field.name"
              :data-cy="`${field.name}_quickOrderInput`"
            />
            <input
              v-else
              v-model="field.value"
              v-validate="getValidationRule(field)"
              class="form-control"
              :name="field.name"
              :data-cy="`${field.name}_quickOrderInput`"
            />
            <span
              v-show="errors.has(field.name)"
              class="colorRed"
              :data-cy="`${field.name}_errorMessage`"
            >
              {{ errors.first(field.name) }}
            </span>
          </div>
        </div>
        <div v-if="enableUserComment" class="form-group">
          <label class="col-xs-6 col-sm-4 col-lg-3 tr control-label">
            Коментарий к заказу
          </label>
          <div class="col-xs-6 col-sm-8 col-lg-9 control-label">
            <textarea
              v-model="comment"
              rows="4"
              cols="50"
              class="form-control"
            />
          </div>
        </div>
        <div class="form-group  summary">
          <label class="col-xs-6 col-sm-4 col-lg-3 tr control-label">
            <p>Сумма заказа</p>
          </label>
          <div class="col-xs-6 col-sm-8 col-lg-9 control-label">
            <span class="price price-wrapp ">
              {{ preparePrice(productId, cost) }}
            </span>
          </div>
        </div>
        <div class="form-group">
          <label class="col-xs-6 col-sm-4 col-lg-3 tr control-label"> </label>
          <div class="col-xs-6 col-sm-8 col-lg-9 submit-wrapper">
            <input
              type="submit"
              value="Отправить заказ"
              class="quickorder-button btn btn-success btn-lg"
              data-cy="quickOrderSendButton"
              :disabled="loading"
            />
            <div v-if="loading" class="loader-wrapper">
              <img
                src="/wa-apps/shop/themes/flip/img/loading16.gif"
                class="img-responsive"
              />
            </div>
          </div>
        </div>
      </div>
      <template v-else>
        <div v-html="successHtml"></div>
      </template>
    </form>
  </div>
</template>
<script>
import modalCloseButton from '@/components/modalCloseButton/index.vue';
import { mapState, mapMutations, mapGetters } from 'vuex';
import HTTP from '@/plugins/http.js';
import eventsBus from '@/eventsBus.js';
import cloneDeep from 'lodash/cloneDeep';
import lazyImage from '@/modules/globals/lazyImage/index.vue';
import phoneValidateMask from '@/mixins/phoneValidateMask.js';
export default {
  name: 'QuickOrderForm',
  mixins: [phoneValidateMask],
  props: {
    productId: {
      required: true,
      type: Number,
    },
    cost: {
      required: true,
      type: Number,
    },
    price: {
      required: true,
      type: Number,
    },
    preparePrice: {
      required: true,
      type: Function,
    },
    setSelectedParam: {
      required: true,
      type: Function,
    },
  },
  mounted() {
    this.fieldsData = cloneDeep(this.fieldsList).map(f => {
      f.value =
        this.user[f.name] ||
        (this.address.data && this.address.data[f.name]) ||
        (this.shippingAddress.data && this.shippingAddress.data[f.name]) ||
        '';
      return f;
    });
  },
  components: { lazyImage, modalCloseButton },
  data() {
    return {
      comment: '',
      loading: false,
      successHtml: '',
      fieldsData: {},
      failedServerValid: false,
    };
  },
  computed: {
    ...mapState('quickOrder', [
      'fieldsList',
      'formIsShown',
      'enableUserComment',
    ]),
    ...mapState('user', ['user']),
    ...mapGetters('products', ['getProductById']),
    ...mapGetters('user', ['address', 'shippingAddress']),
    showFormWrapper: {
      get() {
        return this.formIsShown;
      },
      set(value) {
        this.showForm(value);
      },
    },
    product() {
      return this.getProductById(this.productId);
    },
    quantityWrapper: {
      get() {
        return this.product.selected.quantity;
      },
      set(value) {
        this.setSelectedParam({
          id: this.productId,
          name: 'quantity',
          value,
        });
      },
    },

    getValidationRule() {
      return field => {
        const rules = {
          email: {
            email: true,
          },
          phone: {
            phone: true,
          },
        };
        return {
          required: !!field.required,
          ...rules[field.name],
        };
      };
    },
  },
  methods: {
    ...mapMutations('quickOrder', ['showForm']),
    submitForm() {
      window.ga('send', 'event', 'checkout', 'clickToButtonQuickOrder');
      this.$validator.validateAll().then(result => {
        if (result) this.sendData();
      });
    },
    sendData() {
      this.loading = true;
      const fields = {};
      for (const key in this.fieldsData) {
        const field = this.fieldsData[key];
        let { name } = field;
        const { type, value } = field;
        if (type === 'address') name = `address::${name}`;
        fields[name] = value;
      }

      const service_variant = {};
      for (const key in this.product.selected.services) {
        const variant_id = this.product.selected.services[key];
        const service = this.product.info.services.find(
          s => s.variant_id === variant_id,
        );
        service_variant[service.id] = variant_id;
      }

      const formData = {
        product: {
          product_id: this.product.info.id,
          sku_id: this.product.selected.sku_id,
          quantity: this.quantityWrapper,
        },
        service_variant,
        services: Object.keys(service_variant),
        fields,
        quickorder_user_comment: this.comment,
      };
      HTTP.post('/sendQuickorder/', formData)
        .then(({ data }) => {
          this.loading = false;
          if (data.data) {
            this.successHtml = data.data.text;
            window.ga('send', 'event', 'checkout', 'quickOrderSendedSuccess');

            eventsBus.$emit('orderCreated', data.data);
          } else if (data.status === 'fail') {
            //Для отображения алерта с ошибкой валидации на беке
            this.failedServerValid = true;
            this.errors.error = data.errors;
          }
        })
        .catch(e => {
          this.loading = false;
          alert('Что-то пошло не так... Попробуйте еще раз');
        });
    },
  },
};
</script>
<style lang="scss">
.quickorder-wrap {
  .h2 {
    font-size: 24px;
    padding: 10px 30px 10px 0;
    text-align: left;
  }

  .form-group {
    display: flex;
    flex-wrap: wrap;
    min-width: 100%;
  }
  .backend-error > button {
    position: absolute;
    top: 5px;
    right: 10px;
  }
  .backend-error {
    margin-top: 20px;
    height: auto;
    opacity: 1;
    transition: all 0.3s ease;
    position: relative;
  }
  .backend-error.faded {
    margin: 0;
    opacity: 0;
    height: 0;
    padding: 0;
  }
  .summary {
    display: flex;
    flex-wrap: wrap;
  }
  form.quickorder-form {
    max-width: 800px;
    margin: 0 auto;
  }
  .submit-wrapper {
    display: flex;
    align-items: center;
  }
  .loader-wrapper {
    display: inline-block;
    padding: 5px;
    width: 35px;
  }

  .price,
  .summary span {
    font-size: 1.6em;
  }
  .summary > div {
    display: flex;
    align-items: center;
    justify-content: flex-start;
  }
  .summary span {
    display: inline-block;
  }
  .price-wrapp .quickorder-quantity input {
    padding: 6px;
    text-align: center;
    max-width: 60px;
    float: right;
  }
  .price-wrapp .quickorder-quantity:first-child {
    padding: 0;
    max-width: fit-content;
  }
  .price-wrapp .quickorder-quantity:last-child {
    text-align: left;
    white-space: nowrap;
  }
  label.quickorder-quantity {
    text-align: left;
    max-width: 125px;
  }
  .price-wrapp {
    display: flex;
    align-items: center;
  }
  div.control-label {
    padding-top: 0;
  }
  .quickorder-button {
    padding: 10px 8px;
  }
  @media screen and (max-width: 767px) {
    .price-wrapp .quickorder-quantity:first-child,
    .price-wrapp .quickorder-quantity:last-child {
      padding: 0 15px;
    }
    label.quickorder-quantity {
      display: none;
    }
    .price {
      text-align: right;
      font-size: 1.5em;
    }
    hr {
      margin-top: 0;
    }
    .summary p {
      justify-content: flex-start;
    }
    .quick_order_product_name {
      text-align: left;
    }
    .price-wrapp .quickorder-quantity input {
      float: left;
    }
    .control-label {
      width: 100%;
      text-align: left;
    }
    .quickorder-quantity.control-label.col-sm-8 {
      padding-left: 0;
    }
    .quickorder-quantity.control-label {
      max-width: 35%;
      width: fit-content;
    }
  }
  .image-wrap {
    display: flex;
    align-items: center;
    justify-content: center;
    img {
      width: 100%;
    }
  }
}
</style>
