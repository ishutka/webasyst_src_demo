{$product2articles = shopSiteprofcategoriescontentPlugin::getProductArticles($product.id)}
{$productsSets = shopProductsetsPlugin::buildSet($product)}
{$review_total_count = $product.reviews_count}
{$reviews_total_count = $product.reviews_count}
{$product = shopSiteprofProductsAddedFieldsPlugin::updateProduct($product)}
{$sku = $product.skus[$product.sku_id]}
{$product_available = $product.status and $sku.available and ($sku.count === null || $sku.count > 0)}
{*$wa->shop->settings('ignore_stock_count') || *}
{$badge = $wa->shop->badgeHtml($product.badge)}
<br/>
<div itemscope itemtype="http://schema.org/Product">
  <div data-spy="scroll" data-target="#product_navigation" id="product_page" class="col-xs-12 col-md-12 col-md-12 col-lg-12">

    <div class="row">

      <div id="product_image_column" class="col-xs-12 col-md-5 col-lg-4">
          <div id="scrollLeftInner">
            {include file="./modules/images/index.tpl"}

            <div class="blank"></div>

            <div class="scroll-y-wrapp">
                {include file="./modules/cartFormDouble/index.tpl"}
              
                {include file="./modules/productNavigation/productNavigation.html"}
            </div>
          </div>
          <div class="clearfix"></div>
      </div>

      <div id="product_base_info_column" class="col-xs-12 col-sm-12 col-md-7 col-lg-8">
        <div class="row">
          {include file="./modules/productPageTitle/productPageTitle.html"}
          <div class="col-xs-12 col-sm-6">
            <div class="row">
              <div class="col-xs-6 col-sm-6 col-md-12">
                {include file="../../modules/globals/rating/rating.html"}
                {include file="./modules/smallProductReviews/smallProductReviews.html"}
              </div>
              <div class="col-xs-6 col-sm-6 hidden-md hidden-lg">
                {include file="./modules/productPageShareBlock/index.tpl"}
              </div>
            </div>
            {include file="./modules/isOld/isOld.html"}
            <div class="blank visible-xs"></div>
          </div>
          <div class="col-xs-12 col-sm-6 tr hidden-xs hidden-sm">
            {include file="./modules/productPageShareBlock/index.tpl"}
          </div>
          <div class="blank visible-xs"></div>
          <div class="clearfix"></div>
          {include file="./modules/showNewProducts/showNewProducts.html"}
          {$sku = $product.skus[$product.sku_id]}
          {$product_available = $product.status and $sku.available and ($sku.count === null || $sku.count > 0)}
          {*$wa->shop->settings('ignore_stock_count') || *}
          {if $product.is_old eq '0'}
          <div class="col-xs-12 col-lg-6">
            {include file="./modules/cartForm/index.tpl"}
            <div class="blank"></div>
            {include file="./modules/productsByFeatures/productsByFeatures.html"}
            <div class="blank"></div>
          </div>
          {/if}
          <div class="col-xs-12 col-lg-6">
            {include file="./modules/productPageShipping/index.tpl"}
          </div>
            {include file="./modules/bestReview/index.tpl"}
          <div id="product_navigation_content" class="col-xs-12">
            {include file="./modules/productsSets/productsSets.html"}
            {include file="./modules/video/index.tpl"}
            {include file="./modules/productDescription/productDescription.html"}
            {include file="./modules/productFeatures/productFeatures.tpl"}
            {include file="./modules/productComplectation/index.tpl"}
            {include file="./modules/reviews/index.tpl"}
            {include file="./modules/product2articles/product2articles.html"}
            {include file="./modules/relatedProducts/index.tpl"}
            {include file="./modules/seoLinksToCategories/index.tpl"}
          </div>
        </div>
      </div>
    </div>
  </div>
</div>


{assign var='current_page' value='product' scope='global'}