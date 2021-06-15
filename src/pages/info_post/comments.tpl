<section class="comments reviews-branch " itemscope itemtype="http://schema.org/UserComments">
	<div class="write-review">
		<show-form-btn></show-form-btn>
	</div>
	 
	<review-form comment-link="{$post.comment_link}" :post-id="{$post.id}"></review-form> 
	


    <div itemprop="aggregateRating" itemscope itemtype="http://schema.org/AggregateRating" style="display:none;">
		{$filtered_reviews=[]}
		{foreach $post.comments as $comment}
		{if $comment.depth==0}{array_push($filtered_reviews,$comment)}{/if}
		{/foreach}
        <span itemprop="ratingValue">{if $post.rate=='0.0' && count($filtered_reviews)>0}5{else}{$post.rate}{/if}</span>
        <span itemprop="reviewCount">{count($filtered_reviews)}</span>{* TODO: проверить как правильно отображать отзывы  *}
    </div>
    <a name="comments"></a>
    {$post.comment_count = 0}
    {foreach $post.comments as $comment}
    {if $comment.status = "approved"}
    {$post.comment_count = 1}
    {/if}
    {/foreach}
    {if $post.comment_count == 0}
    <ul>
        <!-- placeholder for new comments -->
    </ul>
    {/if}

    {$depth=-1}
    {foreach $post.comments as $comment}
    {if $comment.status == "approved"}

    {if $comment.depth < $depth} {$loop=$depth-$comment.depth} {section name="end-comment" loop=$loop} </li> </ul> {/section}
        {$depth=$comment.depth} {/if} {if $comment.depth==$depth} </li> <li id="comment{$comment.id}">
        {/if}
        {if $comment.depth > $depth}

        <ul>
            <li id="comment{$comment.id}">
                {$depth=$comment.depth}
                {/if}

                {include file="./comment.tpl" inline}
                {* sub comment *}
                {/if}
                {/foreach}
                {section name="end-comment" loop=$depth }

            </li>
        </ul>
        {/section}
        </li>
        </ul>

	
</section>


<!-- 
    TODO: форма добавления комментария
    <section class="comment-form" id="comment-form">
	<div class="well">
		<a name="comment0"></a>
		<form action="{$post.comment_link}" id="form_add_comment_to_blog" class="form-horizontal" method="post">
			<div class="alert" style="display:none;"></div>
			{$current_user_id=$wa->userId()}
			<div class="comment-form-fields">

				<div class="form-group" id="review_form_rate">
					<label class="col-xs-5 col-sm-5 col-md-5 col-lg-3 control-label">Оценка статьи</label>
					<div class="col-xs-7 col-sm-7 col-md-7 col-lg-9">
						<a href="#" class="no-underline rate" data-rate="5" id="review-rate">
							{for $i = 1 to 5}<i class="icon16 star-empty"></i>{/for}
						</a>
						<a href="javascript:void(0);" class="inline-link rate-clear" id="clear-review-rate" style="display: none;">
							<b><i>[`clear`]</i></b>
						</a>
					</div>
				</div>

				{if empty($current_user_id)}
					<div class="form-group">
						<div id="user-auth-provider" class="tab clear-left" data-provider="guest" {if $current_auth_source}style="display:none"{/if}>
							<label class="col-xs-5 col-sm-5 col-md-5 col-lg-3 control-label" for="comment_name">[`Your name`]</label>
							<div class="col-xs-7 col-sm-7 col-md-7 col-lg-9">
								<input class="form-control" type="text" name="username" id="comment_name" value="">
							</div>
						</div>
					</div>
				{else}
					<div class="form-group">
						<label class="col-xs-5 col-sm-5 col-md-5 col-lg-3 control-label">[`Your name`]</label>
						<div class="col-xs-7 col-sm-7 col-md-7 col-lg-9"> 
							<p class="form-control-static">
								<img src="{$wa->user()->getPhoto(20)}" class="userpic" alt="">  
								<strong>{$wa->user('name')}</strong> 
								<a href="{$wa_app_url}logout">[`log out`]</a>
							</p>
						</div>
					</div>
				{/if}

					<div class="form-group">
						<label  for="comment_text" class="col-xs-5 col-sm-5 col-md-5 col-lg-3 control-label">[`Comment`]</label>
						<div class="col-xs-7 col-sm-7 col-md-7 col-lg-9"> 
							<textarea id="comment_text" class="form-control" name="text" rows="5"></textarea>
						</div>
					</div>
					
					{if $request_captcha && empty($current_user_id)}
						<div class="form-group">
							<label  for="comment_text" class="col-xs-5 col-sm-5 col-md-5 col-lg-3 control-label"></label>
							<div class="col-xs-7 col-sm-7 col-md-7 col-lg-9"> 	
								{$wa->captcha()}
							</div>
						</div>
					{/if}
						
					<div class="form-group">
						<label  class="col-xs-5 col-sm-5 col-md-5 col-lg-3 control-label">
						</label>
						<div class="col-xs-7 col-sm-7 col-md-7 col-lg-9"> 
							<input type="hidden" name="auth_provider" value="{$current_auth_source|default:blogCommentModel::AUTH_GUEST}">
							<input type="hidden" name="parent" value="0">
							<input type="hidden" name="id" value="{$post.id}">
							<input type="submit" class="btn btn-primary" data-loading-text="Данные отправляются..." value="Отправить">
							<img src="{$wa_static_url}wa-content/img/loading16.gif" style="display: none;" alt="">
						</div>
					</div>
			</div>
		</form>
	</div>
</section> -->