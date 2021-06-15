{assign var='current_page' value='login' scope='global'}
{if !waRequest::isXMLHttpRequest()}
<h1>[s`Login`]</h1>
{*
    NOTE: кнопки для авторизации через соц.сети    
*}
{$wa_adapters=$wa->authAdapters()}
{$wa_adapters=$wa_adapters|regex_replace:'/<script[^>]*.*<\/script>/':''}
{$wa_adapters}
{/if}
<login-form></login-form>

{if $error}
<div id="error">{$error}</div>
{/if}