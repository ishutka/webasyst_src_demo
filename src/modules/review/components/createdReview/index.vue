<template>
  <div v-if="html.length" id="newCreatedReview" v-html="html"></div>
</template>

<script>
import { mapState } from 'vuex';
export default {
  props: {
    parentId: {
      required: true,
      type: Number,
    },
  },
  computed: {
    ...mapState('review', ['createdReviews']),
    html() {
      const review = this.createdReviews.find(
        review => review.parentId == this.parentId,
      );
      return (review && review.html) || '';
    },
  },
};
</script>
