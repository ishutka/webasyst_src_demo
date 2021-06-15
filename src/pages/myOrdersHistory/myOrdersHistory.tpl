{assign var='current_page' value = 'myOrdersHistory' scope = 'global'}
<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
    <div class="blank"></div>
    <div class="blank"></div>
    {include file="./../../modules/my/left/left.tpl"}
    <div class="col-xs-12 col-sm-9">
        <div class="row">
            <legend>Мои заказы</legend>
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    {if $orders}
                    <tr>
                        <th>Номер</th>
                        <th>Статус</th>
                        <th>Продукты</th>
                        <th>Доставка</th>
                        <th>Оплата</th>
                        <th>Дата</th>
                        <th>Сумма заказа</th>
                        <th>Комментарий</th>
                    </tr>
                    {/if}
            
                    {foreach $orders as $o}
                    <tr id="order-{$o.varchar_id}">
                        <td class="nowrap">
                            <a href="{$o.url}" class="bold">
                                #{$o.varchar_id}
                            </a>
                        </td>
                        <td class="nowrap">
                        {* Цвета немного отличаются от тех что на flip.com.ua, из-за настроек админки *}
                            <span class="nowrap order-status" 
                                style="
                                    {foreach $o.state.style as $name=>$value}
                                        {$name}:{$value};
                                    {/foreach}
                                "
                            >
                                {$o.state.name}
                            </span>
                            
                        </td>
                        <td>
                            {if !empty($o.items)}
                                 {foreach $o.items as $item}
                                    {if $item.type == 'product'}<hr />{/if}
                                        <div{if $item.type == 'service'} class="text-small text-muted"{/if}>
                                            {if $item.type == 'service'}
                                                + 
                                            {/if}
                                            {$item.name} <strong >x {$item.quantity}</strong>
                                        </div>
                                {/foreach}
                            {/if}
                        </td>
                        <td>
                            {if $o.shipping_name}
                            {$o.shipping_name|escape}
                            {else}
                            &nbsp;
                            {/if}
                            {if isset($o.params.shipping_id) && $o.params.shipping_id == 1 }
                            {else}
                            <p>
                                {if isset($o.params['shipping_address.city'])}
                                {$o.params['shipping_address.city']}
                                {/if}
            
                                {if isset($o.params['shipping_address.street'])}
                                {$o.params['shipping_address.street']}
                                {/if}
                            </p>
                            {/if}
                        </td>
                        <td>
                            {if $o.params.payment_name}
                            {$o.params.payment_name|escape}
                            {else}
                            &nbsp;
                            {/if}
                        </td>
                        <td>
                            <span class="gray">{$o.create_datetime|wa_date:'humandate'}</span>
                        </td>
                        <td>
                            {shop_currency_html($o.total,$o.currency,$o.currency)}
                        </td>
                        <td>
                            {$o.comment}
                        </td>
                    </tr>
                    {foreachelse}
                    <tr class="no-border">
                        <td>Список Ваших заказов пуст.</td>
                    </tr>
                    {/foreach}
                </table>
            </div>
            {$wa->globals('isMyAccount', true)}
            
            <!-- plugin hook: 'frontend_my_orders' -->
            {* @event frontend_my_orders.%plugin_id% *}
            {foreach $frontend_my_orders as $_}{$_}{/foreach}
            <div class="block tc paging-nav" data-times="2" data-link-text="[`Load more`]" data-loading-str="[`Loading...`]">
                {wa_pagination total=$pages_count nb=3 attrs=['class' => "pagination"] prev='<i class="icon-014-left"></i>' next='<i class="icon-015-right"></i>'}
            </div>
        </div>
    </div>

    <div class="clear clearfix"></div>
    <div class="blank"></div>
    <div class="blank"></div>
</div>