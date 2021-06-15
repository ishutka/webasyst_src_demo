<!-- integrnal navigation breadcrumbs -->
{if !isset($breadcrumbs) && $wa->app() === 'blog' }
    {$breadcrumbs = blogBreadcrumbsPlugin::getBreadcrumbs()}
{/if}
<div class="breadcrumb">
    {if isset($breadcrumbs)}
        {if $wa->globals('isMyAccount')}
            {* within My Account we exclude first node from navigation because links are on the page already *}
            {$breadcrumbs[0] = null}
        {/if}
        
            <ul class="container" itemscope itemtype="http://schema.org/BreadcrumbList">
                {if $breadcrumbs}
                    <li itemprop="itemListElement" 
                        itemscope
                        itemtype="http://schema.org/ListItem">
                        <a href="/" itemprop="item">
                            <span itemprop="name">Интернет магазин</span>
                            <meta itemprop="position" content="1" />
                        </a> 
                        <span class="divider"> / </span>
                    </li>
                {/if}
                {foreach $breadcrumbs as $breadcrumb name=breadcrumbs}
                    {if $breadcrumb}
                        <li 
                            itemprop="itemListElement" 
                            itemscope
                            itemtype="http://schema.org/ListItem"
                        >
                            <a href="{$breadcrumb.url}" itemprop="item">
                                <span itemprop="name">{$breadcrumb.name|escape}</span>
                                <meta itemprop="position" content="{$smarty.foreach.breadcrumbs.index + 2}" />
                            </a> 
                            <span class="divider"> / </span>
                        </li>
                    {/if}
                {/foreach}
            </ul>
    {/if}
</div>
