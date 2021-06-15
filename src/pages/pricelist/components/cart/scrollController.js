import Sticky from 'sticky-js';
export default () => {
  const sticky = new Sticky('#panelPriceListCart');
  window.addEventListener('click', () => sticky.update());
};
