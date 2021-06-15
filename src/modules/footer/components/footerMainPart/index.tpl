<div class="row footer-main-part"  itemscope itemtype="http://schema.org/PostalAddress">
  <div class="contactsFooter" >
    <h4>
    {if $smarty.server.REQUEST_URI eq '/'}
        <a href="{$wa_url}">
    {else}
        <a href="#" encode_href="{base64_encode($wa_url)}">
    {/if}
            <img src="/wa-apps/shop/themes/flip/img/Flip_logo-new.svg" alt="flip.com.ua - интернет магазин. Краски для авто."/>
        </a>
    </h4>
    <ul>
      <li>
        <h4>Есть вопросы? Звоните</h4>
        <p class="footer-phone"  @click="show('contacts');onAnimation('.contact-component .phone');">
          044 498-44-89
          <span class="phones-fog"></span>
        </p>
        <span class="heading-link"  @click="show('contacts');onAnimation('.contact-component .phone');">посмотреть все номера</span>
      </li>
      <li>
      
        <h4>Связаться онлайн</h4>
        <div class="contacts-icons">
          <a href="https://teleg.one/flipComUaBot" target="_blank" >
            <i class="icon-054-telegram" title="Задать вопрос в Telegram"></i>
          </a>
          <a href="viber://pa?chatURI=flipcomua" target="_blank" >
            <i class="icon-055-viber" title="Задать вопрос в Viber"></i>
          </a>
          {* <a href="skype:flip.kiev " >
            <i class="icon-056-skype" title="Написать в Skype"></i>
          </a> *}
          <a href="http://m.me/flip.com.ua">
            <i class="icon-057-messenger" title="Написать в Messanger"></i>
          </a>
          <a href="mailto:flip@flip.com.ua " >
            <i class="icon-034-envelope" title="Написать e-mail"></i>
          </a>
        </div>
      </li>
    </ul>
  </div> 
  
  <div class="addresses" id="shops-ul-toggle"  >
    <meta itemprop="addressCountry" content="Украина">
    <h4 data-target="#shops-ul-toggle">Магазины 
      <i  data-target="#shops-ul-toggle" title="раскрыть\закрыть список" class="icon-013-down"></i>
    </h4>
    <ul >
      <li>
        <meta itemprop="addressLocality" content="Киев">
        <h4 @click="show('contacts');onAnimation('.contact-component .addresses');">Киев-Академгородок</h4>
        <a itemprop="streetAddress" rel="nofollow"
          target="_blank"
          class="link-to-GM"
          href="https://goo.gl/maps/CCBS81Mh9aH3cUmh8">ул. Рабочая, 2-а</a>
        <div class="nowrap">
          <a href="tel:+38 (095) 343-80-83" class="heading-link">095 343-80-83
          </a>
          <a href="viber://chat?number=%2B380672234227" target="_blank">
            <i class="icon-055-viber" aria-label="чат в Viber"></i>
          </a>
          <a href="https://t.me/flipKiev" target="_blank">
            <i class="icon-054-telegram" aria-label="чат в Telegram"></i>
          </a>
        </div>
      </li>
      <li>
        <meta itemprop="addressLocality" content="Киев">
        <h4 @click="show('contacts');onAnimation('.contact-component .addresses');">Киев-Теремки</h4>
        <a itemprop="streetAddress" rel="nofollow"
          target="_blank"
          class="link-to-GM"
          href="https://goo.gl/maps/dc2LRTSwaviKtfNt7">ул. Заболотного, 11</a>
        <div class="nowrap">
            <a href="tel:+38 (093) 611-39-23 " class="heading-link">093 611-39-23</a>
            <a href="viber://chat?number=%2B380936113923" target="_blank">
              <i class="icon-055-viber" aria-label="чат в Viber"></i>
            </a>
            
            <a href="https://t.me/sergiovova" target="_blank">
              <i class="icon-054-telegram" aria-label="чат в Telegram"></i>
            </a>
        </div>
        (ориентир: Интайм №40)
      </li>
      <li>
        <h4 @click="show('contacts');onAnimation('.contact-component .addresses');" itemprop="addressLocality">Одесса</h4>
        <a itemprop="streetAddress" rel="nofollow"
          target="_blank"
          class="link-to-GM"
          href="https://goo.gl/maps/2UeEB85hxtAw9nmE9">пр-т Акад. Глушко, 29</a>
        <a href="tel:+380665549770 " class="heading-link">066 554-97-70</a>
      </li>
    </ul>
  </div>

  <div class="for-clients" id="for-client-ul-toggle">
    <h4 data-target="#for-client-ul-toggle">Клиентам 
      <i  data-target="#for-client-ul-toggle" title="раскрыть\закрыть список" class="icon-013-down"></i>
    </h4>
    <ul  >
      {$urls = [
      [
      'ancor' => 'О нас',
      'href' => '/about/'
      ],
      [
      'ancor' => 'Контакты',
      'href' => '/contacts/'
      ],
      [
      'ancor' => 'Доставка и оплата',
      'href' => '/oplata-i-dostavka/'
      ],
      [
      'ancor' => 'Сотрудничество',
      'href' => '/partnership/'
      ],
      [
      'ancor' => 'Наши вакансии',
      'href' => '/vakansii/'
      ],
      [
      'ancor' => 'Наши публикации',
      'href' => '/articles/'
      ]
      ]}
      {if $smarty.server.REQUEST_URI eq '/'}
      {foreach $urls as $item}
      <li>
        <a href="{$item.href}">{$item.ancor}</a>
      </li>
      {/foreach}
      {else}
      {foreach $urls as $item}
      <li>
        <a href="#" encode_href="{base64_encode($item.href)}" encode_text="{base64_encode($item.ancor)}"></a>
      </li>
      {/foreach}
      {/if}
    </ul>
  </div>
  
  <div class="socialFooter">
    <h4>Присоединяйтесь</h4>
    <ul class="socialButtons">
      {$urls = [
      [
      'ancor' => '<i class="icon-041-facebook" title="Страница в Facebook"></i>',
      'href' => 'https://www.facebook.com/flip.com.ua'
      ],
      [
      'ancor' => '<i class="icon-050-twitter" title="О новинках читайте в Twitter"></i>',
      'href' => 'https://twitter.com/FabrikaTsveta'
      ],
      [
      'ancor' => '<i class="icon-052-vk" title="Группа Вконтакте"></i>',
      'href' => 'https://vk.com/flip.kiev'
      ],
      [
      'ancor' => '<i class="icon-051-youtube" title="Подписаться на наш видеоканал"></i>',
      'href' => 'https://www.youtube.com/c/colorfactory?sub_confirmation=1'
      ]
      ]
      }
      {if $smarty.server.REQUEST_URI eq '/'}
      {foreach $urls as $item}
      <li>
        <a href="{$item.href}" title="{$item.title}" target="_blank">{$item.ancor}
        </a>
      </li>
      {/foreach}
      {else}
      {foreach $urls as $item}
      <li>
        <a encode_href="{base64_encode($item.href)}" encode_title="{base64_encode($item.title)}"  encode_text="{base64_encode($item.ancor)}" target="_blank">
        </a>
      </li>
      {/foreach}
      {/if}
    </ul>
    <h4 class="partners" id="partners-ul-toggle" data-target="#partners-ul-toggle">Партнеры
      <i  data-target="#partners-ul-toggle" title="раскрыть\закрыть список" class="icon-013-down"></i>
    </h4>
    <ul class="for-clients">
      <li>
        <a href="https://avto-digest.com/" target="_blank">Автоновости</a>
      </li>
      <li>
        <a href="https://colorfactory.pro/" target="_blank">Сервис колористам</a>
      </li>
      <li>
        <a href="https://www.agsat.com.ua/efirnye-resivery/" target="_blank">www.agsat.com.ua/dvb-t2</a>
      </li>
    </ul>
  </div>
  
</div>