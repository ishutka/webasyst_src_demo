<div id="top_line" class="container hidden-xs">
      <div class="free-shipping">
        <strong>БЕСПЛАТНАЯ ДОСТАВКА ПО КИЕВУ И ОДЕССЕ</strong> для заказов от 4500 грн.
      </div>
      <ul id="top_left_nav">
        {$urls = [
          [
            'ancor' => 'Контакты',
            'href' => '/contacts/',
            'class' => ''
          ],

          [
            'ancor' => 'Доставка и оплата',
            'href' => '/oplata-i-dostavka/',
            'class' => ''
          ]

        ]}
        <!-- TODO: Коля,я не пойму нужен ли нам этот блок в новом дизайне.Вадим,вроде пока сказал оставить только 
        ссылки на "Доставка" и "Контакты" -->
        {if $smarty.server.REQUEST_URI eq '/' }
          {foreach $urls as $item}
            <li
              {if $item.class}class="{$item.class}"{/if}
            >
              <a href="{$item.href}">{$item.ancor}</a>
            </li>
          {/foreach}
        {else}
        {foreach $urls as $item}
          <li 
            {if $item.class}class="{$item.class}"{/if}
          >
            <a href="#" encode_href="{base64_encode($item.href)}" encode_text="{base64_encode($item.ancor)}"></a>
          </li>
        {/foreach}
        {/if}
      </ul>
   
      <div class="user-btns-container">
        {if shopSiteprofPriceControlPlugin::show_price_USD(10) == false}
          {$rate_usa=shopSiteprofCurrencyPlugin::get('currency_usd')}
          {else} {$rate_usa=0}
        {/if}
        <user-buttons :rate={$rate_usa}>  
        {* слотом передаем webasyst плагин для атвторизации через соцсети: *}
        {$wa->authAdapters()|regex_replace:'/<script[^>]*.*<\/script>/':''} 
        </user-buttons>
      </div>
</div>