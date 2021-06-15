{* one review output *}

{if !empty($ajax_append)}<li data-id="{$review.id}" data-parent-id="{$review.parent_id}">{/if}
  <div class="review" itemprop="review" itemscope itemtype="https://schema.org/Review">
    <div class="row">
      <div class="col-xs-12 col-sm-4 col-md-2 col-lg-2">
        <p class="tc">
          {$photo_url = "/wa-apps/shop/themes/flip/img/review_avatar.jpg"}
          {if $review.contact_id}
          {$photo_url = shopSiteprofreviewsPlugin::getPhotoUrl($review.contact_id)}
          {/if}
          <img src="{$photo_url}" class="review_avatar img-responsive" alt="" />
        </p>
        {if $review.author.name}
         <p class="tc review_author_name"><em itemprop="author">{$review.author.name}</em></p>
        {else}
          {* TODO: need replace "flip" for variable *}
         <p class="tc review_author_name"><em itemprop="author">flip</em></p>
        {/if}
      </div>

      <div class="col-xs-12 col-sm-8 col-md-10 col-lg-10">
        <div class="summary">
          
         {if $review.title} <span class="review_title" itemprop="name">{$review.title}</span>{/if}

          <meta itemprop="datePublished" content="{$review.datetime|date_format:'Y-m-d'}" />
          <meta itemprop="itemReviewed" content="{$product.name}"/>

          <div class="review_auto_time">
            {if !$review.parent_id && $review.rate > 0}
            <span itemprop="reviewRating" itemscope itemtype="https://schema.org/Rating">
              {$rate = round($review.rate)}
              <meta itemprop="worstRating" content="1" />
              <meta itemprop="ratingValue" content="{if $rate}{$rate}{else}5{/if}" />
              <meta itemprop="bestRating" content="5" />
              {$wa->shop->ratingHtml($rate)}
            </span>
            {/if}
             {$review.datetime|wa_datetime:"humandatetime"}
            <percent-rating :is-good="{$review.is_good}" :is-bad="{$review.is_bad}"></percent-rating>
          </div>
        </div>
        <div itemprop="description" class="review_description">
          <p>{$review.text}</p>

          {if $review.dignity}
          <p>
            <strong class="label_reviews_dignity">Достоинства:</strong>
            {$review.dignity}
          </p>
          {/if} {if $review.shortcomings}
          <p>
            <strong class="label_reviews_shortcomings">Недостатки:</strong>
            {$review.shortcomings}
          </p>
          {/if}
        </div>
        <div class="actions">
          {if !$review.parent_id}
          <is-useful :parent-id="{$review.id}" :is-good="{$review.is_good}" :is-bad="{$review.is_bad}"></is-useful>
          {/if}
          <show-form-btn :props-parent-id="{$review.id}"></show-form-btn>
        </div>
        <div class="clearfix"></div>
        {if $product.id}
        <review-form  :props-parent-id="{$review.id}" :product-id="{$product.id}"></review-form>
        {/if}
      </div>
    </div>
  </div>
  <ul class="menu-v with-icons reviews-branch">
    <created-review :parent-id="{$review.id}"></created-review>
  </ul>

  {if !empty($ajax_append)}
  <ul class="menu-v with-icons reviews-branch">
  </ul>
</li>
{/if}