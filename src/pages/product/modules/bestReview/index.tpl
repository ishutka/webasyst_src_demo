
{if $reviews_total_count > 0}
    {$best_review = shopSiteprofReviewsPlugin::getBestReviewForProductPage($product.id)}
    {if $best_review}
        <div id="best_review" class="reviews col-xs-12">
            <ul class="reviews-branch">
                <li data-id={$best_review.id} data-parent-id="0">
                    {include file="../../../../modules/globals/review/review.tpl" review=$best_review inline reply_allowed=false single_view=true }
                    <ul class="menu-v with-icons reviews-branch"></ul>
                </li>
            </ul>
        </div>
    {/if}
{/if}