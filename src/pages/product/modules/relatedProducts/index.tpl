{$products = $product->crossSelling(30)}
{if $products} 
  {include  products=$products related_block_title="С этим товаром покупают:" file="../../../../modules/globals/additionalProductsSet/index.tpl"}
  
{/if}
