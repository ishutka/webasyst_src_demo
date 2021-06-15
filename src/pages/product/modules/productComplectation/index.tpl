{if $product.complectation}
    <div id="product_complectation">
        <hr />
        <h3>Комплект поставки {$product.name|escape}</h3>
        {$product.complectation}
    </div>
{/if}