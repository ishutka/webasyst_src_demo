 {foreach $available_sort_fields as $data} 
    <a 
    class="{if $data.active} selected-sort{/if}"    
    href="{$data.url}"
    >
        <span>{$data.text}</span>
        {if $data.active}
        {if $data.order === 'asc'}
            <span >возр.</span>
            <i class="icon-020-sortasc"></i>
        {else}
            <span>убыв.</span>
            <i  class="icon-021-sortdesk" ></i>
        {/if}
        {/if}
    </a>
{/foreach} 