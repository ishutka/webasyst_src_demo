import HTTP from '../plugins/http.js';

export default {
  namespaced: true,
  state: {
    formIsShown: false,
    parentId: 0,
    rate: 0,
    createdReviews: [],
  },
  getters: {},
  mutations: {
    showForm(state) {
      state.formIsShown = true;
    },
    closeForm(state) {
      state.formIsShown = false;
    },
    changeParentId(state, parentId) {
      state.parentId = parentId;
    },
    setRate(state, value) {
      state.rate = value;
    },
    setHtmlForCreatedReview(state, { html, parentId }) {
      state.createdReviews.push({
        parentId,
        html,
      });
      setTimeout(() => {
        const offsetTop = document.getElementById('newCreatedReview').offsetTop;
        window.scrollTo(0, offsetTop - 50);
      }, 0);
    },
  },
  actions: {
    addReview({ state }, payload) {
      const postData = {
        ...payload,
        rate: (!state.parentId && state.rate) || '',
        parent_id: state.parentId,
        auth_provider: 'guest',
      };
      let url = location.pathname;
      if (location.href.includes('reviews')) url = `${url}add/`;
      else url = `${url}reviews/add/`;
      return HTTP.post(url, postData)
        .then(({ data }) => {
          this.commit('review/closeForm');
          this.commit('review/setHtmlForCreatedReview', {
            html: data.data.html,
            parentId: state.parentId,
          });
        })
        .catch(error => {
          alert('Произошла ошибка. Попробуйте еще раз...');
          this.commit('review/closeForm');
        });
    },
  },
};
