<script>
import { mapState, mapGetters } from 'vuex';
export default {
  props: {
    /*
     * могу ли я получить товар завтра? если закажу сейчас distanceToSendTime
     */
    isCanShipTomorrow: {
      type: Boolean,
      required: true,
    },
    nextReceiveDay: {
      type: String,
      required: true,
    },
    /*
     * ближайшая дата получения товара, если заказать в течении nextReceiveDate
     */
    nextReceiveDate: {
      type: String,
      required: true,
    },
    /*
     * количество времени, которое осталось до того, что бы можно было оформить заказ и получить товар завтра
     */
    distanceToSendTime: {
      type: String,
      required: true,
    },
  },
  computed: {
    ...mapGetters('index', ['currentThemePath']),
  },
  data() {
    return {
      isOpenQuickShippingInfo: false,
    };
  },
};
</script>
<template>
  <div>
    <!-- TODO:  если возможна доставка на завтра !!isCanShipTomorrow -->
    <div
      class="quickShipping col-xs-12"
      @click="isOpenQuickShippingInfo = !isOpenQuickShippingInfo"
    >
      <div class="delivery-img">
        <img :src="`${currentThemePath}img/delivery_car.svg`" alt="Доставка" />
        <!-- TODO: получить из геттера путь к текущей теме -->
      </div>
      <div class="delivery-tomorrow">доставка на завтра</div>
      <div class="angle-arrow">
        <i v-if="!isOpenQuickShippingInfo" class="fa fa-angle-down"></i>
        <i v-if="isOpenQuickShippingInfo" class="fa fa-angle-up"></i>
      </div>
    </div>

    <div
      v-if="isOpenQuickShippingInfo === true"
      class="quickShippingOpen col-xs-12"
    >
      <button
        type="button"
        class="close"
        @click="isOpenQuickShippingInfo = false"
      >
        ×
      </button>

      <div class="flex">
        <div class="col-xs-11 col-sm-6 col-xs-offset-1 shipping-open-text">
          <strong class="asterisk-after">
            Хочешь этот товар
            <span v-html="`${nextReceiveDay}, ${nextReceiveDate}?`" />
          </strong>
          <p class="main-text">
            Сделай заказ в течении
            <span class="time_hour  time_minute" v-html="distanceToSendTime" />
            <!-- TODO: рассчет динамический, js  -->
            выбрав при оформлении доставку в отделение Новой Почты
            <a
              href="/oplata-i-dostavka/#shipping_ua"
              target="_blank"
              class="ship_text_modal_link"
            >
              подробнее
            </a>
          </p>
          <p class="star_comments">
            возможность доставки в указанную дату будет уточнена на странице
            оформления заказа
          </p>
        </div>
        <div class="hidden-xs col-sm-5 shipping-open-img">
          <img
            :src="`${currentThemePath}img/delivery_car_clock.svg`"
            alt="Быстрая доставка"
          />
        </div>
      </div>
    </div>
  </div>
</template>
