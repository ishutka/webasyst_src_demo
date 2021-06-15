<div id="cartFormDouble" class="hidden-xs hidden-sm">
  {if $product.is_old == 0 && $product.count > 0 }
    <cart-form-double
      :init-data='{shopVuedataPlugin::getJsonProductDataForVue($product, $services)}'
      :id="{$product.id}"
    >
    </cart-form-double>
  {/if}
</div>
