import '../../index.js';
import 'bootstrap/js/tab.js'; //нужен ли нам бутстрап?

import '../../modules/globals/shareBlock/shareBlock.js';
import './index.scss';
import '@/modules/globals/postsCategories/postsCategoriesMenu.scss';
/* eslint camelcase: "off" */
const provider_list = $('#user-auth-provider');

provider_list.find('a').click(function() {
  const self = $(this);
  const provider = self.parents('li:first').attr('data-provider');

  if (provider != 'guest' && provider != 'signup') {
    const left = (screen.width - 600) / 2;
    const top = (screen.height - 400) / 2;
    window.open(
      $(this).attr('href'),
      'oauth',
      `width=600,height=400,left=${left},top=${top},status=no,toolbar=no,menubar=no`,
    );
    return false;
  }
});

(function(d, s, id) {
  const fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  const js = d.createElement(s);
  js.id = id;
  js.src = '//connect.facebook.net/ru_RU/sdk.js#xfbml=1&version=v2.6';
  fjs.parentNode.insertBefore(js, fjs);
})(document, 'script', 'facebook-jssdk');

import reviewForm from './components/reviewForm/index.vue';
import showFormBtn from './components/showFormBtn/index.vue';
// import createdReview from './components/createdReview/index.vue';
import Vue from 'vue';
import store from '@/vuex/store';
new Vue({
  el: '#infopost-page',
  components: {
    // createdReview,
    reviewForm,
    showFormBtn,
  },
  store,
});

$('#comment_tabs .nav-tabs a').click(function(e) {
  e.preventDefault();
  $(this).tab('show');
});

$('#comment_tabs .nav-tabs a:first').click();
