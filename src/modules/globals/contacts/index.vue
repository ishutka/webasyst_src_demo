<template>
  <ul class="contact-component nav navbar-nav">
    <li class="phone">
      <div class="subheading">
        <i class="icon-019-phone icon"></i>
        <div class="h5">Позвонить</div>
      </div>
      <div class="city-phone-wrap">
        <div class="contact-item">
          <div class="h6">Киев-Академгородок</div>
          <div class="nowrap">
            <a href="tel:+38 (067) 223-42-27">
              (067) 223-42-27
            </a>
            <span class="mute">(Kyivstar)</span>
          </div>
          <div class="nowrap">
            <a href="tel:+38 (095) 343-80-83">
              (095) 343-80-83
            </a>
            <span class="mute">(Vodafone)</span>
          </div>
        </div>
        <div class="contact-item">
          <div class="h6">Киев-Теремки</div>
          <div class="nowrap">
            <a href="tel:+38 (093) 611-39-23 ">
              (093) 611-39-23
            </a>
            <span class="mute">(Lifecell)</span>
          </div>
        </div>
        <div class="contact-item">
          <div class="h6">Одесса</div>
          <div class="nowrap">
            <a href="tel:+380665549770 ">
              (066) 554-97-70
            </a>
            <span class="mute">(Vodafone)</span>
          </div>
          <div class="nowrap">
            <a href="tel:+38(093) 282 2259 ">
              (093) 282-22-59
            </a>
            <span class="mute">(Lifecell)</span>
          </div>
        </div>
      </div>
    </li>

    <li class="write-us">
      <div class="subheading">
        <i class="icon-036-envelope icon"></i>
        <div class="h5">Написать</div>
        <p class="warning-text">
          В Viber и Telegram звонки не принимаются! Только сообщения.
        </p>
      </div>
      <div class="contact-item viber-telegram">
        <div class="h6">Киев-Академгородок</div>
        <p class="gray" x-ms-format-detection="none">(095) 343-80-83</p>
        <div class="nowrap">
          <a
            href="viber://chat?number=%2B380953438083"
            target="_blank"
            class="viber-link"
          >
            <i class="icon-055-viber" aria-label="чат в Viber"></i>
            Viber
          </a>
          <a href="https://t.me/flipKiev" target="_blank" class="telegram-link">
            <i class="icon-054-telegram" aria-label="чат в Telegram"></i>
            Telegram
          </a>
        </div>
      </div>
      <div class="contact-item viber-telegram">
        <div class="h6">Киев-Теремки</div>
        <p class="gray" x-ms-format-detection="none">(093) 611-39-23</p>
        <div class="nowrap">
          <a
            href="viber://chat?number=%2B380936113923"
            target="_blank"
            class="viber-link"
          >
            <i class="icon-055-viber" aria-label="чат в Viber"></i>
            Viber
          </a>
          <a
            href="https://t.me/sergiovova"
            target="_blank"
            class="telegram-link"
          >
            <i class="icon-054-telegram" aria-label="чат в Telegram"></i>
            Telegram
          </a>
        </div>
      </div>
      <div class="contact-item">
        <a href="https://teleg.one/flipComUaBot" target="_blank">
          @flipComUaBot
        </a>
        <p>Telegram</p>
      </div>
      <div class="contact-item">
        <a href="viber://pa?chatURI=flipcomua">flipcomua</a>
        <p>Viber</p>
      </div>
      <div class="contact-item">
        <a href="http://m.me/flip.com.ua" target="_blank">flipcomua</a>
        <p>Messenger</p>
      </div>
    </li>
    <li class="addresses">
      <div class="subheading">
        <i class="icon-025-address"></i>
        <div class="h5">Приехать</div>
      </div>
      <div class="contact-item">
        <div class="h6">
          Киев-Академгородок
        </div>
        <a
          rel="nofollow"
          target="_blank"
          class="link-to-GM"
          href="https://goo.gl/maps/CCBS81Mh9aH3cUmh8"
        >
          ул. Рабочая, 2-а
        </a>

        <p class="additional">
          Маршрутка 301 от м Академгородок. <br />Ехать до конечной (3
          остановки).
        </p>
        <a href="tel:+380 (095) 343-80-83"
