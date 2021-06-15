<template>
  <div>
    <ul class="nav nav-tabs">
      <li
        v-for="tab in tabs"
        :key="tab.name"
        :class="{ active: tab.name === currentTab }"
        @click="currentTab = tab.name"
      >
        <a>
          <span class="glyphicon glyphicon-export"></span>
          {{ tab.title }}
        </a>
      </li>
    </ul>

    <div class="tab-content">
      <div v-for="tab in tabs" :key="tab.name">
        <partnership-form
          v-show="tab.name === currentTab"
          :tab="tab"
        ></partnership-form>
      </div>
    </div>
  </div>
</template>
<script>
import partnershipForm from './partnershipForm.vue';
export default {
  components: { partnershipForm },
  data() {
    return {
      currentTab: 'dealer',
      tabs: [
        { name: 'dealer', title: 'Я дилер' },
        { name: 'provider', title: 'Я поставщик' },
      ],
    };
  },
};
</script>

<style>
.nav.nav-tabs li {
  font-size: 21px;
}
.form_outer .img-responsive {
  height: 16px;
  display: inline;
}
.form_outer {
  padding: 20px 0px;
}
</style>
