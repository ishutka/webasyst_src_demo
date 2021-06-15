<div class="categoryHub">
        
    <h1>
      {$category.name|escape}
    </h1>
 
  <div class="categoryHubSubcategories">
    {foreach $category.subcategories as $sc}
      {if  $sc.is_car_brand eq 0 && $sc.is_paint_type eq 0 && $sc.is_color_group eq 0 && $sc.is_color_code eq 0} 
        <div class="col-xs-12 col-sm-6 col-md-3">
          {$sc_img = shopCategoryImagesPlugin::getCategoryImageUrl($sc.id)}			
          {if empty($sc_img)}
            {$sc_img = '/wa-apps/shop/themes/flip/img/no-thumb.png'}
          {/if}
          <a href="{$sc.url}">
            <lazy-image class="img-responsive" src="{$sc_img}" alt="{$sc.name|escape}"></lazy-image>
            <h4>{$sc.name|escape} ({$sc.count})</h4>
          </a>
          <div class="muted-text">{$sc.description}</div>
        </div>
      {/if}
    {/foreach}
  </div>
  
  <div class="categoryHubArticles">
    {$articles = shopSiteprofcategoriescontentPlugin::getArticles($category.id)}
    {foreach $articles as $post}
      <div class="categoryHubArticle col-xs-6 col-sm-6 col-md-3">
        <a href="{$post.link}">
          {$img = blogLogopostPlugin::getImgUrl($post.id)}
          {if $img}
            <lazy-image src="{$img}" class="img-responsive" alt="{$post.title|escape}" ></lazy-image>
          {/if}
          <span class="post_title">{$post.title|escape}</span>
          {* <span class="post_title_bg"></span> *}
        </a>
      </div>
    {/foreach}
  </div>
  <!-- <div class="clear clearfix"></div> -->
  <hr />
  {*if $category.id == "780"  Автомобильные краски 
    {include file="./components/categoryHubSections.html"}
  *}
  
  <div class="col-xs-12">
    <div class="well_flip category_description_2">
      {$category.description}
    </div>	
  </div>
  
  <div class="col-xs-12" id="list-thumbs-categoryHub">
    {include file='./components/list-thumbs-categoryHub.html' sorting=!empty($category.params.enable_sorting)}
  </div>
  <div class="clear clearfix"></div>

</div>
<script>	
    var categories_cars = [
      {foreach $category.subcategories as $sc}
        {if  $sc.is_car_brand eq 1}
          {$sc.name = str_replace('Автокраски ','',$sc.name)}
          {$arr = array()}
          {$arr.id = $sc.id}
          {$arr.name = $sc.name}
          {$arr.full_url = $sc.full_url}
          {$arr.count = $sc.count}
          {$arr.favorite = $sc.favorite}
          
          {json_encode($arr)},
        {/if}
      {/foreach}
    ];
    </script>