<div class="comment review" itemprop="review" itemscope itemtype="http://schema.org/Review">
	<meta itemprop="datePublished" content="{$comment.datetime|date_format:'Y-m-d'}">
	<meta itemprop="name" content="{$post.title}">
	<div class="row">
		<div class="col-xs-2 col-md-2 col-lg-2 avatar-wrapper">
			<p class="tc">
				 {$photo_url = "/wa-apps/shop/themes/flip/img/review_avatar.jpg"}
				{if $review.contact_id}
				{$photo_url = shopSiteprofreviewsPlugin::getPhotoUrl($review.contact_id)}
				{/if}
				<img src="{$photo_url}" class="review_avatar img-responsive" alt="" />
			</p>

		</div>

		<div class="col-xs-10 col-md-10 col-lg-10">
			<div class="summary">
				{if !$comment.parent && !empty($comment.rate) }
				<span itemprop="reviewRating" itemscope itemtype="http://schema.org/Rating">
					{$rate = round($comment.rate)}
					<meta itemprop="worstRating" content="1">
					<meta itemprop="ratingValue" content="{$comment.rate}">
					<meta itemprop="bestRating" content="5">
					{$wa->shop->ratingHtml($comment.rate)}
				</span>
				{/if}
				<br />

				<div class="review_auto_time">
					от
					<span class="username bold" itemprop="author">{if $comment.name}{$comment.name}{else}{$comment.username}{/if}</span>,
					{$comment.datetime|wa_datetime:"humandatetime"}
				</div>
			</div>

			<div itemprop="description" class="review_description">
				{$comment.text|nl2br}
			</div>

         	<show-form-btn :props-parent-id="{$comment.id}"></show-form-btn>
			

       		<review-form  :props-parent-id="{$comment.id}" :post-id="{$post.id}" comment-link="{$post.comment_link}"></review-form>

		</div>
	</div>

</div>