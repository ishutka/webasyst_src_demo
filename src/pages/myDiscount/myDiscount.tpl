{assign var='current_page' value = 'myDiscount' scope = 'global'}
<div class="col-xs-12">
	<div class="blank"></div>
	<div class="blank"></div>
	
    {include file="./../../modules/my/left/left.tpl"}
	<div class="col-xs-12 col-sm-8 col-lg-9 myDiscount">
		<div class="row">
			<legend>Персональная скидка</legend> 
			{if $contact_category}
			<p>
				<strong>Ваша группа:</strong> <span class="badge">{$contact_category.name}</span>
			</p>
			{else}
			<p>
				К сожалению, на данный момент, у вас нет персональной скидки. 
			</p>

			{/if}
			
			
			{if $contact_category.category_id == 1}
				<p>
					<strong>Вами совершено покупок на сумму:</strong>
					<span class="price">{shop_currency_html($total_sales_sum)}</span>
				</p>
				
			
				<p>
					<strong>Ваша скидка:</strong>
					<span>{$discount}%</span>
				</p>
				
				<div class="big_blank"></div>
				{if $discounts_by_customer_total}
					<legend>Как считается персональная накопительная скидка?</legend>
					<p>Величина скидки зависит от суммы оплаченных заказов.</p>
					{foreach from=$discounts_by_customer_total item=item}
						<p>При сумме заказов от {shop_currency_html($item.sum,'UAH','UAH')} - {round($item.discount,2)}%</p>
					{/foreach}
				{/if}
			{/if}
		</div>
	</div>
	
	<div class="clear clearfix"></div>
	<div class="blank"></div>
	<div class="blank"></div>
</div>