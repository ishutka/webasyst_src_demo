{assign var='current_page' value = 'myOrders' scope = 'global'}

<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
    <div class="blank"></div>
    <div class="blank"></div>

    {include file="./../../modules/my/left/left.tpl"}
    <div class="col-xs-12 col-sm-8 ">
        <div class="row" id="user_account_big_menu">
          <legend>Личный кабинет</legend>

            <div class="col-xs-6 col-md-4 user_account_big_menu_item">
                <a href="/my/orders_history/">
                    <span class="glyphicon glyphicon-screenshot"></span>
                    <em>Мои заказы ({$count_orders})</em>
                </a>
            </div>

            <div class="col-xs-6 col-md-4 user_account_big_menu_item">
                <a href="/cart/">
                    <span class="glyphicon glyphicon-shopping-cart"></span>
                    <em>Корзина</em>
                </a>
            </div>

            <div class="col-xs-6 col-md-4 user_account_big_menu_item">
                <a href="/my/discount/">
                    <span class="glyphicon glyphicon-gift"></span>
                    <em>Персональная скидка</em>
                </a>
            </div>

            <div class="col-xs-6 col-md-4 user_account_big_menu_item">
                <a href="/my/arrived/">
                    <span class="glyphicon glyphicon-hourglass"></span>
                    <em>Сообщить о наличии ({$count_arrived})</em>
                </a>
            </div>

            <div class="col-xs-6 col-md-4 user_account_big_menu_item">
                <a href="/my/account/">
                    <span class="glyphicon glyphicon-user"></span>
                    <em>Мои данные</em>
                </a>
            </div>

            <div class="col-xs-6 col-md-4 user_account_big_menu_item">
                <a href="/my/feedback/">
                    <span class="glyphicon glyphicon-envelope"></span>
                    <em>Написать нам</em>
                </a>
            </div>
        </div>
    </div>

    <div class="clear clearfix"></div>
    <div class="blank"></div>
    <div class="blank"></div>
</div>