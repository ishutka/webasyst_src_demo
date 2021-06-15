
<div id="filtersLinks">
{*
{$features = shopSiteproffiltersPlugin::getCategoryFilterFeatures($category)}
<p class="hidden-sm hidden-xs filter-heading">
    <strong>Фильтр товаров</strong>
</p>
{foreach $features as $feature}

    {if isset($feature.values) && $feature.values}
    
        <p class="feature-heading"><i class="fa fa-minus-square-o"></i>{$feature.name}</p>
        <ul>
            
            {foreach $feature.values as $value}
                 {if !mb_strpos($value.url_with,'-or-') && !mb_strpos($value.url_with,'-and-')} 
                    <!-- не отображаю сильно вложенные фильтра -->
                    <li><a href="{$value.url_with}">{$value.value}</a></li>   
                {/if}
            {/foreach}         
        </ul>
        <hr>
    {/if}
{/foreach}
*}
</div>