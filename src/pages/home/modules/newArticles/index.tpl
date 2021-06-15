{$articles_categories = shopSiteprofHomeInfoPlugin::getArticlesData()}

<div class="post-header">
    <h2 class="section-title hidden-sm hidden-xs">Новости</h2>
    <h2 class="section-title visible-sm visible-xs">Новости</h2>
    
    <nav class="">
        <div id="nav-tab">
            {foreach $articles_categories as $category }
                <a class="nav-item hidden-xs hidden-sm" id="nav-{$category.id}-tab" data-toggle="tab" href="#nav-{$category.id}" >{$category.name}</a>
            {/foreach}
            <a href="/articles/" >Смотреть все</a>
        </div>
    </nav>
</div>


<div  id="tab-content">
    {foreach $articles_categories as $category}
        <div class="tab-pane faded" id="nav-{$category.id}" >
            {foreach $category.posts as $n }
                
                    <div class="index_post_item ">
                        <a href="{$n.link}" class='article-img'>
                            <lazy-image src="/wa-data/public/blog/plugins/logopost/images/{$n.image}" alt="{$n.title}" error="{$wa_theme_url}img/Default-NoImage-570x250.jpg"></lazy-image>
                        </a>
                        <div class="categories-links_block">
                            {foreach $n.categories as $c}
                                <a href="{$c.url}" class="categories-links">{$c.name}</a>
                            {/foreach}
                        </div>
                        <a href="{$n.link}" class="item-name">{$n.title}</a>
                        <div class="article-bottom">
                            {if $n.rate_count}
                                <span class="comment-count">Отзывы ({$n.rate_count})</span>
                            {/if}
                            <a href="{$n.link}" class="read-more heading-link">Читать ></a>
                        </div>
                    </div> 
            {/foreach}
        </div>
    {/foreach}
</div>
