{assign var='current_page' value = 'myArrived' scope = 'global'}
<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
	<div class="blank"></div>
	<div class="blank"></div>
	
    {include file="./../../modules/my/left/left.tpl"}
	<div class="col-xs-12 col-sm-8 col-md-9 myArrived">
		<div class="row">
			<legend>Сообщить о наличии</legend> 
			<div class="tab-content">
				<div class="nav nav-tabs">Не отправленные</div>
				<div  id="no_sended" class="table-responsive">
					{include file="./list.tpl" is_sended=false items=$no_sended_list}
				</div>
		
				<div class="nav nav-tabs">Отправленные</div>
				
				<div  id="sended" class="table-responsive">
					{include file="./list.tpl" is_sended=true items=$sended_list}
				</div>
			</div>
		</div>
	</div>
	
	<div class="clear clearfix"></div>
	<div class="blank"></div>
	<div class="blank"></div>
</div>