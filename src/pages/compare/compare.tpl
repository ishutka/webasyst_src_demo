{assign var='current_page' value='compare' scope='global'}
<div class="container-fluid">
	<div class="white_bg">	
		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
			{$wa->title('[`Compare products`]')}
			<h1 class="page_title">[`Compare products`]</h1>

		
			{if count($products)}
				
				{$td_width = round((100-25)/count($products))}
				<div class="table-responsive">
					<table id="compare-table" class="compare table table-striped table-hover">
						<tr>
							<th>    
							
							</th>
							{foreach $products as $p}
							 <td width="{$td_width}%"> 
							 	<p>
									<a href="{$p.frontend_url}" class="no-underline">
										{$wa->shop->productImgHtml($p, '96x96', ['itemprop' => 'image', 'id' => 'product-image', 'default' => "`$wa_theme_url`img/dummy96.png", 'title' => $p.name|cat:' ':strip_tags($p.summary)|escape])}
									</a>
								</p>
							 	<a href="{$p.frontend_url}" class="no-underline">
									{$p.name}
								</a>
								<delete-button :product-id="{$p.id}"></delete-button>
							 </td>
								
							{/foreach}
						</tr>
						<tr>
							<th>[`Price`]</th>
							{foreach $products as $p}
								<td width="{$td_width}%" class="product_{$p.id}">
									<item-price :id="{$p.id}"  :init-data='{shopVuedataPlugin::getJsonProductDataForVue($p)}'/>
								</td>
							{/foreach}
						</tr>
						{foreach $features as $f_id=>$f}
						<tr {if $f.same} class="same"{/if}>
							<th >{$f.name}</th>
							{foreach $products as $p}
								<td class="product_{$p.id}">
								{if isset($p.features[$f_id])}
									{if is_array($p.features[$f_id])}
										{implode(', ', $p.features[$f_id])}
									{else}
										{$p.features[$f_id]}
									{/if}
								{else}
									<span class="gray">&mdash;</span>
								{/if}
								</td>
							{/foreach}
						</tr>
						{/foreach}
					</table>
				</div>
				
			{else}

				<div class="tc alert-warning alert">[`Product comparison list is empty.`]</div>

			{/if}
		</div>
		<div class="clearfix"></div>
	</div>
</div>
