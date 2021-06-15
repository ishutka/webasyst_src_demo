{assign var='current_page' value='productReviews' scope='global'}
<div itemscope itemtype="http://schema.org/Product"
 class="product_reviews_page col-xs-12 col-md-12 col-md-12 col-lg-12">
	<div class="blank"></div>
	<a href="{$product_url}" class="btn btn-xs btn-default hidden-sm hidden-xs pull-right"><i class="fa fa-long-arrow-left"></i>
		<span {if $reviews_count > 0} itemprop="name" {/if}>{$product.name}</span>
		</a>

	<h1 class="product_page_title">
		{* {if $reviews_count == 0}
		{sprintf('[`%s reviews`]', $product.name|escape)} *}
		{* {else} *}
		{_w('%d review for ','%d reviews for ', $reviews_count)|cat:$product.name|escape}
		{if !empty($product.rating) && $product.rating > 0 && $reviews_count > 0}
		<span class="rating nowrap" itemprop="aggregateRating" itemscope itemtype="http://schema.org/AggregateRating" title="{sprintf('[`Average user rating: %s / 5`]', $product.rating)}">
			{$wa->shop->ratingHtml($product.rating, 16)}
			<span itemprop="ratingValue" style="display: none;">{$product.rating}</span>
			<span itemprop="reviewCount" class="reviews-count" style="display: none;">{$reviews_count}</span>
		</span>
		{/if}
		{* {/if} *}
		
	</h1>
	<hr />
	
		{* Блок для метаданных отзывов и продукта *}
			<!-- Условие ($reviews_count > 0 ) добавлено во избежание подобной ошибки: https://www.flip.com.ua/efirnye-resivery/lorton_t2_19-hd/ 
		(принтскрин http://prntscr.com/n5uep1) -->
		
		{if $reviews_count > 0 && $product.rating <= 0}
			<div  itemprop="aggregateRating"
				itemscope itemtype="http://schema.org/AggregateRating">
				<meta itemprop="ratingValue" content="5" />
				<meta itemprop="reviewCount" content="{$product.reviews_count}" >
			</div>
		{/if}
		<img style="display:none" itemprop="image" src="{$wa->shop->productImgUrl($product, '1200')}"/>
		<div style="display:none" itemprop="description">{$product.description}</div>
        <meta itemprop="sku" content="{$product.sku_id}"/>
		<meta itemprop="name" content="{$product.name}"/>
		<div itemprop="offers" itemscope itemtype="https://schema.org/AggregateOffer">
			<meta itemprop="price" content="{round($product.price)}"/>
			<meta itemprop="lowPrice"  content="{round($product.price)}"/> 
			<meta itemprop="highPrice"  content="{round($product.price)}"/>
			<meta itemprop="offerCount" content="{$product.count}" />
			<meta itemprop="priceCurrency" content="{$product.currency}"/>
			{if (!($product.count === null) and $product.count <= 0)}
				<link itemprop="availability" href="https://schema.org/OutOfStock" />
			{else}
				<link itemprop="availability" href="https://schema.org/InStock" />
			{/if}
		</div>
		{* Конец блока метаданных отзывов и продукта *}
		

	{function review_reviews}
	{$depth=-1}
	{foreach $reviews as $review}
	{if $review.depth < $depth} {$loop=($depth-$review.depth)} {section name="end-review" loop=$loop} <ul class="menu-v with-icons reviews-branch">
		</ul>
		</li>
		</ul>
		{/section}

		{$depth=$review.depth}
		{/if}

		{if $review.depth == $depth}
		</li>
		<li data-id="{$review.id}" data-parent-id="{$review.parent_id}">
			{/if}

			{if $review.depth > $depth}
			<ul class="menu-v with-icons reviews-branch">
				<li data-id={$review.id} data-parent-id="{$review.parent_id}">
					{$depth=$review.depth}
					{/if}
					{include file="../../modules/globals/review/review.tpl" inline reply_allowed=$reply_allowed single_view=true
					review=$review}
					<!-- sub review placeholder -->
					{/foreach}
					{section name="end-review" loop=$depth}
					<ul class="menu-v with-icons reviews-branch"></ul>
				</li>
			</ul>
			{/section}
			{/function}

			<!-- reviews begin -->
			<div class="content page">
				
				<div class="reviews">
					<!-- add review form -->

					{$current_user_id = $wa->userId()}
					<div class="write-review">
						<show-form-btn></show-form-btn>
					</div>
					<review-form :product-id="{$product.id}"></review-form>
					<ul class="menu-v with-icons reviews-branch">
						<li><created-review :parent-id="0"></created-review></li>
						{foreach $reviews as $review}
						<li data-id={$review.id} data-parent-id="0">
							{include file="../../modules/globals/review/review.tpl" inline reply_allowed=$reply_allowed single_view=true
							review=$review}
							{if !empty($review.comments)}
							{review_reviews reviews=$review.comments}
							{else}
							<ul class="menu-v with-icons reviews-branch"></ul>
							{/if}
						</li>
						{/foreach}
					</ul>





				</div> <!-- .reviews -->
				
								

				 <div class="tc">
					{wa_pagination total=$pages_count nb=3 attrs=['class' => "pagination"] prev='<i class="icon-014-left"></i>' next='<i class="icon-015-right"></i>'}
				</div>
				
			</div> <!-- .content .page -->

</div>