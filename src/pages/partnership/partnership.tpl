{if !waRequest::isXMLHttpRequest()}
{assign var='current_page' value='partnership' scope='global'}
<div class="col-xs-12" id="partnership_page">
	{$description}
	<hr />
	<legend>Отправить заявку на сотрудничество</legend>
	<div id="partner-ship-vue">
	<partnership></partnership>
	</div>
</div>
{else}{if $errors}{json_encode($errors)}{/if}{/if}