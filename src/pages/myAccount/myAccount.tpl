{assign var='current_page' value = 'myAccount' scope = 'global'}
{if !waRequest::isXMLHttpRequest()}
<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" id="siteprofAccount_MyAccount">
	<div class="blank"></div>
	<div class="blank"></div>
	
    {include file="./../../modules/my/left/left.tpl"}
	<div class="col-xs-12 col-sm-8 col-md-9 col-lg-9">
		<legend>Мои данные</legend> 
		{* :init-data='{json_encode($contact->load(), 32)}' не передаю, потому что уже есть в сторе, через компонент initData *}
		<my-account></my-account>
	</div>
	
	<div class="clear clearfix"></div>
	<div class="blank"></div>
	<div class="blank"></div>
</div>
{elseif $form->errors()}{json_encode($form->errors())}{/if}