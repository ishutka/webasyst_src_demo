<div class="related-products" itemscope itemtype="http://schema.org/ItemList">
    <div class="h3" itemprop="name">{$related_block_title}</div>
    {* Сделала микроразметку для списка продуктов - если нужно будет удалю или перенесу в javascript/JSON *}
    <span itemprop="numberOfItems" style="display: none;">{count($products)}</span>
    <meta itemprop="itemListOrder" content="Unordered"/>
    <div class="owl-carousel">
      {foreach $products as $p}
		<div class="col-xs-6 col-md-12 product-set-item " itemprop="itemListElement" itemscope itemtype="http://schema.org/Product http://schema.org/ListItem">
			<meta itemprop="position" content="{$p@index+1}"/>
			<a href="{$p.frontend_url}"
			target="_blank"
			title="{$p.name}"
			class="image-wrapper ">
			<lazy-image class="image " itemprop="image"
				src="{$wa->shop->productImgUrl($p,'300x300')}" 
				error="{$wa_app_static_url}themes/flip/img/no-photo.gif"
				alt="{$p.name}">
			</lazy-image>
			</a>
			<a href="{$p.frontend_url}" title="{$p.name}"
			target="_blank"
			class="product-name"
			itemprop="url">
			<span itemprop="name">{$p.name}</span>
			</a>
			<div style="margin-top:auto">
				{include file="../rating/rating.html" show_empty_rating_stars="true" reviews_total_count=$p.reviews_count product=$p}
				<span class="reviews-count">({if $p.reviews_count>0}{$p.reviews_count}{else}0{/if})</span>
			</div>
			<div class="bottom-wrapper">
				{if $p.is_old}
					<div class="not-available gray-text">Снят с продаж</div>
				{else if $p.count>0}
					{if count($p.skus)>1}
                      {foreach $p.skus as $sku}{if $sku.price==$p.min_price}{$min_price_sku=$sku}{/if}{/foreach}
                    {else}
                       {$min_price_sku=$p}
                    {/if}
					<span  class="price nowrap{if $min_price_sku.compare_price>0} colorRed{/if}" itemprop="offers" itemscope itemtype="http://schema.org/Offer">
					<meta itemprop="url" content="{$p.frontend_url}">
					<meta itemprop="availability" content="http://schema.org/InStock">
					{if count($p.skus)>1}
						<span class="from">от</span>
					{/if}
					{if $p.currency=='USD'}<span itemprop="priceCurrency" content="USD">$</span>{/if}
					<span itemprop="price">{$min_price_sku.price|string_format:"%.2f"}</span>
					{if $p.currency=='UAH'}<span itemprop="priceCurrency" content="UAH">грн</span>{/if}
					{if $min_price_sku.compare_price>0}
						<span class="compare-at-price nowrap">
						{if $p.currency=='USD'}<span>$</span>{/if}
						{$min_price_sku.compare_price|string_format:"%.2f"} 
						{if $p.currency=='UAH'}<span>грн</span>{/if}
						</span>
					{/if}
					</span>
				{else}
					<div class="not-available blue-text">Ожидается поступление</div>
				{/if}
				<to-compare-button :product-id="{$p.id}"></to-compare-button>
				{if !$p.is_old && $p.count>0}
					{if count($p.skus)==1}
						<add-to-cart-button
						:init-data='{shopVuedataPlugin::getJsonProductDataForVue($p)}'
						:id="{$p.id}">
						</add-to-cart-button>
					{else}
						<a href="{$p.frontend_url}" title="Выбрать" class="choice-sku-button btn-success btn"><i class="icon-001-cart" aria-label="Купить"></i></a>
					{/if}
				{/if}
			</div>
			<div class="clearfix"></div>
		</div>
      {/foreach}
    </div>
  </div>