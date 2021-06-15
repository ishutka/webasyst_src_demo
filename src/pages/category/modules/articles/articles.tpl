{$articles = shopSiteprofcategoriescontentPlugin::getArticles($category.id)}
{if $articles}
    <div id="category_articles" class="well">
        <p><strong>Статьи</strong></p>
        {foreach $articles as $a name=artices_foreach }
            {if $smarty.foreach.artices_foreach.index > 0}
            <hr />
            {/if}
            <div class="category_article_item">
                <a class="category_article_title" href={$a['link']}>{$a['title']}</a>
            </div>
        {/foreach}
    </div>
{/if}
