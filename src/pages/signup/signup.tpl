{assign var='current_page' value='signup' scope='global'}
{if !waRequest::isXMLHttpRequest()}
    <div id="register_text">
        <h1>Регистрация</h1>
        <h5>Зарегистрируйтесь и станьте постоянным пользователем нашего сайта.</h5>
        <p>Для зарегистрированных пользователей действует накопительная скидка до 3%. </p>
        <p>Накопительная скидка зависит от суммы всех заказов сделанных начиная с дня регистрации.</p>
        <p>При сумме заказов: </p>
        <ul>
            <li>более 10000 грн. - скидка составит 1%;</li>
            <li> более 15000 грн. - скидка составит 2%;</li>
            <li> более 20000 грн. - скидка составит 3%<span class="redactor-invisible-space"></span></li>
        </ul>
        <p>Подписывайтесь на новости и получайте информацию о свежих поступлениях и акциях, а также скидочные купоны.</p>
        <p>Все поля ниже обязательны для заполнения</p>
    </div>
    {*
        NOTE: кнопки для авторизации через соц.сети    
    *}
    {$wa_adapters=$wa->authAdapters()}
        {$wa_adapters=$wa_adapters|regex_replace:'/<script[^>]*.*<\/script>/':''}
        {$wa_adapters}
    <signup-form></signup-form>
{else if $errors}{json_encode($errors)}{/if}