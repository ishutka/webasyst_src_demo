{$tags = blogTagPlugin::getTagsByPost($post)}

{if $tags}
<div class="tags">
    Теги:
    {foreach $tags as $tag}
    <a class="badge" href="{$tag.link}" style="font-size: {$tag.size}%; opacity: {$tag.opacity};">{$tag.name}</a>
    {/foreach}
</div>
{/if}