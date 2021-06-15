{assign var='current_page' value = 'myOrder' scope = 'global'}

<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
    <div class="blank"></div>
    <div class="blank"></div>

    {include file="./../../modules/my/left/left.tpl"}
    <div class="col-xs-12 col-sm-8 ">
        <legend>
			Заказ #{$order.varchar_id}
			<span class="order-status" style="{$order.state->getStyle()}">
				{$order.state->getName()}
			</span>

			<span class="text-muted pull-right">{$order.create_datetime|wa_date:'humandatetime'}</span>
		</legend> 
		<div class="row">
			{* {if empty($tracking)}
				<div class="col-xs-12" id="siteprofQuickOrder" data-order="false">
					{include file="wa-apps/shop/plugins/siteprofQuickOrder/templates/actions/frontend/confirm.html"}
				</div>
			{/if} *}
			<div class="col-xs-12">
				<!-- shipping -->
				<h4>Доставка
					{if $order.shipping_name}
						&mdash; <strong>{$order.shipping_name}</strong>
					{/if}
				</h4>

				<!-- shipping plugin output -->
				{if !empty($order.params.tracking_number)}
					Номер почтовой декларации: <strong>{$order.params.tracking_number}</strong>
					<br />
				{/if}
				{if !empty($tracking) && $order.state->getId() != 'completed'}
					<div class="plugin alert alert-success">
						{$tracking}
					</div>
				{/if}

				<p>
					{$contact.firstname|escape} {$contact.lastname|escape}<br>
					{if isset($order.params.shipping_id) && $order.params.shipping_id == 1 }
					{else}

						<br>
						{if isset($order.params['shipping_address.city'])}
							{$order.params['shipping_address.city']}
						{/if}

						{if isset($order.params['shipping_address.street'])}
							{$order.params['shipping_address.street']}
						{/if}
					{/if}
				</p>

				<!-- billing
				<h4>Оплата
					{if $order.payment_name}
						&mdash; <strong>{$order.payment_name}</strong>
					{/if}
				</h4> -->
				
				<!-- payment plugin output -->
				{if !empty($payment)}
					<h4>Оплата</h4>
					<div class="plugin">
						{$payment}
					</div> 
				{/if}
				
				<p>
					{$contact.firstname|escape} {$contact.lastname|escape}<br>
					{if $billing_address}
						{$billing_address}
					{/if}
				</p>

				{if !empty($order.comment)}
					<h3>Комментарий к заказу</h3>
					<p>
						{$order.comment|escape}<br>
					</p>
				{/if}

				<!-- order content and total -->
				<table class="table">
					<tr>
						<th></th>
						<th class="align-right">Количество</th>
						<th class="align-right">Стоимость
                        </th>
					</tr>
					{foreach $order.items as $item}
						<tr{if $item.type == 'service'} class="text-small text-muted"{/if}>
							<td>{if $item.type == 'service'}+ {/if}{$item.name}
								{if $item.type == 'product' && !empty($item.download_link)}<a href="{$item.download_link}"><strong>[`Download`]</strong></a>{/if}</td>
							<td class="align-right"><span class="gray">{wa_currency_html($item.price, $order.currency)} x</span> {$item.quantity}</td>
							<td class="align-right">{wa_currency_html($item.price * $item.quantity, $order.currency)}</td>
						</tr>
					{/foreach}
					<tr class="no-border thin">
						<td colspan="2" class="align-right">Итого за товары</td>
						<td class="align-right">{wa_currency_html($subtotal, $order.currency)}</td>
					</tr>
					<tr class="no-border thin">
						<td colspan="2" class="align-right">Скидка</td>
						<td class="align-right">&minus; {wa_currency_html($order.discount, $order.currency)}</td>
					</tr>
					<tr class="no-border thin">
						<td colspan="2" class="align-right">
							Доставка
							{if !empty($order.params.shipping_name)}
								(<strong>{$order.params.shipping_name}</strong>)
							{/if}
						</td>
						<td class="align-right">{if $order.shipping > 0}{wa_currency_html($order.shipping, $order.currency)}{/if}</td>
					</tr>
					{if $order.tax > 0}
						<tr class="no-border thin">
							<td colspan="2" class="align-right">Налог</td>
							<td class="align-right">{wa_currency_html($order.tax, $order.currency)}</td>
						</tr>
					{/if}
					<tr class="no-border thin large">
						<td colspan="2" class="align-right"><b>Сумма к оплате</b></td>
						<td class="align-right bold">{wa_currency_html($order.total, $order.currency)}</td>
					</tr>
				</table>
			</div>
		</div>
    </div>
</div>
