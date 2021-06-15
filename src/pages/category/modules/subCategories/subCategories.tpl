{if $category.subcategories && $category.is_hub eq 0}
        <ul class="sub-categories nav nav-pills">
            {foreach $category.subcategories as $sc}
                    <li><a href="{$sc.url}">{$sc.name|escape} ({$sc.count})</a></li>
            {/foreach}
        </ul>
  {/if}
  <!-- plugin hook: 'frontend_category' -->
  {* @event frontend_category.%plugin_id% *}
  {foreach $frontend_category as $_}{$_}{/foreach}

{if $category.is_hub eq 1}
    {if $category.subcategories}
        <table class="hub_sub-categories">
            {foreach $category.subcategories as $sc}
                <tr>

                    {$sc_img = shopCategoryImagesPlugin::getCategoryImageUrl($sc.id)}
                        {if empty($sc_img)}
                            {$sc_img = '/wa-apps/shop/themes/flip/img/no-thumb.png'}
                        {/if}
                    <td >
                        <a href="{$sc.url}">
                            <lazy-image class="img-responsive" src="{$sc_img}" alt="{$sc.name|escape}"></lazy-image>
                        </a>
                    </td>
                    <td>
                        <a href="{$sc.url}"><h4>{$sc.name|escape} ({$sc.count})</h4></a>
                        <p>{$sc.seo_description}</p>
                    </td>
                </tr>
            {/foreach}
        </table>
        <div class="blank"></div>
    {/if}
{/if}
