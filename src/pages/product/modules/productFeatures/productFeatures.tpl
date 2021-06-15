{if $product.features}
    <div id="product-features">
        <hr />
        <h3>Характеристики {$product.name|escape}</h3>
        <table class="features" >
            {$categories_by_feature_condition = shopSiteprofProductLinksToCategoriesPlugin::getCategoriesByFeatureCondition($product.id)}
            {foreach $product.features as $f_code => $f_value}
                <tr {if $features[$f_code].type == 'divider'} class="divider"{/if}>
                    <td class="name">
                        <strong>{$features[$f_code].name|escape}:</strong>
                    </td>
                    <td class="value" >
                        {if is_array($f_value)}
                            {* implode(', ', $f_value) *}
                            {foreach $f_value as $value name=f_value}
                                {$feature_category_key = $f_code|cat:$value}
                                {if isset($categories_by_feature_condition[$feature_category_key])}
                                    <a target="_blank"  title="{$categories_by_feature_condition[$feature_category_key].name}" href="{$categories_by_feature_condition[$feature_category_key].frontend_url}">{$value}</a>
                                {else}
                                     {$value}
                                {/if}
                                {if !$smarty.foreach.f_value.last},{/if}
                            {/foreach}
                        {else}
                            {$feature_category_key = $f_code|cat:$f_value}
                            {if isset($categories_by_feature_condition[$feature_category_key])}
                                <a target="_blank" title="{$categories_by_feature_condition[$feature_category_key].name}" href="{$categories_by_feature_condition[$feature_category_key].frontend_url}">{$f_value}</a>
                            {else}
                                 {$f_value}
                            {/if}
                        {/if}
                    </td>
                </tr>
            {/foreach}
        </table>
    </div>
{/if}