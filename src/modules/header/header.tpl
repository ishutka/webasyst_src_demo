<div id="header">
    <div id="preMenuCategory">
       <div class="container">
            <div id="toggleMenuButton">
                <div id="headerLogoColumn">
                    {if $smarty.server.REQUEST_URI eq '/'}
                        <a href="{$wa_url}">
                    {else}
                        <a href="#" encode_href="{base64_encode($wa_url)}">
                    {/if}
                            <img src="/wa-apps/shop/themes/flip/img/Flip_logo-new-Mask.svg" alt="flip.com.ua - интернет магазин. Краски для авто." id="logo" />
                        </a>
                </div>
                <toggle-menu ></toggle-menu> 
                <strong class="show-category-heading">Каталог товаров</strong>
            </div>
            <div class="hidden-xs hidden-sm top-search-wrap-block" >
                <quick-search-wrapper></quick-search-wrapper>
            </div>
            
            <div id='header-phones-and-cart'>
                <div class="phone-center hidden-xs" @click="show('contacts');onAnimation('.contact-component .phone');">
                    <span class="fa-stack-phone">
                        <i class="icon-018-phone"></i>
                    </span>
                    <div class="call-block">
                      <div>
                        <span>Киев</span> 
                        <span>Одесса</span>
                      </div> 
                      <div class="phone" x-ms-format-detection="none">
                        (044) 498-44-89
                        <div class="phones-fog"></div>
                      </div>
                    </div>
                </div>
                <!-- {if shopSiteprofPriceControlPlugin::show_price_USD(10) == false}
                {$rate_usa=shopSiteprofCurrencyPlugin::get('currency_usd')}
                {else} {$rate_usa=0}
                {/if} -->
                <user-buttons class="visible-xs" :rate={$rate_usa} >
                </user-buttons>

                <mini-cart-mobile-link>
                </mini-cart-mobile-link>
                
            </div>
            <div class="medium-header-search-bar">
                <toggle-menu>
                </toggle-menu>
                
                <quick-search-wrapper>
                </quick-search-wrapper>
                
                <mini-cart-mobile-link>
                </mini-cart-mobile-link>
            </div>
            <div id="top_categories" class="col-xs-12" {literal}:class="{'opened-menu':menuIsSwitched}"{/literal}>
                <top-categories>
                </top-categories>
            </div>
       </div>
    </div>
    <div class="hidden-xs hidden-sm">
        {include file="./components/menuPrimaryMenuLine/index.html"}
    </div>
    <modal 
        name="modal-signin" 
        width="100%"
        height="auto"
        :max-width="430"
        adaptive
        :click-to-close="false"
    >
        <div>
            <div class="h2">Авторизация</div>
            <modal-close-button modal-name="modal-signin"></modal-close-button>
            {*webasyst  плагин для атвторизации через соцсети: *}
            {$wa->authAdapters()|regex_replace:'/<script[^>]*.*<\/script>/':''}
            <login-form></login-form>
        </div>
    </modal>
    <modal
        name="modal-register"
        height="620"
        :click-to-close="false"
        width="100%"
        :max-width="430"
        adaptive
    >
        <div>
            <div class="h2">Регистрация</div>
            <modal-close-button modal-name="modal-register"></modal-close-button>
            {*webasyst плагин для атвторизации через соцсети: *}
            {$wa->authAdapters()|regex_replace:'/<script[^>]*.*<\/script>/':''}
            <signup-form></signup-form>
        </div>
    </modal>
</div> <!-- #header -->
<script>
    includeJsLink('header');
</script>