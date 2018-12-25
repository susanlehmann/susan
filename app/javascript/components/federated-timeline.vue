<template lang="jade">
div
  alerts(ref="alerts")
  p.small.text-muted {{ $t('federated_timeline') }}:
  .federated-messages.mt-2(v-for='message in messages', :key="message.id")
    .card.mb-3
      .card-header
        .row
          .col-2
            img.img-fluid.img-thumbnail(:src='message.account.avatar_url', :alt='message.account.username')
          .col-10
            h5.mt-1.mb-0.text-truncate.username 
              a.text-dark(:href="message.account.federated_id", target="_blank") @{{ message.account.username }}
            small
              a.text-dark(:href="message.object_data.url", target="_blank"){{ moment(message.published).fromNow() }}
      .card-body
        .small.message-body(v-html="message.object_data.content")
  div(v-if="loading")
    p
      i.fa.fa-spinner.fa-pulse.mr-2
      | {{ $t('hang_on_federated_timeline') }}
  div(v-else-if="!finished")
    div(v-observe-visibility="bottomVisible")
  div(v-if="!loading && followsCount === 0")
    p.small {{ $t('not_follow_federated_account') }}
    p.small 
      | {{ $t('looking_federated_account') }}
      a(href="/federated/accounts/search?handle=@gargron@mastodon.social")  @gargron@mastodon.social
  div(v-else-if="finished")
    .space3
    p {{ $t('looking_continue') }}
</template>

<script>
import moment from 'moment';

export default {
  data() {
    return {
      messages: [],
      page: 1,
      loading: false,
      finished: false,
      followsCount: 0,
      lastPage: null,
      moment: moment,
    };
  },
  methods: {
    async fetch() {
      this.loading = true;

      try {
        const result = await $.ajax({
          url: '/federated/messages',
          dataType: 'json',
          type: 'get',
          data: { page: this.page }
        });

        if (result.messages.length === 0) {
          this.finished = true;
        } else {
          this.finished = result.finished;
          this.followsCount = result.federated_follows_size;
          this.messages = this.messages.concat(result.messages);
        }
      } catch (error) {
        this.alertError(this.$t('fetching_federated_timeline'));
      }

      this.loading = false;
    },
    bottomVisible(isVisible) {
      if (!this.loading && isVisible && !this.finished && (this.messages.length > 0)) {
        this.page += 1;
        this.fetch();
      }
    }
  },
  mounted() {
    this.fetch();
  }
};
</script>

<style lang="sass">
.federated-messages
  .message-body
    p
      margin-bottom: 0px
</style>
