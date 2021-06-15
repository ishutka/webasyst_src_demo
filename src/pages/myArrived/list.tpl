<table class="table table-hover  table-striped">
    <tr></tr>{* фейковый ряд,чтобы поменять чередование бекграунда рядов*}
    <tr>
        <th>Продукт</th>
        <th style="max-width:100px;white-space:wrap">Email</th>
        <th>Телефон</th>
        {if $is_sended == false}
            <th class="nowrap">Актуально</th>
        {/if}
        <th class="nowrap">Создано</th>
        {if $is_sended == false}
            <th class="nowrap">Статус</th>
        {/if}
    </tr>
    {foreach $items as $item}
        <tr>
            <td>
                <a target="_blank" href="{$item.product.frontend_url}">{$item.product.name|escape}
                    
                </a> 
            </td>
            <td>{$item.email}</td>
            <td>{$item.phone}</td>
            {if $is_sended == false}
                <td class="nowrap">
                    <strong>{$item.expiration|date_format:"%d.%m.%Y"|default:"-"}</strong>
                </td>
            {/if}
            <td class="nowrap">
                {$item.created|date_format:"%d.%m.%Y %H:%M"|default:"-"}
            
            
            <td class="nowrap">
            {if $is_sended == false}
                {if $item.expired eq 1}
                    <span class="label label-default">Не актуально</span>
                {else}
                    <span class="label label-success">Актуально</span>
                {/if}
            {/if}
            </td>
        </tr>
    {/foreach}
</table>