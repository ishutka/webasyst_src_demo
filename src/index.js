window.ga = window.ga || (() => {});
import 'bootstrap/dist/css/bootstrap.min.css';
import 'font-awesome/css/font-awesome.min.css';
import './index.scss';
import webasystSocialAuthorization from './webasystSocialAuthorization';
import './modules/seoHide/seoHide.js';

import './modules/header/header.js';
import './modules/header/topLine/topLine.css';
import './modules/header/topLine/topLine.js';
import './modules/footer/footer.js';
import './modules/footer/footer.css';
import './modules/globals/rating/rating.css';
import './modules/globals/rating/rating.js';
import './plugins/facebookPixel';

jQuery(document).ready(() => {
  webasystSocialAuthorization();
  if (jQuery('.fancybox').length) {
    const next =
      '<a title="Следующее фото" class="fancybox-nav fancybox-next"><span></span></a>';
    const prev =
      '<a title="Предыдущее фото" class="fancybox-nav fancybox-prev"><span></span></a>';
    const closeBtn =
      '<a title="Закрыть" class="fancybox-item fancybox-close" href="javascript:;"></a>';
    jQuery('.fancybox').fancybox({
      tpl: {
        next,
        prev,
        closeBtn,
      },
    });
  }
});

document.oncopy = () => {
  const bodyElement = document.getElementsByTagName('body')[0];
  const selection = window.getSelection();
  const pagelink = `<a title='${document.title}' href='${document.location.href}'> flip</a>`;
  const copytext = selection + pagelink;
  const newdiv = document.createElement('div');
  newdiv.style.position = 'absolute';
  newdiv.style.left = '-99999px';
  bodyElement.appendChild(newdiv);
  newdiv.innerHTML = copytext;
  selection.selectAllChildren(newdiv);
  window.setTimeout(() => {
    bodyElement.removeChild(newdiv);
  }, 5);
};
