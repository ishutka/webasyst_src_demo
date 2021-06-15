export default function setLabelsForOwlCarouselDots(string) {
  jQuery(`${string} .owl-dot`).each(function() {
    $(this).attr('aria-label', 'навигация по слайдам');
  });
}
