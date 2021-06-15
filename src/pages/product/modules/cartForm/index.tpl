
<div id="product_page_cart">
    <div class="row">
        <div id="cart-form">
          <cart-form
            :init-data='{shopVuedataPlugin::getJsonProductDataForVue($product, $services)}'
            :id="{$product.id}"
          >
          </cart-form>

        </div>

        <div class="blank"></div>

        <!-- compare -->
          <div class="col-xs-12"> 
          <to-compare-button :product-id="{$product.id}"></to-compare-button>

            <div class="row">
              {* <div class="col-xs-12 col-sm-6 col-lg-12 col-md-6" >
                  <div class=" product_compare">
                      <a {if $compare}style="display:none"{/if} class="compare-add  tl  btn-block btn btn-default" data-product="{$product.id}" href="#">
                          <i class="fa fa-plus"></i>
                          сравнить
                      </a>
                      <a {if !$compare}style="display:none"{/if} class="compare-remove  tl  btn-block btn btn-default" data-product="{$product.id}" href="#">
                          <span class="glyphicon glyphicon-remove"></span>
                          удалить из сравнения 
                      </a>
                      <a id="compare-link" class="btn btn-block tl btn-default" {if count($compare) lt 2}style="display:none"{/if} rel="nofollow" href="{$wa->getUrl('/frontend/compare/', ['id' => implode(',', $compare) ])}" >
                          [`Compare`] (<span class="count">{count($compare)}</span> шт)
                      </a>
                  </div>
                  </div> *}
              <div class="col-xs-6 col-sm-4 col-md-6" >
              </div>
            </div>
          </div>
    </div>
    <!-- list all SKUs for Schema.org markup -->
      {foreach $product.skus as $sku}
          <div itemprop="offers" itemscope itemtype="https://schema.org/AggregateOffer">
              {$sku_available =  $product.status and $sku.available and ($sku.count === null || $sku.count > 0)} {*$wa->shop->settings('ignore_stock_count') || *}
              <meta itemprop="name" {if $sku.name} content="{$sku.name|escape}" {else} content="{$product.name}" {/if}>
              <meta itemprop="price" content="{if $sku.name}{round($sku.price)}{else}{round($product.price)}{/if}">
              <meta itemprop="lowPrice"  content="{if $sku.name}{round($sku.price)}{else}{round($product.price)}{/if}">
              <meta itemprop="highPrice"  content="{if $sku.name}{round($sku.price)}{else}{round($product.price)}{/if}" >
              <meta itemprop="offerCount" {if $sku.name} content="{$sku.count}" {else} content="{$product.count}" {/if} >
              <meta itemprop="priceCurrency" content="{$product.currency}">
              {if (!($sku.count === null) and $sku.count <= 0)}
                  <link itemprop="availability" href="https://schema.org/OutOfStock" />
              {else}
                  <link itemprop="availability" href="https://schema.org/InStock" />
              {/if}
          </div>
      {/foreach}

      {if $sku.sku}<span class="hide" itemprop="sku">{$sku.sku}</span> {/if}
      
      {$brand = shopSiteprofProductsAddedFieldsPlugin::getProductBrandFriomFeatures($product.features)}
      {if $brand}
        <span class="hide" itemprop="brand">{$brand}</span>
      {/if}
</div>