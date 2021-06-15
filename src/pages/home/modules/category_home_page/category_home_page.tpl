{$categories = shopSiteprofhomecategoriesPlugin::getCategoriesHomePage()}
<h1 class="col-xs-12">Все для автомаляра. Интернет магазин расходных материалов и инструмента.</h1>
<div  class="d-flex">
    {foreach $categories as $c key=k}
        <div class="col-xs-4 col-sm-6 col-lg-4 {if $k>5}hide-category{/if}" {if $categories|count%3 && $k eq ($categories|count-1)}id="last-home-category-item"{/if}>
            <div class="category-item-wrapp">
                <a href="{$c.frontend_url}">
                    <lazy-image  error="{$wa_theme_url}img/dummy96.png" src="/wa-data/public/shop/categories/{$c.id}/{$c.img_id}.jpg" alt="{$c.name}"></lazy-image>
                </a> 
                <div class="root_cat_desc">
                    <h2 class="box-title">
                        <a href="{$c.frontend_url}">{$c.name}</a>
                    </h2>
                    <div class="sub-cat-list">
                        {$subcats=shopSiteprofhomecategoriesPlugin::getSubCategories($c.id)}
                        {foreach $subcats as $sc}
                            <a href="{$sc.frontend_url}">{$sc.name}</a>
                        {/foreach}
                    </div>
                    <a href="{$c.frontend_url}" class="read-more">Больше <i class="icon-015-right"></i></a>
                </div>
            </div>
        </div>
    {/foreach}
</div>