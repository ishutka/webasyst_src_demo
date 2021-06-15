import 'owl.carousel';
import 'owl.carousel/dist/assets/owl.carousel.css';
import 'owl.carousel/dist/assets/owl.theme.default.css';
import setLabelsForOwlCarouselDots from '@/helpers/setLabelsForOwlCarouselDots.js';

if (jQuery('#show_new_products').length) {
  jQuery('#show_new_products').css('max-width', '600px');
  jQuery('#show_new_products').addClass('owl-theme');
  jQuery('#show_new_products').owlCarousel({
    autoPlay: true,
    navigation: true,
    responsive: {
      // breakpoint from 0 up
      0: {
        items: 1,
      },
      // breakpoint from 480 up
      480: {
        items: 3,
      },
    },
    lazyLoad: true,
  });
  setLabelsForOwlCarouselDots('#show_new_products');
  const items_block_width = jQuery('#show_new_products').outerWidth();
  let items_width = 20;
  jQuery('#show_new_products .owl-item').each((i, e) => {
    items_width += jQuery(e).outerWidth();
  });
  if (items_block_width > items_width)
    jQuery('#show_new_products').css({ width: items_width });
}
