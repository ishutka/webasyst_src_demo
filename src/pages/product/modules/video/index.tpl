{if $product.video}
    <div id="product-video">
        <hr />
        <h3>Видео-обзор {$product.name|escape}</h3>
        <div id="product-video-iframe" v-lazy-container="{ selector: 'iframe' }">
            {$product.video=explode('|',$product.video)}
            {foreach $product.video as $video}
                <lazy-component tag="iframe" src="//www.youtube.com/embed/{$video}"
                    frameborder="0" allowfullscreen></lazy-component>
            {/foreach}
        </div>
        {if $product.video_text}
            <p>{$product.video_text}</p>
        {/if}
    </div>
{/if}