{if $product.is_old eq '0' && $sku.count >0}
<div id="product_page_shipping">
  {if $sku.stock_poland} 
    {shopSiteprofProductShippingPlugin::getPolandHtml()}
  {/if}
  <div class="product_page_shipping">
    <div class="col-xs-1">
      <span class="fa-stack fa-lg tc">
        <i class="fa fa-circle fa-stack-2x"></i>
        <img src="/wa-apps/shop/themes/flip/img/ParcelPickup.svg" class="icon icon-pickup" alt="Самовывоз"/>
      </span>
    </div>
    <div class="col-xs-10">
      <strong>
        Самовывоз
      </strong>
    </div>

    <div class="col-xs-11 col-xs-offset-1">
      <ul class="ship_variants">
        <li>
          <a rel="nofollow" href="https://goo.gl/maps/CCBS81Mh9aH3cUmh8" target="_blank">
            <span class="town-city">Киев-Академгородок</span>: ул. Рабочая, 2-а <i aria-label="карта" class="icon icon-026-address"></i>
          </a>
        </li>
        <li>
         <a rel="nofollow" href="https://goo.gl/maps/dc2LRTSwaviKtfNt7" target="_blank">
          <span class="town-city">Киев-Теремки</span>: ул. Заболотного, 11 <i aria-label="карта" class="icon icon-026-address"></i>
         </a>
        </li>
        <li>
         <a rel="nofollow" href="https://goo.gl/maps/CHiZLxqDcmupunJC7" target="_blank">
          <span class="town-city">Одесса</span>: пр-т Акад. Глушко, 29А <i aria-label="карта" class="icon icon-026-address"></i>
         </a>
        </li>
      </ul>
    </div>
    <div class="clearfix"></div>
  </div>
  <div class="product_page_shipping">
    <div class="col-xs-1">
      <span class="fa-stack fa-lg tc">
        <i class="fa fa-circle fa-stack-2x"></i>
        <i class="fa fa-truck fa-inverse"> </i>
      </span>
    </div>
    <div class="col-xs-10">
      <strong>
        Доставка 
        {if !$sku.stock_poland}
          <!-- <a
            data-toggle="modal"
            data-target="#product_modal"
            class="ship_modal_link modal_link"
            rel="/static/product_shipping.html"
            href="#"
            ><i class="fa fa-info-circle"></i
          ></a> -->
        {/if}
      </strong>
    </div>

    <div class="col-xs-11 col-xs-offset-1">
      <ul class="ship_variants">
        {$shippingCost = shopSiteprofProductsAddedFieldsPlugin::getShippingCost($product.price)}
        {if $shippingCost && !$sku.stock_poland}
          <li>
            По Киеву: 
            {if $product.free_shipping == 1 && $product.currency == 'UAH'} 
              <strong class="attention">БЕСПЛАТНО</strong> 
            {else}
              <span class="price nowrap" id="productShippingCost">
                {$shippingCost.rate_formated}
              </span>
            {/if}
          </li>
        {/if}
        <li>
          по Украине: 
          {if $sku.stock_poland} 
            Мы доставим этот товар курьером службы доставки <strong>Мист Экспресс</strong> по тарифам перевозчика
          {else} 
            {if $product.free_shipping == 1 && $product.currency == 'UAH'}
              <strong class="attention">БЕСПЛАТНО</strong> 
            {*  <a
                  data-toggle="modal"
                  data-target="#product_modal"
                  rel="/static/product_shipping.html"
                  class="ship_text_modal_link modal_link"
                  href="#"
                  >подробнее</a>
               или <a href="/aktsiya-besplatnaya-dostavka-po-ukraine/">бесплатно*</a> *}
            {else}
              согласно тарифам перевозчика
            {/if} 
          {/if}
        </li>
      </ul>
    </div>
    
      {$np_settings = shopSiteprofProductShippingPlugin::getNovaPoshtaSettings()}
      <quick-shipping id="quick-shipping"
        :is-can-ship-tomorrow="{if $np_settings.next_receive_time->isTomorrow()}true{else}false{/if}"
        next-receive-day="{$np_settings.next_receive_day}"
        next-receive-date="{$np_settings.next_receive_date}"
        distance-to-send-time="{$np_settings.distance_send_time_hours}"
      >
      </quick-shipping>

    {* <div
      class="quickShipping col-xs-12"
      style="display: none;"
      data-end-hours="15"
      data-is-tomorrow=""
    >
      <div class="col-xs-3">
        <img src="/wa-apps/shop/themes/flip/img/delivery_car.svg" alt="" />
      </div>
      <div class="col-xs-8">доставка на завтра</div>
      <div><i class="fa fa-angle-down"></i></div>
    </div> *}
    {* 
      <div class="quickShippingOpen col-xs-12" style="display: block;">
      <div class="flex">
        <div class="col-xs-11 col-sm-6 col-xs-offset-1">
          <strong>Хочешь этот товар </strong>
          <strong>в&nbsp;четверг, 21 июня?</strong> <span>*</span>
          <p>
            Сделай заказ в течении
            <span class="time_hour ">&nbsp;23 часов, 3 минут</span>

            выбрав при оформлении доставку в отделении Новой Почты
            <a
              href="/oplata-i-dostavka/#shipping_ua"
              target="_blank"
              class="ship_text_modal_link"
              >подробнее</a
            >
          </p>
          <span>*</span>
          <p class="star_comments">
            возможность доставки в указанную дату будет уточнена на странице
            оформления заказа
          </p>
        </div>
        <div class="hidden-xs col-sm-5">
          <img
            src="/wa-apps/shop/themes/flip/img/delivery_car_clock.svg"
            alt=""
          />
        </div>
      </div>
    </div> 
    <div class="quickShippingUnable col-xs-12" style="display: none;">
      <div class="col-xs-11 col-xs-offset-1">
        <strong
          >Доставка в отделение Новой Почты, завтра
        </strong>
      </div>
      <div class="col-xs-11 col-xs-offset-1">
        <p>
          Оформив заказ в течении
          <span class="time_hour ">&nbsp;23 часов, 3 минут</span>

          <a href="/oplata-i-dostavka/#shipping_ua" class="ship_text_modal_link"
            >подробнее</a
          >
        </p>
      </div>
    </div>
    *}
    <div class="clearfix"></div>
  </div>

  <div class="product_page_shipping ">
    <div class="col-xs-1">
      <span class="fa-stack fa-lg tc">
        <i class="fa fa-circle fa-stack-2x"></i>
        <i class="fa fa-usd fa-inverse"> </i>
      </span>
    </div>
    <div class="col-xs-10">
      <strong>
        Оплата {if !$sku.stock_poland}
        {* <a
          data-toggle="modal"
          data-target="#product_modal"
          class="ship_modal_link modal_link"
          rel="/static/product_payment.html"
          href="#"
          ><i class="fa fa-info-circle"></i
        ></a> *}
        {/if}
      </strong>
    </div>
    <div class="col-xs-11 col-xs-offset-1">
        <ul class="ship_variants">
          {if !$sku.stock_poland}
          <li>безналичная по счету</li>
          {/if}
          <li>наличными при получении товара</li>
        </ul>
      
    </div>
    <div class="clearfix"></div>
  </div>
</div>
<div class="blank"></div>
{/if}
