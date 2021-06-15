import Vue from 'vue';
import store from '@/vuex/store';
import 'owl.carousel';
import toCompareButton from '@/modules/compare/components/toCompareButton/index.vue';
import lazyImage from '@/modules/globals/lazyImage/index.vue';
import addToCartButton from '@/modules/globals/additionalProductsSet/components/addToCartButton/index.vue';
import '@/modules/globals/additionalProductsSet/index.scss'; //TODO: насколько корректно оставлять подключение стилей здесь?
// или лучше перенести в тот же модуль\чанк,где подключаем компонент additionalProductsSet?

export default function initRelatedProducts(element) {
  new Vue({
    el: element,
    store,
    components: {
      toCompareButton,
      lazyImage,
      addToCartButton,
    },
    mounted() {
      this.initOwlCarousel();
    },
    methods: {
      checkFullScreenClass() {
        const el = this.$el.querySelector('.owl-carousel');
        // Если "карусель" шире 520px(и ширина монитора соответствует "не тачскрин-устройству"), то добавляется класс .full-screen и элементы меняют внешний вид:
        if (window.innerWidth > 1023 && el.clientWidth > 520) {
          if (!el.classList.contains('full-screen'))
            el.classList.add('full-screen');
        } else if (el.classList.contains('full-screen'))
          el.classList.remove('full-screen');
      },
      initOwlCarousel() {
        const el = this.$el.querySelector('.owl-carousel');
        $(el).owlCarousel({
          margin: 8,
          autoWidth: true,
          nav: true,
          dots: false,
          lazyLoad: true,
          responsiveBaseElement: $('.related-products'),
          navText: [
            '<i class="icon-014-left"/>',
            '<i class="icon-015-right"/>',
          ],
        });
        this.checkFullScreenClass();
        $(el).on('resized.owl.carousel', this.checkFullScreenClass);
      },
    },
  });
}
