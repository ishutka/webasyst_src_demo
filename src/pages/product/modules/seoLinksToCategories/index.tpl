{$category_links= shopSiteprofProductLinksToCategoriesPlugin::getNotMainCategories($product.id,$product.category_id) }
{if count($category_links)>0}
    <div class="links-to-categories">
        <span>Этот товар также в других категориях:</span>
        {foreach $category_links as $index=>$c}
            {if $index !==0},{/if}
            <a target="_blank" href="{$c.frontend_url}">{$c.name}</a>
        {/foreach}
    </div>
{/if}