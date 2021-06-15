{assign var='current_page' value='comparingCollection' scope='global'}

<div class="col-xs-12">
  <h1>{$collection.name}</h1>
  {$collection.description}

  {include file="./productsList.tpl"}
</div>