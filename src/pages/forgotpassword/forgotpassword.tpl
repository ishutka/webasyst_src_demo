{assign var='current_page' value='forgotpassword' scope='global'}

<script src="/node_modules/jquery/dist/jquery.min.js"></script>

<div class="col-xs-12 col-md-12 col-md-12 col-lg-12" {if empty($set_password)}id="forgot_password_page" {/if}> 
    <div id="page" role="main">

        {if !empty($set_password)}
            <h1 class="tc">[s`Recover password for`] {$login}</h1>
            {$wa->setPasswordForm($error)}
        {else}
            <h1 class="tc">[s`Password recovery`]</h1>
            {if !empty($sent)}
                <div class="go-back">
                    <p>[s`Password recovery instructions have been sent to your email address.`]</p>
                    <a class="btn btn--report" href="{$wa->loginUrl()}">[s`Back to login page`]</a>
                </div>
            {else}
                {$wa->forgotPasswordForm($error)}
            {/if}
        {/if}
    </div>
</div>