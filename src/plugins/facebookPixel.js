import eventsBus from '../eventsBus';
import http from './http';

/* eslint-disable */
  !function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){
    n.callMethod?
    n.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;
    n.push=n;n.loaded=!0;n.version='2.0';n.queue=[];t=b.createElement(e);t.async=!0;
    t.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window,
    document,'script','https://connect.facebook.net/en_US/fbevents.js');
    window.fbq('init',	window.facebookPixelId, {});
    window.fbq('track', 'PageView');
  /* eslint-enable */

const fbqWrapper = (type, name, fbqParams, originalParams) => {
  http
    .get('/facebookPixel/GetCategoriesPath/', {
      params: {
        productId: originalParams.id,
      },
    })
    .then(({ data }) => {
      fbqParams.content_category = data.data.categories_path;
      window.fbq(type, name, fbqParams);
    })
    .catch(() => {
      window.fbq(type, name, fbqParams);
    });
};

eventsBus.$on('orderCreated', params => {
  window.fbq('track', 'Purchase', {
    currency: window.currency,
    content_ids: params.order.items.map(item => item.product_id),
    value: params.order.total,
  });
});

eventsBus.$on('addedToCart', ({ id, price, name }) => {
  fbqWrapper(
    'track',
    'AddToCart',
    {
      currency: window.currency,
      content_ids: [id],
      content_type: 'product',
      value: price,
      content_name: name,
    },
    { id },
  );
});

eventsBus.$on('productPageView', ({ id, price, name }) => {
  fbqWrapper(
    'track',
    'ViewContent',
    {
      currency: window.currency,
      content_ids: [id],
      content_type: 'product',
      value: price,
      content_name: name,
    },
    { id },
  );
});
