<div class="blank"></div>
<div class="blank"></div>
{$title = waRequest::param('query')}
	
<div class="col-xs-12 col-sm-8 col-lg-9 category-name__wp category-name__wp--search">

	{if $title}
		<h1 style="float: left;">
			[`You were looking for`] "{$title}"
		</h1>
	{/if}
	
	{if $products_count > 0}
		<div class="search-result-quantity">
			{$count_last_num=substr($products_count,-1)}
			[`Found`] <b>{$products_count}</b>
			{*условия для вариантов склонения слова:*}
			{if $count_last_num==1}
				товар
			{elseif (4 lt $products_count && $products_count lt 20) || (4 lt $count_last_num && $products_count lte 9) || $count_last_num==0}
				[`products-whoms`]
			{elseif 1 lt $count_last_num && $count_last_num lt 5}
				[`products-whom`]
			{/if}
			{if $is_in_category}
				{$category = $wa->shop->category($category_id)}
				[`in category`]
				<a href="{$wa->shop->categoryUrl($category)}">{$category.name}</a>.
				[`If were not product in category`]
				<a href="{$all_results_url}">
					[`all search results`]
				</a>
			{elseif $categories_count > 1}
			{$cat_count_last_num=substr($products_count,-1)}
				в
				<b>{$categories_count}</b>
				{if $cat_count_last_num==1}[`in categories-1`]{else}[`in categories`]{/if} {*условия для вариантов склонения слова*}
			{/if}
		</div>
		<div class="clearfix"></div>
	{else} 
		<div class="clearfix"></div>
		<div class="alert alert-info">
			<p>[`No results for your request`].</p>
			<p>[`Try changing product selection criteria`].</p>

		</div>
	{/if}
	<div class="row">
		<div class="col-xs-12 side-search-navigation">
			{if ifset($finded_in_categories) && count($finded_in_categories) > 1}
				<div class="search-in-categories">
					<p class='search-navigation__title'>
					[`Categories search results`]
					<i class="icon-016-up"></i>
					</p>
					<div class="search-navigation__results">
						<a href="{$all_results_url}">[`All results`]</a>
						{foreach $finded_in_categories as $category}
							<a title="[`Look search results in`] {$title} [`in category`] {$category.name}"
								{if $category_id == $category.id}
									class="current-category"
								{/if}
								href="{$category.search_url}"
							>
								<b>{$title}</b> [`in category`] <strong>{$category.name}</strong>
							</a>
						{/foreach}
					</div>
				</div>
			{/if}
			{if count($categories)>0}
				<div class="finded-categories">
					<p  class='search-navigation__title'>[`Categories`]<i class="icon-016-up"></i></p>
					<div class="search-navigation__results">
						{foreach $categories as $category}
							<a href="{$category.frontend_url}">{$category.name}</a>
						{/foreach}
					</div>
				</div>
			{/if}
			

			{if count($popular)>0}
				<div class="search-populars">
					<p class='search-navigation__title'>
					{if $products_count>0}[`Related searches`]
					{else} [`Popular searches`]
					{/if}
					<i class="icon-016-up"></i></p>
					<div class="search-navigation__results">
					{foreach $popular as $popular_item}
						<a href="{$popular_item.url}">{$popular_item.name}</a>
					{/foreach}
					</div>
				</div>
			{/if}

			{if count($history)>0}
				<div class="search-history">
					<p class='search-navigation__title'>[`Search history`]<i class="icon-016-up"></i></i></p>
					<div class="search-navigation__results">
						{foreach $history as $history_item}
							<a href="{$history_item.url}">{$history_item.name}</a>
						{/foreach}
					</div>
				</div>
			{/if}

		</div>

		<div class="col-xs-12">
			{if $products_count === 0}
						{* если по запросу продуктов не найдено то отображаются продукты из списка Топ продаж, поэтому отображаю доп. заголовок, что бы пользователю это было понятно *}
						<p  class="you-maybe-interesed">
							[`You may be interested`]:
						</p>
					{/if}
			
			
			<div id="product-list">
			{include file='../../modules/globals/listThumbs/listThumbs.tpl'}
			</div>
		</div>
	</div>
</div>

<div class="hidden-xs col-sm-4 col-lg-3 categoryNews">
	{$news = shopSiteprofcategoriescontentPlugin::getNews()}
	{include file="../../modules/globals/news/news.tpl"}
</div>

{assign var='current_page' value='search' scope='global'}