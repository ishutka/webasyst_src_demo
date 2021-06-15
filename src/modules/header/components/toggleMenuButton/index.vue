<template>
  <i
    class="icon-006-menu burger"
    :class="{ active: menuIsSwitched }"
    @click="
      pushMenuButton();
      addOutsideClickListener();
    "
  ></i>
</template>
<script>
import { mapState, mapMutations } from 'vuex';
export default {
  computed: {
    ...mapState('topMenu', ['isMobile', 'menuIsSwitched']),
  },
  methods: {
    ...mapMutations('topMenu', ['pushMenuButton']),
    outsideСlickHandler(evt) {
      // Ф-ция проверяет является ли event.target эл-том меню или переключателем меню
      //чтобы закрыть меню и удалить EventListener
      const targetHtml = evt.target.outerHTML;
      /* 
        проверяем, является ли элемент, 
        дочерним для :
          *  кнопки-переключателя меню.
          * меню первого уровня
          * меню второг уровня 

          задача: что бы меню автоматически закрывалось по клику вне меню.
      */
      const isInToggleBtn =
        document
          .querySelector('#toggleMenuButton')
          .outerHTML.includes(targetHtml) ||
        document
          .querySelector('.medium-header-search-bar')
          .outerHTML.includes(targetHtml);

      // меню первого уровня
      const isInFirstMenuElement = document.querySelector('#firstLevelWrapper')
        ? document
            .querySelector('#firstLevelWrapper')
            .outerHTML.includes(targetHtml)
        : false;

      // меню второго уровня
      const isInSecondMenuElement = document.querySelector(
        '#secondLevelWrapper',
      )
        ? document
            .querySelector('#secondLevelWrapper')
            .outerHTML.includes(targetHtml)
        : false;

      if (isInToggleBtn) this.removeOutsideClickListener();
      // если клик был по кнопке-переключателе меню, то меню уже закрыто
      else if (
        !this.isMobile &&
        !isInSecondMenuElement &&
        !isInFirstMenuElement
      ) {
        this.removeOutsideClickListener();
        this.pushMenuButton();
      }
    },
    addOutsideClickListener() {
      setTimeout(() => {
        // setTimeout нужен,чтобы обработчик не сработал на инициирующий его клик
        if (this.menuIsSwitched)
          document.body.addEventListener('click', this.outsideСlickHandler);
      }, 0);
    },
    removeOutsideClickListener() {
      document.body.removeEventListener('click', this.outsideСlickHandler);
    },
  },
};
</script>
<style lang="scss">
@import '@/mainStylesVariables.scss';
.burger {
  font-size: 2em;
  margin: 0 15px;
  cursor: pointer;
  @include link_color_animate();
}
.active.burger {
  color: $main_brand_color;
}
#toggleMenuButton .burger {
  margin: 0 40px;
  flex: 0 1 auto;
}
@media (max-width: 1199px) {
  #toggleMenuButton .burger {
    display: none;
  }
}
</style>
