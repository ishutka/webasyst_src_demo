
{if $news}
<p class="news-heading">Наши публикации</p>
    <div id="category_block_news">
        {include file="./video.tpl"}
        {foreach $news as $n}
            {include file="./../postItemTemplate/index.tpl" p=$n}
            <hr/>
        {/foreach}
    </div>
{/if}