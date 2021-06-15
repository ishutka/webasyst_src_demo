<div class="col-xs-12" id="comparingProductsItem">
  <h1>
    Сравнение спутниковых ресиверов {$data.product_1.name} и
    {$data.product_2.name}
  </h1>
  {$data.description}
  <div class="table-responsive">
      <table class="table">
         <tr>
          <td style="width:50%;" colspan="2">
            <a
              title="{$data.product_1.name|escape}"
              href="{$wa->shop->productImgUrl($data.product_1, '1200')}"
              class="fancybox"
            >
              {$wa->shop->productImgHtml($data.product_1, '400', [ 'itemprop' =>
              'image', 'class' => 'img-responsive', 'alt' =>
              $data.product_1.name|escape|cat:' фото' ])}
            </a>
          </td>
      
          <td style="width:50%;" colspan="2">
            <a
              title="{$data.product_2.name|escape}"
              href="{$wa->shop->productImgUrl($data.product_2, '1200')}"
              class="fancybox"
            >
              {$wa->shop->productImgHtml($data.product_2, '400', [ 'itemprop' =>
              'image', 'class' => 'img-responsive', 'alt' =>
              $data.product_2.name|escape|cat:' фото' ])}
            </a>
          </td>
        </tr>
      
        <tr>
          <td colspan="2">
            <a
              title="Купить {$data.product_1.name}"
              target="_blank"
              href="{$data.product_1.frontend_url}"
              >{$data.product_1.name|escape}</a
            >
          </td>
      
          <td colspan="2">
            <a
              title="Купить {$data.product_2.name}"
              target="_blank"
              href="{$data.product_2.frontend_url}"
              >{$data.product_2.name|escape}</a
            >
          </td>
        </tr>
      
        <tr>
          <td colspan="2">{$data.product_1.summary|escape}</td>
      
          <td colspan="2">{$data.product_2.summary|escape}</td>
        </tr>
      
        <tr>
          <td colspan="2">
            {if $data.product_1.reviews_count > 0}
            <p>
              <a
                class="btn btn-default"
                target="_blank"
                href="{$data.product_1.frontend_url}reviews/"
                >отзывы ({$data.product_1.reviews_count})</a
              >
            </p>
            {$best_review =
            shopSiteprofReviewsPlugin::getBestReviewForProductPage($data.product_1.id)}
            {if $best_review}
            <div class="reviews">
              <ul class="reviews-branch">
                <li data-id="{$best_review.id}" data-parent-id="0">
                  {include file="../../modules/globals/review/review.tpl"
                  review=$best_review inline reply_allowed=false single_view=true }
                  <ul class="menu-v with-icons reviews-branch"></ul>
                </li>
              </ul>
            </div>
            {/if} {else} отзывы отсутствуют {/if}
          </td>
      
          <td colspan="2">
            {if $data.product_2.reviews_count > 0}
            <p>
              <a
                class="btn btn-default"
                target="_blank"
                href="{$data.product_2.frontend_url}reviews/"
                >отзывы ({$data.product_2.reviews_count})</a
              >
            </p>
            {$best_review =
            shopSiteprofReviewsPlugin::getBestReviewForProductPage($data.product_2.id)}
            {if $best_review}
            <div class="reviews">
              <ul class="reviews-branch">
                <li data-id="{$best_review.id}" data-parent-id="0">
                  {include file="../../modules/globals/review/review.tpl"
                  review=$best_review inline reply_allowed=false single_view=true }
                  <ul class="menu-v with-icons reviews-branch"></ul>
                </li>
              </ul>
            </div>
            {/if} {else} отзывы отсутствуют {/if}
          </td>
        </tr>
      
        <tr class="summary">
          <td colspan="2">
            {if $data.product_1.rating > 0}
            <span class="rating nowrap"
              >{$wa->shop->ratingHtml($data.product_1.rating)}</span
            >
            {else} - {/if}
          </td>
      
          <td colspan="2">
            {if $data.product_2.rating > 0}
            <span class="rating nowrap"
              >{$wa->shop->ratingHtml($data.product_2.rating)}</span
            >
            {else} - {/if}
          </td>
        </tr>
      
        <tr class="summary">
          <td colspan="2">
            {if $data.product_1.is_old eq 0} {$available = $data.product_1.count ===
            null || $data.product_1.count > 0} {if $available}
            <div class="text-muted text_in_stock ">есть в наличии</div>
            {if $data.product_1.price > 0}
              <div class="price nowrap">
                {shop_currency_html($data.product_1.price,$data.product_1.currency)}
              </div>
              {*
                <div class="usd_price nowrap">
                  {shop_currency_html($data.product_1.price_usd,'USD','USD','h',true)}
                </div>
              *} 
            {/if}
            <a
              title="Купить {$data.product_1.name}"
              target="_blank"
              href="{$data.product_1.frontend_url}"
              class="btn btn-lg btn-success"
            >
              Купить
            </a>
            {else}
            <div class="out-of-stock"><strong>Нет в наличии</strong></div>
            <div class="blank"></div>
            <arrived-button :id="{$data.product_1.id}"></arrived-button> {/if} {else}
            <span style="font-size:16px;" class="label label-warning"
              >Снят с производства</span
            >
            <div class="blank"></div>
            {assign var=new_products
            value=shopSiteprofoldproductsPlugin::show_new_products($data.product_1.id)}
            {if $new_products}
            <div id="show_new_products_outer">
              <div class="label label-success">Рекомендуем новые модели</div>
              <div id="show_new_products" class="owl-carousel">
                {foreach from=$new_products item=p}
                  <div>
                    <a
                      class="new_prodcut_img"
                      target="_blank"
                      href="{$p.frontend_url}"
                    >
                      {if $p.image_id} {$wa->shop->productImgHtml(['id'=> $p.id,
                      'image_id' => $p.image_id, 'class' => 'img-responsive','ext' =>
                      $p.ext, 'image_desc' => $p.name, 'image_filename' =>
                      $p.image_filename], '300x300', ['alt' => $p.name,'class' =>
                      'img-responsive'])} {else}
                      <img class="img-responsive" src="/images/no-photo.gif" /> {/if}
                    </a>
                    {if $p.price > 0}
                    <p>
                      <span class="price nowrap"
                        >{shop_currency_html($p.price,$p.currency)}</span
                      >
                      {* $p.price_usd
                        <div class="usd_price nowrap">
                          shop_currency_html($p.price_usd,'USD','USD','h',true)}
                        </div>
                      *} 
                    </p>
                    {else}
                      <p class="out-of-stock"><strong>Нет в наличии</strong></p>
                    {/if}
                    <a class="new_prodcut_name" href="{$p.frontend_url}">{$p.name}</a>
                  </div>
                {/foreach}
              </div>
              <div class="big_blank"></div>
            </div>
            <hr />
            {/if} {/if}
          </td>
          <td colspan="2">
            {if $data.product_2.is_old eq 0} {$available = $data.product_2.count ===
            null || $data.product_2.count > 0} {if $available}
            <div class="text-muted text_in_stock ">есть в наличии</div>
            {if $data.product_2.price > 0}
              <div class="price nowrap">
                {shop_currency_html($data.product_2.price,$data.product_2.currency)}
              </div>
              {*
                <div class="usd_price nowrap">
                  {shop_currency_html($data.product_2.price_usd,'USD','USD','h',true)}
                </div>
              *} 
            {/if}
            <a
              title="Купить {$data.product_2.name}"
              target="_blank"
              href="{$data.product_2.frontend_url}"
              class="btn btn-lg btn-success"
            >
              Купить
            </a>
            {else}
            <div class="out-of-stock"><strong>[`Out of stock`]</strong></div>
            <div class="blank"></div>
            <arrived-button :id="{$data.product_1.id}"></arrived-button> {/if} {else}
            <span style="font-size:16px;" class=" btn btn-warning"
              >Снят с производства</span
            >
            <div class="blank"></div>
            {assign var=new_products
            value=shopSiteprofoldproductsPlugin::show_new_products($data.product_2.id)}
            {if $new_products}
            <div id="show_new_products_outer_2">
              <div class="label label-success">Рекомендуем новые модели</div>
              <div id="show_new_products_2" class="owl-carousel">
                {foreach from=$new_products item=p}
                <div>
                  <a
                    class="new_prodcut_img"
                    target="_blank"
                    href="{$p.frontend_url}"
                  >
                    {if $p.image_id} {$wa->shop->productImgHtml(['id'=> $p.id,
                    'image_id' => $p.image_id, 'class' => 'img-responsive','ext' =>
                    $p.ext, 'image_desc' => $p.name, 'image_filename' =>
                    $p.image_filename], '300x300', ['alt' => $p.name,'class' =>
                    'img-responsive'])} {else}
                    <img class="img-responsive" src="/images/no-photo.gif" /> {/if}
                  </a>
                  {if $p.price > 0}
                  <p>
                    <span class="price nowrap"
                      >{shop_currency_html($p.price,$p.currency)}</span
                    >
                    {* 
                    if $price_usd =
                    shopSiteprofPriceControlPlugin::show_price_USD($p.price)}
                    <span class="usd_price nowrap">{$price_usd}</span> 
                    *}
                  </p>
                  {else}
                  <p class="out-of-stock"><strong>Нет в наличии</strong></p>
                  {/if}
                  <a
                    class="new_prodcut_name"
                    target="_blank"
                    href="{$p.frontend_url}"
                    >{$p.name}</a
                  >
                </div>
                {/foreach}
              </div>
              <div class="big_blank"></div>
            </div>
            <hr />
            {/if} {/if}
          </td>
        </tr>
      
        {foreach $features as $f}
        <tr>
          <td ><strong>{$f.name}:</strong></td>
          <td style="width:30%;"  colspan="2">
            {if isset($data.product_1.features[$f.code])} {if
            is_array($data.product_1.features[$f.code])} {implode(',
            ',$data.product_1.features[$f.code])} {else}
            {$data.product_1.features[$f.code]} {/if} {else} - {/if}
          </td>
          <td style="width:30%;"> 
            {if isset($data.product_2.features[$f.code])} {if
            is_array($data.product_2.features[$f.code])} {implode(',
            ',$data.product_2.features[$f.code])} {else}
            {$data.product_2.features[$f.code]} {/if} {else} - {/if}
          </td>
        </tr>
        {/foreach}
      </table>
      
  </div>
  <div class="blank"></div>
  {if $products}
  <p class="bold">Другие сравнения:</p>
  {include file="../comparingCollection/productsList.tpl"}
{/if}
</div>
{assign var='current_page' value='comparingItems' scope='global'}
