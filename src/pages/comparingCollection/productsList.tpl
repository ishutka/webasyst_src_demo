<div class="table-responsive" id="comparing-collection">
    <table class="table table-hover ">
      {foreach $products as $p}
        <tr class="category_item_product">
          <td style="width:45%;">
            <strong>
              {$p.product_1.name}
            </strong>
            <div>
              {$wa->shop->productImgHtml($p.product_1, '200', ['itemprop' => 'image', 'alt' => $p.product_1.name|cat:' фото', 'default' => "img/dummy200.png"])}
            </div>
            <div class="description">
               {$p.product_1.summary}
             </div>
          </td>
          <td class="va_middle">
            <a href="{$p.url}" title="Сравнить {$p.product_1.name} и {$p.product_2.name}" class="btn btn-success">
              Сравнить
            </a>
          </td>
          <td style="width:45%;">
            <strong>
              {$p.product_2.name}
            </strong>
            <div>
              {$wa->shop->productImgHtml($p.product_2, '200', ['itemprop' => 'image', 'alt' => $p.product_2.name|cat:' фото', 'default' => "img/dummy200.png"])}
            </div>
            <div class="description">
               {$p.product_2.summary}
            </div>
          </td>
        </tr>
      {/foreach}
    </table>
</div>