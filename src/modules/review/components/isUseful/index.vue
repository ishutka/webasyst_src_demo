<template>
  <div class="pull-right review_helpful" data-cy="reviewIsUseful">
    <div v-if="requestResult === 'loading'" class="loader-wrapper">
      <img src="/wa-apps/shop/themes/flip/img/loading16.gif" />
    </div>
    <div v-if="requestResult === 'alreadyVoted'">
      Вы уже проголосовали за данный отзыв
    </div>

    <div v-else-if="requestResult === 'voted'" class="voted">
      Вы проголосовали за данный отзыв
    </div>

    <div v-else>Отзыв полезен?</div>

    <div>
      <div
        class="reviews_is_helpful"
        :data-cy="`reviewIsGoodButton_${parentId}`"
        @click="postEstimation(1)"
      >
        Да ({{ reviewIsGood || isGood }})
      </div>
      <span>|</span>
      <div
        class="reviews_is_not_helpful"
        :data-cy="`reviewIsBadButton_${parentId}`"
        @click="postEstimation(2)"
      >
        Нет ({{ reviewIsBad || isBad }})
      </div>
    </div>
  </div>
</template>

<script>
import HTTP from '../../../../plugins/http.js';

const isUseful = {
  props: {
    parentId: {
      type: Number,
      required: true,
    },
    isBad: {
      type: Number,
      default: 0,
    },
    isGood: {
      type: Number,
      default: 0,
    },
  },
  data() {
    return {
      reviewIsBad: 0,
      reviewIsGood: 0,
      requestResult: 'started',
    };
  },
  methods: {
    postEstimation(estimation) {
      if (this.requestResult === 'alreadyVoted') return;
      this.requestResult = 'loading';
      HTTP.post('/reviews/set_is_helpful/', {
        id: this.parentId,
        /* eslint-disable */
        is_helpful: estimation, 
        /* eslint-enable */
      })
        .then(({ data }) => {
          if (data.data.msg) this.requestResult = 'alreadyVoted';
          else {
            this.requestResult = 'voted';
            if (estimation == 1) this.reviewIsGood = this.isGood + 1;
            else this.reviewIsBad = this.isBad + 1;
          }
        })
        .catch(error => {
          alert(`Ошибка... Попробуйте еще раз ${error}`);
        });
    },
  },
};
export default isUseful;
</script>
<style lang="scss">
.review_helpful {
  font-size: 0.9em;
  color: #666;
  white-space: nowrap;
  line-height: 22px;
  display: flex;
  align-items: center;
  div {
    display: inline-block;
  }
  > div:first-child {
    white-space: normal;
  }
  .reviews_is_helpful {
    margin-left: 5px;
    color: #4dbe41;
  }
  .reviews_is_helpful,
  .reviews_is_not_helpful {
    text-decoration: none !important;
    border-bottom: 1px dotted;
    display: inline !important;
    white-space: nowrap;
    cursor: pointer;
  }
  .reviews_is_not_helpful {
    color: #fb515d;
  }
  span {
    margin: 0 2px;
  }
  @media screen and (max-width: 380px) {
    width: 100%;
    margin-bottom: 10px;
    text-align: left;
  }
}
</style>
