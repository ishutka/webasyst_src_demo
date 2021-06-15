<template>
  <div>
    <div class="blank"></div>
    <div id="panelProductLogs" class="panel panel-default">
      <div class="panel-heading">
        Последние изменения
      </div>
      <div id="jscrollouter" class="panel-body">
        <div id="jscroll-inner">
          <div v-for="log in logs" :key="log.id" class="row" data-cy="log">
            <div class="col-xs-1 col-md-2">
              <span class="icon_event " :class="log.icon_class"></span>
            </div>
            <div class="col-xs-10">
              <div v-html="log.type_formated"></div>
              <div class="product_name">
                <a :href="log.url">{{ log.name }}</a>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div v-if="loading" class="spinner" style="text-align:center">
        <img src="@/img/loading16.gif" alt="" />
      </div>
    </div>
  </div>
</template>

<script>
import { mapActions, mapState } from 'vuex';
import debounce from 'lodash/debounce';
const logs = {
  async mounted() {
    document
      .getElementById('jscrollouter')
      .addEventListener('scroll', debounce(this.handleScrolling, 300));
  },
  computed: {
    ...mapState('productsLogs', ['logs', 'loading']),
  },
  methods: {
    ...mapActions('productsLogs', ['fetchLogs']),
    async handleScrolling() {
      const elEdge = document
        .getElementById('jscrollouter')
        .getBoundingClientRect().bottom;
      const scrolledElEdge = document
        .getElementById('jscroll-inner')
        .getBoundingClientRect().bottom;
      const delta = scrolledElEdge - elEdge;
      if (delta < 30) await this.fetchLogs();
    },
  },
};
export default logs;
</script>
<style lang="scss">
#panelProductLogs {
  position: relative;
  // }
  .spinner img {
    margin: 10px auto;
    max-height: 18px;
  }
  .spinner {
    position: absolute;
    bottom: 0;
    left: 0;
    width: 100%;
    height: 43px;
    background: #fff;
    opacity: 0.85;
  }
  .panel-body {
    position: relative;
    font-size: 0.8em;
    line-height: 100%;
    overflow: auto;
    max-height: 300px;
  }
  .row:first-child {
    border: none;
  }
  .panel-heading {
    background-image: -webkit-gradient(
      linear,
      left top,
      left bottom,
      from(#f5f5f5),
      to(#e8e8e8)
    );
    background-image: linear-gradient(to bottom, #f5f5f5 0%, #e8e8e8 100%);
    filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#fff5f5f5', endColorstr='#ffe8e8e8', GradientType=0 );
    background-repeat: repeat-x;
  }
  .row {
    border-top: 1px solid #eee;
    padding-top: 7px;
    padding-bottom: 7px;
  }
  .event_out_of_stock {
    background: url(~@/img/events/out_of_stock.gif) no-repeat 0px 0px;
  }
  .event_price_up {
    background: url(~@/img/events/price_up.gif) no-repeat 0px 0px;
  }
  .event_price_down {
    background: url(~@/img/events/price_down.gif) no-repeat 0px 0px;
  }
  .event_in_stock {
    background: url(~@/img/events/in_stock.gif) no-repeat 0px 0px;
  }
  .event_new_product {
    background: url(~@/img/events/added_new.gif) no-repeat 0px 0px;
  }
  .icon_event {
    display: inline-block;
    width: 22px;
    height: 22px;
    margin: 5px 0px 0px 0px;
  }
  .product_name {
    padding-top: 4px;
    font-weight: bold;
  }
}
</style>
