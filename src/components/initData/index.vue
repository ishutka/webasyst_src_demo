<template>
  <div>
    <!-- Здесь указываю атрибут name , чтобы знать какое имя передавать в качастве параметра modal-name в компонентах,где создается/закрывается окно -->
    <modals-container name="container"> </modals-container>
  </div>
</template>

<script>
import { mapMutations } from 'vuex';

export default {
  props: {
    currentPage: {
      type: String,
      required: true,
    },
    cartTotal: {
      type: String,
      required: true,
    },
    cartCount: {
      type: Number,
      required: true,
    },
    currency: {
      type: String,
      required: true,
    },
    user: {
      type: Object,
      required: true,
    },
  },
  created() {
    // т.к. js по умолчанию не парсит дробное число с запятой, то я меняю запятую на точку, а потом ее парсю
    const total = parseFloat(this.cartTotal.replace(',', '.'));
    this.setTotal(total);
    this.setCount(this.cartCount);
    this.setCode(this.currency);
    this.setUserData(this.user);
    // this.updateDialogWidth();
    // window.addEventListener('resize', this.updateDialogWidth);
  },
  mounted() {
    this.getCurrentPageType(this.currentPage);
  },
  methods: {
    ...mapMutations('cart', ['setTotal', 'setCount']),
    ...mapMutations('currency', ['setCode']),
    ...mapMutations('user', ['setUserData']),
    ...mapMutations('index', ['getCurrentPageType']),

    ...mapMutations('productArrived', {
      productArrivedSetSettings: 'setSettings',
    }),
    // updateDialogWidth() {
    //   // TODO: сделать возможность прокидывать кастомный dialogWidth
    //   if (window.innerWidth > 1200) this.dialogWidth = '70%';
    //   else if (window.innerWidth > 500) this.dialogWidth = '73%';
    //   else this.dialogWidth = '98%';
    //   VModal.event.$emit('resize');
    // },
  },
  data() {
    return { dialogWidth: '70%' };
  },
};
</script>
