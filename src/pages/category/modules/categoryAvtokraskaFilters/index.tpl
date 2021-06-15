 {if $category.is_car_brand == 1 || $category.parent_id == 780 || $category.id == 780}
    <p><strong class="categoryFiltersTitle hidden-xs hidden-sm">Подбор красок по автомобилю</strong></p>
    <div class=" navbar  navbar-default categories_left_menu_navbar" id="is_car_brand_categories_left_menu_navbar">
        <div class="burger-wrap">
            <span class="sr-only-text visible-xs visible-sm">Подбор красок по автомобилю</span>

            <button class="navbar-toggle collapsed" type="button" 
            data-toggle="collapse" data-target="#is_car_brand_categories_left_menu_for_mobile"
            aria-controls="is_car_brand_categories_left_menu_for_mobile" aria-expanded="false">
                <i class="fa fa-angle-down"></i>
            </button>
        </div>
        <div id="is_car_brand_categories_left_menu_for_mobile" class="collapse navbar-collapse">
        <ul id="is_car_brand_categories_left_menu" class="nav">
            {foreach $categories as $c}
                {if $c.is_car_brand == 0} {continue} {/if}
                <li {if $c.id == $category.id}class="active"{/if}>
                    <a href="/{$c.full_url}/">{$c.name} ({$c.count})</a>
                </li>
            {/foreach}
        </ul>
        </div>
    </div>
{/if}
    
{if $category.is_paint_type == 1 || $category.parent_id == 780 || $category.id == 780}
    <p><strong class="categoryFiltersTitle hidden-xs hidden-sm">Подбор красок по типу краски</strong></p>
    <div class=" navbar  navbar-default categories_left_menu_navbar" id="is_paint_type_categories_left_menu_navbar">
        <div class="burger-wrap">
            <span class="sr-only-text visible-xs visible-sm">Подбор красок по типу краски</span>

            <button class="navbar-toggle collapsed" type="button" data-toggle="collapse" data-target="#is_paint_type_categories_left_menu_for_mobile" aria-controls="is_car_brand_categories_left_menu_for_mobile" aria-expanded="false">
                <i class="fa fa-angle-down"></i>
            </button>
        </div>
        <div id="is_paint_type_categories_left_menu_for_mobile" class="collapse navbar-collapse">
        <ul id="is_paint_type_categories_left_menu" class="nav">
            {foreach $categories as $c}
                {if $c.is_paint_type == 0} {continue} {/if}
                <li {if $c.id == $category.id}class="active"{/if}>
                    <a href="/{$c.full_url}/">{$c.name} ({$c.count})</a>
                </li>
            {/foreach}
        </ul>
        </div>
    </div>
{/if}
    
{if $category.is_color_group == 1 || $category.parent_id == 780 || $category.id == 780}
    <p><strong class="categoryFiltersTitle hidden-xs hidden-sm">Подбор красок по цвету</strong></p>
    <div class="navbar  navbar-default categories_left_menu_navbar" id="is_color_group_categories_left_menu_navbar">
        <div class="burger-wrap">
            <span class="sr-only-text visible-xs visible-sm">Подбор красок по цвету</span>

            <button class="navbar-toggle collapsed" type="button" data-toggle="collapse" data-target="#is_color_group_categories_left_menu_for_mobile" aria-controls="is_car_brand_categories_left_menu_for_mobile" aria-expanded="false">
                <i class="fa fa-angle-down"></i>
            </button>
        </div>
        <div id="is_color_group_categories_left_menu_for_mobile" class="collapse navbar-collapse">
        <ul id="is_color_group_categories_left_menu" class="nav">
            {foreach $categories as $c}
                {if $c.is_color_group == 0} {continue} {/if}
                <li {if $c.id == $category.id}class="active"{/if}>
                    <a href="/{$c.full_url}/">{$c.name} ({$c.count})</a>
                </li>
            {/foreach}
        </ul>
        </div>
    </div>
{/if}