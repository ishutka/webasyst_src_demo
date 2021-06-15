<template>
  <div class="form-group row rate">
    <label class="col-xs-4   col-lg-3 control-label"> Оцените товар </label>
    <div class="col-xs-5">
      <StarRating
        class="rate"
        :star-size="12"
        :show-rating="false"
        :rating="rate"
        active-color="#ff642d"
        inactive-color="transparent"
        border-color="#ff642d"
        :border-width="1"
        style="float:left"
        @rating-selected="rateWrapper = $event"
      />
    </div>
  </div>
</template>

<script>
import StarRating from 'vue-star-rating';
import { mapState, mapMutations } from 'vuex';
const rateWidget = {
  name: 'rateWidget',
  components: {
    StarRating,
  },
  computed: {
    ...mapState('review', ['rate']),
    rateWrapper: {
      get() {
        return this.rate;
      },
      set(value) {
        this.setRate(value);
      },
    },
  },
  methods: {
    ...mapMutations('review', ['setRate']),
  },
};
export default rateWidget;
</script>
<style>
.rate .control-label {
  text-align: right;
}
.rate .rate > .vue-star-rating {
  align-items: flex-end;
}
.rate button {
  color: #333;
}
@media (max-width: 400px) {
  .rate .control-label {
    width: 100%;
    text-align: left;
  }
}
@media (min-width: 768px) {
  .rate .control-label {
    padding-top: 7px;
    margin-bottom: 0;
  }
}
</style>