class="link-to-GM">(095) 343-80-83</a>
      </div>
      <div class="contact-item">
        <div class="h6">Киев-Теремки</div>
        <a
          rel="nofollow"
          target="_blank"
          class="link-to-GM"
          href="https://goo.gl/maps/dc2LRTSwaviKtfNt7"
        >
          ул. Заболотного, 11
        </a>
        <p class="additional">
          (ориентир: Интайм №40)
        </p>
        <a href="tel:+380936113923" class="link-to-GM">(093) 611-39-23</a>
      </div>
      <div class="contact-item">
        <div class="h6">Одесса</div>
        <a
          rel="nofollow"
          target="_blank"
          class="link-to-GM"
          href="https://goo.gl/maps/2UeEB85hxtAw9nmE9"
        >
          пр-т Акад. Глушко, 29
        </a>
        <p class="additional">
          (ориентир: &#171;Таврія В&#187;)
        </p>
        <a href="tel:+380665549770" class="link-to-GM">(066) 554-97-70</a>
      </div>
    </li>
  </ul>
</template>

<script>
export default {};
</script>

<style lang="scss">
@import '@/mainStylesVariables.scss';
.contact-component {
  margin: 0;
  max-width: 100%;
  display: inline-flex;
  flex-direction: column;
  color: $body_font_color;

  li {
    padding-left: 55px;
    margin-bottom: 35px;
    position: relative;
    &:not(:last-child):after {
      position: absolute;
      content: '';
      width: calc(100% + 50px);
      border-top: 0.5px solid #707070;
      bottom: -25px;
      left: -25px;
    }
  }
  a {
    font-size: 16px;
    font-weight: 600;
  }
  .warning-text {
    color: $red_color;
    font-weight: bold;
    width: 100%;
    padding-left: 60px;
    margin-bottom: 0;
    line-height: 16px;
  }
  .subheading {
    display: flex;
    align-items: center;
    margin-left: -59px;
    margin-bottom: 12px;
    flex-wrap: wrap;

    .h5 {
      margin: 0;
      font-size: 18px;
      color: $body_font_color;
      font-family: 'Fira Sans Bold', sans-serif;
    }
    i {
      margin-right: 24px;
      font-size: 35px;
    }
  }
  .viber-link,
  .telegram-link {
    margin-right: 5px;
    padding: 2px 5px;
    border-radius: 11px;
    color: #fff;
    font-size: 12px;
    line-height: 1.1;
    border: 1px solid;
    display: inline-flex;
    align-items: center;
    &:hover,
    &:active {
      background: none;
    }
    i {
      margin-right: 5px;
    }
  }
  .viber-link {
    background: #7b4b9b;
    border-color: #7b4b9b;
    &:hover,
    &:active {
      color: #7b4b9b;
    }
  }
  .telegram-link {
    background: #1d91c2;
    border-color: #1d91c2;
    &:hover,
    &:active {
      color: #1d91c2;
    }
  }
  .city-phone-wrap {
    display: flex;
    align-items: flex-start;
    flex-wrap: wrap;
  }
  .city-phone-wrap .contact-item {
    flex: 1 0 calc(50% - 50px);
    width: calc(50% - 50px);
    display: flex;
    flex-wrap: wrap;
    > * {
      width: 100%;
    }
    .nowrap {
      display: flex;
      align-items: center;
    }
    .mute {
      font-size: 12px;
      margin-left: 10px;
    }
    a {
      color: $small_link_color;
      &:hover,
      &:active {
        color: $main_brand_color;
      }
    }
  }
  .contact-item {
    display: inline-block;
    vertical-align: top;
    margin-right: 50px;
    margin-bottom: 20px;
    p {
      margin-bottom: 0;
    }
    .h6 {
      margin: 0;
      font-size: 16px;
      font-weight: 600;
      color: #000;
      width: 100%;
      margin-bottom: 3px;
    }
    .link-to-GM {
      display: block;
      font-size: inherit;
      font-weight: inherit;
      color: $small_link_color;
      &:hover,
      &:active,
      &:focus {
        color: $main_brand_color;
      }
    }
    .additional {
      font-size: 12px;
      margin: 0;
    }
    &:last-child {
      margin-bottom: 0;
    }
  }
  .viber-telegram {
    float: left;
    margin-right: 0;
    width: 50%;
    .gray {
      font-size: 12px;
      font-weight: bold;
    }
  }
  .write-us .contact-item:not(.viber-telegram) {
    margin-bottom: 15px;
  }
  @media screen and (max-width: 767px) {
    .warning-text {
      margin: -5px 0 5px;
    }
    .city-phone-wrap {
      flex-wrap: wrap;
      .contact-item {
        flex: 1 1 100%;
        max-width: 100%;
        a {
          font-size: 20px;
        }
        .mute {
          font-size: 14px;
        }
      }
    }
    .viber-telegram {
      width: 100%;
    }
    .viber-link,
    .telegram-link {
      font-size: 16px;
      padding: 5px 12px;
      border-radius: 22px;
      i {
        font-size: 23px;
      }
    }
  }
}
</style>
