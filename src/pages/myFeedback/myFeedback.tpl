{assign var='current_page' value = 'myFeedback' scope = 'global'}
<div class="col-xs-12 myFeedback">
	<div class="blank"></div>
	<div class="blank"></div>
    {include file="./../../modules/my/left/left.tpl"}
	<div class="col-xs-12 col-sm-8 ">
	{* TODO: load voue-component (from /contacts/ page) *}
		<div class="row">

			<legend>Написать нам</legend> 
			{if $success}
				<div class="alert alert-success">
					{$success}
				</div>
			{/if}
			
			{if $error}
				<div class="alert alert-danger">
					{$error}
				</div>
			{/if}
			
			{if !$success}
				<form class="form-horizontal" method="POST">
					<div class="form-group">
						<label class="control-label tr col-xs-3 ">Имя <em class="required_star">*</em></label>
						<div class="control-label col-xs-8  col-md-5">
							<input class="form-control" required name="firstname" value="{if waRequest::post('firstname')}{waRequest::post('firstname')}{else}{$wa->user('firstname',true)}{/if}" type="text">
						</div>
					</div>
					
					<div class="form-group">
						<label class="control-label tr col-xs-3 ">Email <em class="required_star">*</em></label>
						<div class="control-label col-xs-8  col-md-5">
							<input class="form-control" required name="email" value="{if waRequest::post('email')}{waRequest::post('email')}{else}{$wa->user('email',true)}{/if}" type="email" />
						</div>
					</div>
					
					<div class="form-group">
						<label class="control-label tr col-xs-3 ">Тема <em class="required_star">*</em></label>
						<div class="control-label col-xs-8  col-md-5">
							<input class="form-control" required name="subject" value="{waRequest::post('subject')}" type="text">
						</div>
					</div>
					
					<div class="form-group">
						<label class="control-label tr col-xs-3 ">Сообщение </label>
						<div class="control-label col-xs-8  col-md-5">
							<textarea class="form-control" required name="text" rows="5">{waRequest::post('text')}</textarea>
						</div>
					</div>
					
					<div class="form-group">
						<label class="control-label tr col-xs-3 "></label>
						<div class="control-label col-xs-8  col-md-5 submit">
							<input type="submit" name="submit" value="Отправить" class="btn btn-success" />
						</div>
					</div>
					
				</form>
			{/if}
		</div>
	</div>
	
	<div class="clear clearfix"></div>
	<div class="blank"></div>
	<div class="blank"></div>
</div>