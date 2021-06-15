{assign var='current_page' value='checkoutError' scope='global'}
<div class="checkout-result error alert alert-danger">
    <h1>[`Error!`]</h1>
    {if !empty($error)}
        <p>{$error}</p>
    {else}
        <p>[`An error occurred while processing your payment.`]</p>
    {/if}
    
    
    
    <!-- plugin hook: 'frontend_checkout' -->
    {* @event frontend_checkout.%plugin_id% *}
    {foreach $frontend_checkout as $_}{$_}{/foreach}    
    
</div>

<p class="back">
    &larr; <a href="{$wa_app_url}" class="btn btn-default">[`Back to the store`]</a>
</p>    

