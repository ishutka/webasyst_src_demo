// Logic for viewSwitcher:
function loadSwitchers() {
  const switcherChildren = document.querySelectorAll('.grid-style-switcher>i');
  function switcherClickHandler(e) {
    // Создаем массив из родительских эл-тов переключателя и #listThumbs,
    // чтобы переключать класс для стилей
    const collect = document.querySelectorAll(
      '.category-filters__wrapper,#listThumbs',
    );
    if (window.getComputedStyle(e.target, null).opacity !== '1') {
      // Вешаем куку ,для сохранения при перезагрузке страницы, выбранного пользователем вида:
      if (e.target.classList.contains('icon-023-view'))
        document.cookie = `list_thumbs_grid_view=rows;path=/;max-age=31536000;`;
      else
        document.cookie = `list_thumbs_grid_view=grid;path=/;max-age=31536000;`;
      // Использую classList.toggle() потому что у нас только два возможных варианта стиля(которые мы переключаем):
      Array.from(collect).forEach(el => {
        el.classList.toggle('rows-style');
      });
    }
  }
  if (switcherChildren.length) {
    for (let i = 0; i < switcherChildren.length; i++)
      switcherChildren.item(i).addEventListener('click', switcherClickHandler);
    // Проверяем наличие куки и меняем или нет  внешний вид сетки listThumbs:
    try {
      const listThumbsRowsViewCookie = document.cookie
        .split(';')
        .filter(item => item.trim().startsWith('list_thumbs_grid_view=rows'));
      if (listThumbsRowsViewCookie.length)
        document.querySelector('.grid-style-switcher .icon-023-view').click();
    } catch (e) {
      // eslint-disable-next-line no-console
      console.log(e);
    }
  }
}
export default loadSwitchers;
