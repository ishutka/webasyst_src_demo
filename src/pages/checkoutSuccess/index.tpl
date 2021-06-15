{assign var='current_page' value='checkoutSuccess' scope='global'}

<style>
    .checkout-header { display: none; }
</style>

<div class="checkout-result success">

    <div class="alert alert-success">
        <h3>[`Thank you!`]</h3>
        [`We successfully accepted your order, and will contact you asap.`]<br />
        [`Your order number is `] <strong>#{$order.varchar_id}</strong>.
    </div>
    
    {if !empty($payment)}
        <div class="plugin alert alert-warning">
            {$payment}
        </div>
    {/if}

    {if !empty($payment_success)}
        <div class="highlighted alert alert-success">[`Your payment has been successfully accepted. We will process your order and contact you shortly.`]</div>
    {/if}
    <hr />
    <a class="btn btn-default" href="{$wa_app_url}">[`Back to the store`]</a>
    <hr />
    <!-- plugin hook: 'frontend_checkout' -->
    {* @event frontend_checkout.%plugin_id% *}
    {foreach $frontend_checkout as $_}{$_}{/foreach}    
    
</div>