{if !waRequest::isXMLHttpRequest()}
  <div id="listThumbs">
{/if}
  <div v-if="listThumbsIsLoading">
    <img
      src="/wa-apps/shop/themes/flip/img/loading16.gif"
      class="img-responsive"
    />
  </div>
  {if $products}
    <!-- sorting -->
    <div class="sort-table__block">
    {* всегда отображаем блок сортировки(если есть продукты) вне зависимости от того как "включено" в админке,
     потому как это логично и  он содержит переключатель вида списка продуктов (сетка-ряды)*}
      <filtered-count class="hidden-sm hidden-xs" :products-count="{$products_count}"></filtered-count>
      <div class="mobile-sort-filters-btn-wrapper">
        <div
        id="mobile_btn_filter"
        class="visible-sm visible-xs" v-if="filters.length"
        @click="toggleMobileFiltersAreOpened"
        >
          <i class="icon-048-filter"></i>
          <span>Фильтры</span>
          <span v-if="selectedFiltersArray.length" class="selected-filters-count">
          {literal} ({{ selectedFiltersArray.length }}){/literal}
          </span>
          <i class="icon-013-down"></i>
        </div>
        <div v-if="filters.length" class="divider hidden-lg hidden-md"></div>
        {include file="./components/sortingPlugin/index.html"}
      </div>
      {include file="./components/viewSwitcher/index.html"}
      
    </div>
  {/if}
  <div {literal}:class="{'listThumbsIsLoading': listThumbsIsLoading}"{/literal} id="listThumbs-inner"class="row">
    {if $products}
      <!-- products thumbnail list view -->
      {foreach from=$products item=p name=foo} {$available = $p.count === null || $p.count > 0} 
        {$product = shopSiteprofProductsAddedFieldsPlugin::updateProduct($p)}
        {* $wa->shop->settings('ignore_stock_count') *}
        <div class="category_item_product{if ($smarty.foreach.foo.index+1) % 3 == 0} firty-item{/if}">
            <div>
              {$badge_html = $wa->shop->badgeHtml($p.badge)} 
              {if $p.free_shipping == 1 && $p.currency == 'UAH'}
                <div class="corner top right">
                  <div class="icon icon_free_shipping_mini"></div>
                </div>
              {elseif $badge_html}
                <div class="corner top right">{$badge_html}</div>
              {/if}
              <a class="product_img" href="{$p.frontend_url}" title="{$p.name}" >
                <lazy-image error="/wa-apps/shop/themes/flip/img/dummy200.png" src="{$wa->shop->productImgUrl($p,'200')}" alt="{$p.name}"></lazy-image>
              </a>
            </div>
            <div class="discription-wrapper">
              <a class="heading-link" href="{$p.frontend_url}" title="{$p.name}">
                {strip_tags($p.name)}
                {if iconv_strlen(strip_tags($p.name))>70}<div class="foggy-1200 visible-lg"></div>{/if}
               {if iconv_strlen(strip_tags($p.name))>80}<div class="foggy-768 visible-sm visible-md"></div>{/if}
               {if iconv_strlen(strip_tags($p.name))>60}<div class="foggy-601 hidden"></div>{/if}
              </a>
              <div class="prod-interactive__stat">
                <rating :value="{$p.rating|replace:',':'.'}"></rating>
                {if $p.reviews_count > 0}
                  <a href="{$p.frontend_url}reviews/">({$p.reviews_count})</a>
                {else}
                  <span >(0)</span>
                {/if}
              </div>
            
              <div class="description">
              {if $p.summary}
               {strip_tags($p.summary)}
               {if iconv_strlen(strip_tags($p.summary))>125}<div class="foggy-1200 visible-lg"></div>{/if}
               {if iconv_strlen(strip_tags($p.summary))>185}<div class="foggy-768 visible-sm visible-md"></div>{/if}
               {if iconv_strlen(strip_tags($p.summary))>145}<div class="foggy-601 hidden"></div>{/if}
              {/if}
              </div>
              
            </div>
            <div class="offers">
              <div style="margin-bottom: auto;">
                {if $p.sku}
                  <span class="offers__sku">арт. {$p.sku}</span>
                {/if}
                {if $available && $p.is_old eq 0 && $p.price}
                  <span class="offers__availability">
                    Есть в наличии
                  </span>
                {elseif $p.is_old eq 0}
                <span class="offers__availability read-more-link">
                  Ожидается поступление
                </span>
                {elseif $p.is_old eq 1}
                <span class="offers__availability mute-text">
                  Снят с продаж
                </span>
                {/if}
              </div>
              {if $available && $p.is_old eq 0 && $p.price}
                <div class="offers-price__wrapper">
                  {if $p.price > 0} 
                    {* offers__price--small *}
                    <price-format class="offers__price{if $p.compare_price > 0} colorRed{/if}" :price="{$p.min_price|string_format:"%.2f"|replace:',':'.'}">
                      <template v-slot:before>{if ($p.skus && count($p.skus)>1)}<span class="from">от </span>{/if}</template>
                    </price-format>
                    {if $p.compare_price>0}
                      <price-format class="compare-at-price nowrap" :price="{$p.compare_price|string_format:"%.2f"|replace:',':'.'}"></price-format>
                    {/if}
                  {/if}
                </div>
                {if ($p.skus && count($p.skus)>1)}
                  <a href="{$p.frontend_url}" title="Выбрать {$p.name}" class="choice-sku-button btn-success btn">Выбрать</a>
                {else}
                  <add-to-cart-button
                    :init-data='{shopVuedataPlugin::getJsonProductDataForVue($p)}'
                    :id="{$p.id}"
                  >
                  </add-to-cart-button>
                {/if}
              {elseif $p.is_old eq 0}
                <p class="offers__availability-comment">
                Оставьте заявку и мы сообщим как только товар появится в продаже
                </p>
                <arrived-button :id="{$p.id}" class="wait-for-instock"></arrived-button>
              {elseif $p.is_old eq 1}
                <a class="btn btn--find-similar btn-block" href="{$p.frontend_url}" title="{$p.name}">
                  Посмотреть похожие
                </a>
              {/if}
              <to-compare-button :product-id="{$p.id}"></to-compare-button>
            </div>
        </div>
      {/foreach}
    
    {else}
    <div class="alert alert-info">По вашему запросу ничего не найдено</div>
    {/if}
  </div>
  {if $products AND $pages_count>1}
    <div class="tc">
      {shopSiteproffiltersRedirect::removeSelectedFeaturesFromGetParamsIfExistsForPagination()}
      {wa_pagination total=$pages_count nb=3 attrs=['class' => "pagination"] prev='<i class="icon-014-left" title="Назад"></i>' next='<i class="icon-015-right" title="Вперед"></i>'}
      {shopSiteproffiltersUrl::setSelectedFeaturesToGetParams()}
    </div>
  {/if}
{if !waRequest::isXMLHttpRequest()}
  </div>
{/if}