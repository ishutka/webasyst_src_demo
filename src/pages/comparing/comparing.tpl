{assign var='current_page' value='comparing' scope='global'}
<div class="col-xs-12">
  {$description}
  <div class="blank"></div>
  <div class="blank"></div>
</div>
<div class="col-xs-12">
  <table class="table table-hover " id="comparing">
    {foreach $collections as $c}
      {if $c.main != 1}
        <tr>
          <td class="table-btn">
            <a href="/comparing/{$c.alias}/" class="btn btn-success">
              {$c.name}
            </a>
          </td>
          <td>
            {$c.meta_description}
          </td>
        </tr>
      {/if}
    {/foreach}
  </table>
</div>
<div class="blank"></div>
<div class="blank"></div>

