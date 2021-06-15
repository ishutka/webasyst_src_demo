
{if $wa->photos} {$photos =
    $wa->photos->photos('album/5','500x0,1400x0')}
    {if $photos}
        <div id="home_slider" class="owl-carousel">
            {foreach $photos as $key=>$photo}
                <div>
                    <a href="{$photo.description}">
                    <img 
                        {if $wa->isMobile()} 
                        data-src="{$photo.thumb_500x0.url}" 
                        {else} 
                            data-src="{$photo.thumb_1400x0.url}" 
                        {/if}
                        alt="{$photo.name}"
                        class="owl-lazy img-responsive" 
                    />
                    </a>
                </div>
            {/foreach}
        </div>
    {/if} 
{/if}
{$gray_back=false} {* переменная для отображения фона в зависимости от расположения блоков*}
<!-- plugin hook: 'frontend_homepage' -->
{* @event frontend_homepage.%plugin_id% *} {foreach $frontend_homepage as $_}{$_}{/foreach}

<div id="homecategories_plugin" class="container">
  <div class="d-flex">
    {include file='./modules/category_home_page/category_home_page.tpl'}
  </div>
</div>
<div id="homecategories_blog_plugin" >
  {$reviews = shopSiteprofHomeInfoPlugin::getReviews()}
  {if $reviews}
  {$gray_back=true}
  <div  class="home-reviews-wrapper" {if $gray_back }style="background: #f5f5f5"{/if}>
    {include file="./modules/reviews/reviews.tpl"}
  </div>
  {/if}
  <div class="home-articles-wrapper" {if !$gray_back }style="background: #f5f5f5"{/if}>
    <div  class="container">
      {include file='./modules/newArticles/index.tpl'}
    </div>
  </div>
</div>

{assign var='current_page' value='home' scope='global'}