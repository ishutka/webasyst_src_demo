{assign var='current_page' value='info_post' scope='global'}
<div id="infopost-page" class="row">
    <div class="col-xs-12">
        <div itemscope itemtype="https://schema.org/BlogPosting">
            <article class="post" role="main" id="post-{$post.id}">
                <div class="hidden-xs">
                    <h1 itemprop="name">
                        {$post.title}
                         {* @event prepare_posts_frontend.%plugin_id%.post_title *}
                        {if !empty($post.plugins.post_title)}
                            {foreach $post.plugins.post_title as $plugin => $output}{$output}{/foreach}
                        {/if}
                    </h1>
                    <div class="tc date-and-category">
                        <span title="{$post.datetime|date_format:'Y-m-d\ H:i'}">
                            {$post.datetime|wa_date:'humandate'}
                        </span>
                        / <a href="{$post.categories[0].url}">{$post.categories[0].name}</a>
                    </div>
                </div>
                
                {* @event prepare_posts_frontend.%plugin_id%.before *}
                {if !empty($post.plugins.before)}
                    <div class="text_before">
                        {foreach $post.plugins.before as $plugin => $output}{$output}{/foreach}
                    </div>
                {/if}
                <div class="credentials">
                    <meta itemprop="datePublished" content="{$post.datetime|date_format:'Y-m-d\TH:i'}">
                    <meta itemprop="dateModified" content="{$post.datetime|date_format:'Y-m-d\TH:i'}">
                    <meta itemprop="headline" content="{$post.title}">
                </div>
                {$img_url = blogLogopostPlugin::getImgUrl($post.id)}
                {if $img_url}
                    <div itemprop="image" itemscope itemtype="https://schema.org/ImageObject">
                        <img itemprop="url" src="{$img_url}" itemprop="image" style="width:100%" alt="{$post.title}" />
                        <meta itemprop="width" content="150">
                        <meta itemprop="height" content="150">
                    </div>
                {/if}
                <div class="visible-xs">
                    <h1 itemprop="name">
                        {$post.title}
                         {* @event prepare_posts_frontend.%plugin_id%.post_title *}
                        {if !empty($post.plugins.post_title)}
                            {foreach $post.plugins.post_title as $plugin => $output}{$output}{/foreach}
                        {/if}
                    </h1>
                    <div class="tc date-and-category">
                        <span title="{$post.datetime|date_format:'Y-m-d\ H:i'}">
                            {$post.datetime|wa_date:'humandate'}
                        </span>
                        / <a href="{$post.categories[0].url}">{$post.categories[0].name}</a>
                    </div>
                </div>
                <div class="text" itemprop="articleBody">
                    {$post.text}
                </div>
            </article>

            <div itemprop="author" itemscope itemtype="https://schema.org/Organization" style="display: none;">
                <span itemprop="name">flip.com.ua</span>
                <div itemprop="address" itemscope itemtype="https://schema.org/PostalAddress">
                    <span itemprop="streetAddress">проспект Степана Бандеры (Московский проспект), 10-б, офис 4-8,
                        (метро
                        «Петровка»).</span>
                    <span itemprop="addressLocality">Киев, Украина</span>
                </div>
                <span itemprop="telephone">+38 (800) 21-00-37</span>,
                <span itemprop="email">flip@flip.com.ua</span>
                <span itemprop="logo" itemscope itemtype="https://schema.org/ImageObject">
                    <img itemprop="url" src="/wa-apps/blog/themes/flip/img/logo.png" />
                    <meta itemprop="width" content="180">
                    <meta itemprop="height" content="54">
                </span>
            </div>

            <div itemprop="publisher" itemscope itemtype="https://schema.org/Organization" style="display: none;">
                <span itemprop="name">flip.com.ua</span>
                <div itemprop="address" itemscope itemtype="https://schema.org/PostalAddress">
                    <span itemprop="streetAddress">проспект Степана Бандеры (Московский проспект), 10-б, офис 4-8,
                        (метро
                        «Петровка»).</span>
                    <span itemprop="addressLocality">Киев, Украина</span>
                </div>
                <span itemprop="telephone">+38 (800) 21-00-37</span>,
                <span itemprop="email">flip@flip.com.ua</span>
                <span itemprop="logo" itemscope itemtype="https://schema.org/ImageObject">
                    <img itemprop="url" src="/wa-apps/blog/themes/flip/img/logo.png" />
                    <meta itemprop="width" content="180">
                    <meta itemprop="height" content="54">
                </span>
            </div>
        </div>

        {include file="./modules/postsPageShareBlock/index.tpl"}

        {if $show_comments && $post.comments_allowed}
            <div id="comment_tabs">
                <ul class="nav nav-tabs" role="tablist">
                    <li role="presentation"><a href="#tab_site_comments">Комментарии</a></li>
                    <li role="presentation"><a href="#tab_fb_comments">Fb.com</a></li>
                </ul>
                <div class="tab-content">
                    <div role="tabpanel" class="tab-pane" id="tab_site_comments">
                        <div class="blank"></div>
                        {if $post.status eq blogPostModel::STATUS_PUBLISHED}
                           {if $post.comment_count == 0}
                           <p class="alert alert-info">Нет комментариев. Вы можете стать первым ,кто оставит отзыв </p>
                           {/if}
                            {include './comments.tpl' inline}
                        {else}
                            <p class="alert alert-info">[`Comments for non published posts are disabled`]</p>
                        {/if}
                    </div>
                    <div role="tabpanel" class="tab-pane" id="tab_fb_comments">
                        <div class="blank"></div>
                        <div id="fb-root"></div>
                        <div class="fb-comments" data-href="https://{$smarty.server.HTTP_HOST}{$smarty.server.REQUEST_URI}"
                            data-numposts="5"></div>
                    </div>
                </div>
            </div>
        {/if}

    </div>
</div>