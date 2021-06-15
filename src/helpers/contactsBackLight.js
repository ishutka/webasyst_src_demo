export default el => {
  // Первый таймаут -для открытия(создания) модального окна
  //  второй- для завершения анимации
  setTimeout(() => {
    document.querySelector(el).classList.add('twinkle');
    setTimeout(() => {
      document.querySelector(el).classList.remove('twinkle');
    }, 1400);
  }, 100);
};
