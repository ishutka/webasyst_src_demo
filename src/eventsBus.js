import Vue from 'vue';
import store from '@/vuex/store';
const app = new Vue({
  el: '#eventsBus',
  store,
});

app.$on('orderCreated', data => {
  const { order } = data;

  window.ga('require', 'ecommerce');

  window.ga('ecommerce:addTransaction', {
    id: order.varchar_id,
    affiliation: window.location.hostname,
    revenue: order.total,
    shipping: order.shipping,
    tax: order.tax,
    currency: order.currency,
  });

  const productIds = [];

  order.items.forEach(item => {
    window.ga('ecommerce:addItem', {
      id: order.varchar_id,
      name: item.name,
      sku: item.sku_code || '', // NOTE: может передавать код артикула?
      category: item.category_name || '',
      price: item.price,
      quantity: item.quantity,
      currency: order.currency,
    });
    productIds.push(item.product_id);
  });

  window.ga('ecommerce:send');

  window.gtag('event', 'page_view', {
    send_to: 'GTM-NDP3N2M', // TODO: вынести в константу
    ecomm_pagetype: 'purchase',
    ecomm_totalvalue: order.total,
    ecomm_prodid: productIds,
  });
});

export default app;
