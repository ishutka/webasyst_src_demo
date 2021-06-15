<template>
  <span v-if="!formIsShown || parentId !== propsParentId">
    <button
      v-if="propsParentId"
      class="review-reply btn btn-xs btn-default"
      :data-cy="`respondToReviewButton_${propsParentId}`"
      @click="changeParentId(propsParentId), showForm()"
    >
      <em>ответить</em> <i class="fa fa-reply"></i>
    </button>
    <button
      v-else
      class="btn btn-primary"
      data-cy="writeReviewButton"
      @click="changeParentId(propsParentId), showForm()"
    >
      Написать отзыв
    </button>
  </span>
</template>

<script>
import { mapState, mapMutations } from 'vuex';
export default {
  props: {
    propsParentId: {
      type: Number,
      required: false,
      default: 0,
    },
  },
  computed: {
    ...mapState('postReviews', ['formIsShown', 'parentId']),
  },
  methods: {
    ...mapMutations('postReviews', ['showForm', 'changeParentId']),
  },
};
</script>
