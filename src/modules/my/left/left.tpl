	{if $wa->user()->isAuth()}
	<div class="left-menu-wrapper">
		 <div  class="navbar  navbar-default" id="user_account_navbar">
			<ul class="nav nav-pills nav-stacked">
				<li {if $act eq 'orders'}class="active"{/if}>
					<a href="/my/orders/">
						<span class="glyphicon glyphicon-home"></span>
						Главная
					</a>
				</li>
				
				<li {if $act eq 'orders_history'}class="active"{/if}>
					<a href="/my/orders_history/">
						<span class="glyphicon glyphicon-screenshot"></span>
						Мои заказы ({$count_orders})
					</a>
				</li>
				
				<li>
					<a href="/cart/">
						<span class="glyphicon glyphicon-shopping-cart"></span>
						Корзина
					</a>
				</li>
				
				<li {if $act eq 'discount'}class="active"{/if}>
					<a href="/my/discount/">
						<span class="glyphicon glyphicon-gift"></span>
						Персональная скидка
					</a> 
				</li>
				
				<li  {if $act eq 'arrived'}class="active"{/if}>
					<a href="/my/arrived/" class="arrived">
						<span class="glyphicon glyphicon-hourglass"></span>
						Сообщить о наличии ({$count_arrived})
					</a>
				</li>
				
				<li   {if $act eq 'account'}class="active"{/if}>
					<a href="/my/account/">
						<span class="glyphicon glyphicon-user"></span>
						Мои данные
					</a>
				</li>
				
				<li  {if $act eq 'feedback'}class="active"{/if}>
					<a href="/my/feedback/">
						<span class="glyphicon glyphicon-envelope"></span>
						Написать нам
					</a>
				</li>
				
				<li >
					<a href="/my/orders/?logout">
						<span class="glyphicon glyphicon-log-out"></span>
						Выйти
					</a>
				</li>
				
			</ul>
		</div>
		
	</div>
	
	{/if}