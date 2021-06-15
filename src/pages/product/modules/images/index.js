import './index.css';

import 'easyzoom/dist/easyzoom.js';
import 'easyzoom/css/easyzoom.css';
import 'owl.carousel';
import 'owl.carousel/dist/assets/owl.carousel.css';
import 'owl.carousel/dist/assets/owl.theme.default.css';
import 'fancybox/dist/js/jquery.fancybox.pack.js';
import 'fancybox/dist/css/jquery.fancybox.css';
import 'fancybox';
import setLabelsForOwlCarouselDots from '@/helpers/setLabelsForOwlCarouselDots.js';

if (jQuery('#product-gallery').length) jQuery('#product-gallery').show();
const productImage = jQuery('#product-image');
const isDefaultImage = productImage.hasClass('default-photo');
if (jQuery('body').width() >= 1024 && !isDefaultImage) {
  const easyZoom = jQuery('#product-core-image').easyZoom({
    loadingNotice: 'загрузка изображения...',
    errorNotice: 'ошибка загрузки изображения',
  });
  const apiEasyZoom = easyZoom.data('easyZoom');
  jQuery('#product-gallery img').click(() => {
    apiEasyZoom.swap();
  });
}

if (jQuery('#product-gallery  img').length > 0)
  jQuery('#product-gallery img').click(e => {
    const href = e.target.getAttribute('data-href');
    jQuery('#product-gallery .image').removeClass('selected');
    jQuery(e.target)
      .parent()
      .addClass('selected');
    const height = (productImage.height() - 16) / 2;
    jQuery('#product-core-image').append(
      `<div class="loading" style="position: absolute; left: 192px; top: ${height}px"><i class="icon16 loading"></i></div>`,
    );

    jQuery('<img>')
      .attr('src', href)
      .on('load', () => {
        productImage.attr('src', href);
        productImage.parent().attr('href', href);
        jQuery('#product-core-image div.loading').remove();
      })
      .each(() => {
        $(this).trigger('load');
      });
    productImage.attr('src', href);
    productImage.parent().attr('href', href);
  });
if (jQuery('#product-gallery').length) {
  jQuery('#product-gallery')
    .addClass('owl-carousel')
    .owlCarousel({
      lazyLoad: true,
      navigation: true,
      navigationText: [
        "<span class='glyphicon glyphicon-chevron-left'></span>",
        "<span class='glyphicon glyphicon-chevron-right'></span>",
      ],
      responsive: {
        0: { items: 2 },
        375: { items: 3 },
        600: { items: 4 },
        700: { items: 5 },
        1024: { items: 3 },
      },
    });

  setLabelsForOwlCarouselDots('#product-gallery');
}
// jQuery('#product-gallery img:first').click();

// увеличение fancybox
// TODO: сортирует фотографии fancybox не правильно, но пока мы полностью избавимся от jQuery, то я думаю, норм.
if (jQuery('#product-core-image').length) {
  const tpl = {
    wrap:
      '<div class="fancybox-wrap" tabIndex="-1"><div class="fancybox-skin"><div class="fancybox-outer"><div class="fancybox-inner"></div></div></div></div>',
    image: '<img class="fancybox-image" src="{href}" alt="" />',
    iframe:
      '<iframe id="fancybox-frame{rnd}" name="fancybox-frame{rnd}" class="fancybox-iframe" frameborder="0" vspace="0" hspace="0" allowtransparency="true" ></iframe>',
    error:
      '<p class="fancybox-error">Не можем загрузить картинку<br/>Попробуйте позже.</p>',
    closeBtn:
      '<a title="Закрыть" class="fancybox-item fancybox-close" href="javascript:;"></a>',
    next:
      '<a title="Следующее фото" class="fancybox-nav fancybox-next" href="javascript:;"><span></span></a>',
    prev:
      '<a title="Предыдущее фото" class="fancybox-nav fancybox-prev" href="javascript:;"><span></span></a>',
  };
  const corner = jQuery('#product-core-image .corner');
  if (corner.length)
    tpl.wrap = `<div class="fancybox-wrap corner_fancybox_wrap" tabIndex="-1"><div class="fancybox-skin"><div class="fancybox-outer"><div class="fancybox-inner"></div></div></div><div class="
      ${corner.attr('class')} 
      ">
      ${corner.html()}
      </div></div>`;

  jQuery('#product-core-image a, #product-gallery a').fancybox({
    tpl,
  });
}
