import webasystSocialAuthorization from '@/webasystSocialAuthorization';

export default {
  mounted() {
    webasystSocialAuthorization();
    // Ставим/убираем  возможность прокрутки для body, когда открыть\закрыто модальное окно( не вложенное в другое модальное):
    this.$children.forEach(child => {
      // Наличием класса у body проверяем,что модальное окно не вложенное и только на таковое вешаем обработчики:
      const nestedModal = document
        .querySelector('body')
        .classList.contains('modal-open');
      if (child.modal && !nestedModal) {
        child.$on('before-open', this.handleBeforeOpenModal);
        child.$on('before-close', this.handleBeforeCloseModal);
      }
    });
  },
  methods: {
    // В val передаем name модального окна
    show(val, isNeedToCheckForClosingOpenedModal = true) {
      // второй параметр определяет закрывать ли другие открытие модальные окна или нет

      if (isNeedToCheckForClosingOpenedModal) {
        const activeModal = document.querySelector('.v--modal-overlay');
        if (activeModal) {
          const dataAttr = activeModal.getAttribute('data-modal');
          this.hide(dataAttr);
        }
      }
      this.$modal.show(val);
      // Делаем активным поле ввода
      // таймаут нужен для отрисовки окна
      setTimeout(() => {
        if (val == 'quick-search') {
          const searchInput = document.querySelector(
            '.search-modal .search_id',
          );
          searchInput.focus();
        }
      }, 300);
    },
    handleBeforeOpenModal() {
      document.querySelector('body').classList.add('modal-open');
    },
    handleBeforeCloseModal() {
      document.querySelector('body').classList.remove('modal-open');
    },
    hide(val) {
      this.$modal.hide(val);
    },
  },
};
