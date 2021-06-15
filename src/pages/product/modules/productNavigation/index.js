import './index.css';

import './jquery.ddscrollspy.js';

$(() => {
  // TODO:Не пойму зачем здесь условие вообще,если и предыдущий,
  //  и нынешний элемент,наличие которого проверяем  -
  //  безусловно есть в верстке
  if (jQuery('#product-core-image').length)
    jQuery('#product_navigation ul').ddscrollSpy();
});
