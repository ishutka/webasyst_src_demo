$('.filters .collapsed').click(function() {
  const toggleIcon = this.children[0];
  const aim = document.querySelector(this.dataset.target);
  // Меняем стрелку-переключатель разворачивающегося списка
  toggleIcon.classList.toggle('fa-angle-up');
  toggleIcon.classList.toggle('fa-angle-down');
  // Сворачиваем/разворачиваем списки
  aim.classList.toggle('crumble');
  aim.classList.toggle('collapse');
});
