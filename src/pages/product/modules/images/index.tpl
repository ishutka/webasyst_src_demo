<div class="image easyzoom easyzoom--adjacent" id="product-core-image">
    <div class="corner top right">
        {$badge = $wa->shop->badgeHtml($product.badge)}
        {if $product.free_shipping == 1 && $product.currency == 'UAH'}
        <div class="icon icon_free_shipping"></div>
        {else}
        {$badge}
        {/if}
    </div>
    {if $product.images || $product.image}
        <a 
            title="{$product.name|escape}" 
            rel="product_images" 
            href="{$wa->shop->productImgUrl($product, '1200')}">

            {$wa->shop->productImgHtml($product, '500', [ 'itemprop' => 'image', 'id' => 'product-image', 'class' =>
            'img-responsive', 'alt' => $product.name|escape|cat:' фото' ])}
            
        </a>
    {else}
        <img class="img-responsive default-photo" id="product-image"  src="{$wa_theme_url}/img/dummy200.png" alt="{$product.name|escape}"/>
    {/if}
</div><!-- #product-core-image -->

{if $product.images && count($product.images) > 1}

<div id="product-gallery" class="owl-theme slider multiple-items">
    {foreach $product.images as $image}
    <div class="image">
        <div class="product_image_arrow"></div>
        <img 
            class="owl-lazy img-responsive" 
            data-src="{$wa->shop->productImgUrl(
                [
                    'id'=> $product.id, 
                    'image_id' => $image.id, 
                    'ext' => $image.ext
                ],
                '100x100'
            )}" 
            title="{$image.description}"
            alt="{$product.name} {$image.description|escape}"
            data-href="{$wa->shop->productImgUrl(
                    [
                        'id'=> $product.id, 
                        'image_id' => $image.id, 
                        'ext' => $image.ext
                    ],
                    '1200'
                )}" 
        />
         {if $image.id !=$product.image_id}
        <a 
           
            rel="product_images"
            class="hide"
            href="{$wa->shop->productImgUrl(
                    [
                        'id'=> $product.id, 
                        'image_id' => $image.id, 
                        'ext' => $image.ext
                    ],
                    '1200x1200'
            )}"></a>
            {/if}

    </div>
    {/foreach}
</div><!-- #product-gallery -->
{elseif $product.image}
<div id="product-gallery" class="slider multiple-items product-gallery_one owl-wrapper-outer" style="display:none;">
    <div class="image ">
        <div class="product_image_arrow"></div>
        <a title="{$product.name}" class="fancybox" id="product-image-{$product.image_id}" href="#">
            {$wa->shop->productImgHtml($product, '100x100', [ 'itemprop' => 'image', 'id' => 'product-image', 'class'
            => 'img-responsive', 'alt' => $product.name|escape|cat:' фото' ])}
        </a>
    </div>
</div><!-- #product-gallery -->
{/if}