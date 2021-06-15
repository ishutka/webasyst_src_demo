<div class="container">
    <h2>Последние отзывы</h2>
    <div  id="index_reviews">
        {foreach $reviews as $r}
        <div class="index_review_item">
            <a href="{$r.product_url}" class="pr-img">
                {if $r.product_url_crop_small}
                <lazy-image src='{$r.product_url_crop_small}' alt='{$r.product_name}'  error="{$wa_theme_url}img/dummy96.png"></lazy-image>
                {/if}
            </a>
            <img src="{$wa_theme_url}img/Quates-Sign.svg" alt="ковычки"/>
            <a class="pr-name text-small" href="{$r.product_url}">
                {$r.product_name}
            </a>
            <strong>{$r.name}</strong>
            <div class="index_review_item_text">
                <p >
                    {mb_substr(strip_tags($r.text),0,158)}...
                </p>
                <div></div>
            </div>
            <a href="{$r.product_url}reviews/" class="heading-link">
                Продолжить чтение >
            </a>
        </div>
        {/foreach}
    </div>
</div>