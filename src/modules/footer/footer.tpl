<!-- see index.html for base footer layout -->

<div id="footer" >

  <div class="container">
    {include file="./components/footerMainPart/index.tpl"}
    {include file="./components/footerCategoriesLinks/index.html"}
    
    <div class="footer-bottom">
      <div id="copyright">
        <p>
        <span>&copy; 2013-{time()|wa_datetime:"Y"} FLIP.COM.UA | Автомобильные краски Киев, Одесса, Украина</span> <br/>
          Интернет-магазин flip.com.ua – все для автомаляра. Администрация и владелец 
          сайта не несут ответственности за ущерб или упущенную выгоду, причинённые в 
          результате использования или невозможности использования информации с этого 
          сайта. Администрация и владелец сайта не несут ответственности за информацию 
          и высказывания, размещённые посетителями в комментариях и обсуждениях продуктов. 
          Все высказывания и информация, размещённые посетителями в комментариях и 
          обсуждениях продуктов на этом сайте, выражают точку зрения исключительно автора 
          конкретного сообщения и никак не связаны с точкой зрения администрации или владельца сайта.
        </p>

      </div>
    </div>
  </div>
  


  <button-to-top class="visible-xs"></button-to-top>
  <helping-buttons></helping-buttons>
  <product-arrived-init :init-settings='{shopArrivedPlugin::getJsonSettings()}'></product-arrived-init>
   <modal
      name="contacts"
      :resizable="true"
      adaptive
      :min-width="250"
      :max-width="700"
      width="90%"
      :min-height="500"
      scrollable
      height="auto"
      root
      classes="contacts-modal"
    >
      <h4>Контакты</h4>
      <modal-close-button modal-name="contacts"></modal-close-button>
      <contacts></contacts>
    </modal>
</div>

<!-- plugin hook: 'frontend_footer' -->
{* @event frontend_footer.%plugin_id% *}
{if isset($frontend_footer)}
  {foreach $frontend_footer as $_}{$_}{/foreach}
{/if}

<div id="eventsBus"></div>
<script>
  includeJsLink('footer');
</script>