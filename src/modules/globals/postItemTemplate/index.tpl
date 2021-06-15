<div class="index_post_item" id="index_post_item_{$p.id}">
    <a href="{$p.link}" class='article-img'>
        <lazy-image src="/wa-data/public/blog/plugins/logopost/images/{$p.image}" alt="{$p.title}" error="/wa-apps/shop/themes/flip/img/dummy200.png"></lazy-image>
    </a>
    <div class="categories-links_block">
        {foreach $p.categories as $c}
            <a href="{$c.url}" class="categories-links">{$c.name}</a>
        {/foreach}
    </div>
    <a href="{$p.link}" class="item-name">{$p.title}</a>
</div> 