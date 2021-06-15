{if isset($canonical) && $canonical}
{assign var='share_url' value=$canonical}
{else}
{assign var='share_url' value="https://{$smarty.server.HTTP_HOST}{$wa->shop->productUrl($product)}"}
{/if}
{include file="../../../../modules/globals/shareBlock/shareBlock.html"}