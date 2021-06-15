import HTTP from '../plugins/http.js';

export default {
  namespaced: true,
  state: {
    formIsShown: false,
    parentId: 0,
    rate: 0,
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
  },
  actions: {
    addReview({ state }, payload) {
      const postData = {
        ...payload,
        rate: (!state.parentId && state.rate) || '',
        parent: state.parentId,
        auth_provider: 'guest',
      };

      return HTTP.post(
        `${postData.commentLink
          .replace(
            // TODO: hardcode, когда-то нужно будет заменить)
            'http://flip.open:81',
            'http://localhost:9000',
          )
          .replace(
            // TODO: hardcode, когда-то нужно будет заменить)
            'http://flip.open',
            'http://localhost:9000',
          )}?json=true`,
        postData,
      )
        .then(({ data }) => {
          const id = data.data && data.data.comment_id;
          if (id) {
            const href = window.location.href;
            window.location.href = `${href.split('#')[0]}#comment${id}`;
            window.location.reload();
          }
          return data;
        })
        .catch(() => {
          alert('Произошла ошибка. Попробуйте еще раз...');
          this.commit('review/closeForm');
        });
    },
  },
};
