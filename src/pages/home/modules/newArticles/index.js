import Vue from 'vue';
import Vuex from 'vuex';
Vue.use(Vuex);
import store from '@/vuex/store';
import lazyImage from '@/modules/globals/lazyImage/index.vue';
if ($('#homecategories_blog_plugin .home-articles-wrapper').length > 0)
  new Vue({
    el: '#homecategories_blog_plugin .home-articles-wrapper',
    components: {
      lazyImage,
    },
    store,
  });

const initArticlesTabs = () => {
  const navTab = document.querySelector('#nav-tab');
  if (navTab) {
    navTab.addEventListener('click', e => {
      const { target } = e;
      const { innerText, classList } = target;
      if (target.getAttribute('href') != '/articles/') e.preventDefault();
      if (
        target.getAttribute('data-toggle') == 'tab' &&
        !classList.contains('active')
      ) {
        // меняем заголовок блока на заголовок активной вкладки:
        document.querySelector(
          '.post-header .section-title:first-child',
        ).innerText = innerText;
        // меняем активную ссылку на вкладку:
        const activeTabLink = document.querySelector(
          '#nav-tab > .nav-item.active',
        );
        if (activeTabLink) activeTabLink.classList.remove('active');
        classList.add('active');

        // меняем активную вкладку:
        const activeTab = document.querySelector(
          '#tab-content .tab-pane.showed',
        );
        if (activeTab) activeTab.classList.remove('showed');
        document
          .querySelector(target.getAttribute('href'))
          .classList.add('showed');
      }
    });
    //   Активируем первую вкладку:
    const firstTab = document.querySelector('#nav-tab > a:first-child');
    firstTab.click();
  }
};
initArticlesTabs();
