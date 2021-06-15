{assign var='current_page' value='category' scope='global'}

<div class="row">
  {*NOTE: custom by siteprof*}
  {*Пришлось добавить проверку на баннер, т.к. иначе я получал на странице Notice*}
  {if isset($category.banner)}
    <div class="categories_banner"><a href="{$category.banner_url}">
      <lazy-image src="/categories_banner/{$category.banner}" alt="{$category.name}"></lazy-image>
    </a></div>
    <br class="hidden-xs hidden-sm">
  {else} <br>
  {/if}
  {if !waRequest::get('products') && $category.is_hub eq 1 && $category.subcategories}
    {include file="./modules/categoryHub/index.tpl"}
	{else}

    {$categories = $wa->shop->categories(($category.depth-1),$category.parent_id)}
    {if !$categories}
      {$categories = $wa->shop->categories(($category.depth),$category.id)}
    {/if}
    {* Задаем переменную(boolean) для объемного условия ,используемого не один раз *}
    {$areAvtokraskafilters = ($category.depth > 1 
          || $category.is_car_brand == 1 
          || $category.is_paint_type == 1 
          || $category.is_color_group == 1
          || $category.parent_id == 780
          || $category.id == 780)}

      <div  class="col-xs-12 col-md-3 filters {if empty($category['filter']) && !$areAvtokraskafilters}visible-xs visible-sm{/if}" >
        <div class="category-filters__wrapper">
          <div id="categoryFilters" class="category-filters{if !$category.params.enable_sorting && empty($category['filter'])} hidden-xs{/if}">
            {if !empty($category['filter'])}
            <filters  
              :category-id="{$category.id}" 
              category-name="{$category.name}" 
            ></filters>
            {include file="./modules/filtersLinks/index.tpl"}
            {/if}
          </div>
        </div>
        {if !empty($category['filter']) || $areAvtokraskafilters} 
          <div class="hidden-sm hidden-xs categoryNews">
            {* 
              TODO: productDay
              {shopProductdayPlugin::display($category.id,'category')}
            *}
            {$news = shopSiteprofcategoriescontentPlugin::getArticles($category.id)}
            {if count($news) == 0}
              {$news = shopSiteprofcategoriescontentPlugin::getNews()}
            {/if}
            
            {include file="../../modules/globals/news/news.tpl"}
            {* {include file="./modules/articles/articles.tpl"} Пока закоментировала,так как не предполагается наличие этого блока в новом дизайне*}

          </div>

          {if $areAvtokraskafilters}				
            {* {include file="./modules/categoryAvtokraskaFilters/index.tpl"} *}
          {/if}
        {/if}

        <div class="clearfix"></div>
      </div>

      <div class="col-xs-12 col-md-9 category-name__wp">
        <h1 data-cy="filters-page-heading">        
          {$category.name|escape}
          {shopSiteproffiltersSeo::getCategoryH1Addition()}
        </h1>

        {if !shopSiteproffiltersSeo::getCategoryH1Addition() && $category.seo_description && !waRequest::get('page')}
          <div class="category_description">{$category.seo_description}</div>
        {/if}

        {* 
        TODO: productDay
        <div id="shopProductdayForMobile"></div> 
          {if waRequest::isMobile()}
            {shopProductdayPlugin::display($category.id,'category')}
          {/if}
        *}

        {if  $category.is_hub ne 1}
          {include file="./modules/subCategories/subCategories.tpl"}
        {/if}
        <div id="product-list">
            {include file='../../modules/globals/listThumbs/listThumbs.tpl' sorting=!empty($category.params.enable_sorting)}
        </div>
      </div> 
      {if empty($category['filter']) && !$areAvtokraskafilters}
        <div  class="col-md-3  hidden-xs hidden-sm  categoryNews-down">
          {* 
            TODO: productDay
            {shopProductdayPlugin::display($category.id,'category')}
          *}
          {$news = shopSiteprofcategoriescontentPlugin::getArticles($category.id)}
          {if count($news) == 0}
            {$news = shopSiteprofcategoriescontentPlugin::getNews()}
          {/if}
          
          {include file="../../modules/globals/news/news.tpl"}
          {* {include file="./modules/articles/articles.tpl"} Пока закоментировала,так как не предполагается наличие этого блока в новом дизайне*}

        </div>
      {/if}
      <div class="clearfix"></div>
        {if !shopSiteprofSeoTextPlugin::getText()}
          {if  !shopSiteproffiltersSeo::getCategoryH1Addition() && 
              (
                !$category.seo_description 
                && !waRequest::get('page')
              )
            }
              <div class="col-xs-12">{$category.description}</div>
          {/if}
        {/if}
      <div class="category_description_2 col-xs-12"></div>
  {/if}
</div>

