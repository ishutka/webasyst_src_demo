{if $category.video}
{assign var="video" value=","|explode:$category.video}
{$key = array_rand($video)}
 <div class="youtube-iframe__wrapper" v-lazy-container="{ selector: 'iframe' }" >
    <lazy-component class="item_category_video" 
        src="//www.youtube.com/embed/{$video[$key]}" title="Видео по категории <<{$category.name}>>"
        allowfullscreen tag="iframe"
          frameborder="0">
    </lazy-component>
</div>

<hr />
{/if}