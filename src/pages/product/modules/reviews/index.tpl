{$reviews = shopSiteprofReviewsPlugin::getReviewsForProductPage($product.id)}

{function review_reviews}
    {$depth=-1}
    {foreach $reviews as $review}
        {if $review.depth < $depth}

        {$loop=($depth-$review.depth)}
        {section name="end-review" loop=$loop}
            <ul class="menu-v with-icons reviews-branch"></ul>
            </li>
            </ul>
        {/section}

        {$depth=$review.depth}
        {/if}

        {if $review.depth == $depth}
        </li>
        <li data-id="{$review.id}" data-parent-id="{$review.parent_id}">
        {/if}

        {if $review.depth > $depth}
        <ul class="menu-v with-icons reviews-branch">
            <li data-id={$review.id} data-parent-id="{$review.parent_id}">
            {$depth=$review.depth}
        {/if}

         {include file="../../../../modules/globals/review/review.tpl" inline reply_allowed=true single_view=true review=$review }
        <!-- sub review placeholder -->
    {/foreach}

    {section name="end-review" loop=$depth}
            <ul class="menu-v with-icons reviews-branch"></ul>
            </li>
        </ul>
    {/section}
{/function}
<div id="product-reviews" class="reviews">
        <hr />
        <h3>Последние отзывы о {$product.name|escape}</h3>
        <ul class="reviews-branch">
            {$count_reviews = 0}
            {foreach $reviews as $k=>$review}
                {$count_reviews=$count_reviews+1}
                {if $count_reviews < 3}
                <li data-id={$review.id} data-parent-id="0">
                    {include file="../../../../modules/globals/review/review.tpl" inline}
                    {if !empty($review.comments)}
                        {review_reviews reviews=$review.comments}
                    {else}
                        <ul class="menu-v with-icons reviews-branch"></ul>
                    {/if}
                </li>
                {/if}
            {/foreach}
            <li>
                <created-review :parent-id="0"></created-review>
            </li>

        </ul>
        <review-form  :product-id="{$product.id}"></review-form>
        <p class="tr">
            {if !$reviews}
                <show-form-btn></show-form-btn>
            {else}
                {$all_reviews_text = sprintf ('Читать все <span class="reviews-count">(%s)</span> отзывы',$reviews_total_count)}
                <show-form-btn ></show-form-btn>

                {if $reviews_total_count > 2}

                    {sprintf('<a href="%s" class="btn btn-orange">Читать все (<strong class="reviews-count">%s</strong>) отзывы</a>','reviews/',$reviews_total_count)}
                {/if}

                {* sprintf(_w(
                        'Read <a href="%s" class="btn btn-primary">all %d review</a> on %s',
                        'Read <a href="%s" class="btn btn-orange">all %d reviews</a> on %s',
                        $reviews_total_count, false
                    ), 'reviews/', $reviews_total_count, $product.name|escape)
                *}
            {/if}
        </p>
    </div>
   