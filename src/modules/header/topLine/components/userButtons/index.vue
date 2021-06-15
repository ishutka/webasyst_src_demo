<template>
  <div class="user-buttons">
    <div v-if="user.id" class="active-user">
      <!-- <span v-if="rate > 0"> 1$ = {{ rate }} грн </span> -->

      <a href="/my/">
        <!-- TODO: дефолтная картинка совсем не подходит к новому дизайну.Может заменить её на иконку src="/wa-apps/shop/themes/flip/img/avatar.svg"? -->
        <i
          v-if="user.photo"
          class=" icon16 userpic20 float-left"
          :style="{ 'background-image': `url(${user.photo})` }"
        >
        </i>
        <i v-else class="icon-004-user"></i>
        <span class="user-name">{{ user.name }}</span>
      </a>
    </div>
    <div v-else>
      <i class="icon-004-user" @click.prevent="show('modal-signin')"></i>
      <a
        href="/login/"
        class="hidden-xs loginBtn"
        @click.prevent="show('modal-signin')"
      >
        Войти
      </a>
      <span class="hidden-xs">/</span>
      <a
        href="/signup/"
        class="hidden-xs"
        @click.prevent="show('modal-register')"
      >
        Регистрация
      </a>
    </div>
  </div>
</template>

<script>
import { mapState } from 'vuex';
import modalMixin from '@/mixins/modalMixin.js';

export default {
  props: {
    rate: {
      required: true,
      type: Number,
    },
  },
  mixins: [modalMixin],
  computed: {
    ...mapState('user', ['user']),
  },
};
</script>

<style lang="scss">
@import '@/mainStylesVariables.scss';
.user-buttons {
  .user-name {
    max-width: 150px;
    white-space: nowrap;
    text-overflow: ellipsis;
    overflow: hidden;
  }
  .active-user a:hover,
  .active-user a:active {
    text-decoration: none;
  }
  .active-user a,
  .active-user {
    display: flex;
    align-items: center;
    i {
      background-size: cover;
      margin: 0;
      width: 28px;
      height: 28px;
      background-position: center;
    }
  }
  ul a,
  div:not(.wa-value) > a {
    @include link_color_animate($body_font_color, $main_brand_color);
  }
  .loginBtn + span {
    margin: 0 5px;
  }
  i.icon-004-user {
    font-size: 15px;
    margin-right: 10px;
    display: inline-flex;
    align-items: center;
  }
  @media screen and (max-width: 767px) {
    margin-right: 10px;
    .v--modal-overlay {
      form {
        padding: 0 15px 30px;
      }
      h2 {
        padding: 20px 0 10px;
      }
      h3 {
        margin-bottom: 10px;
      }
    }

    .active-user {
      i.icon-004-user {
        margin-right: 7px;
      }
    }
    i.icon-004-user {
      font-size: 30px;
      margin: 0 5px 0 15px;
      cursor: pointer;
    }
    .user-name {
      max-width: 100px;
    }
  }
}
</style>
