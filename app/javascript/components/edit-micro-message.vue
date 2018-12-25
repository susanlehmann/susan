<template lang="jade">
.row
  common
  alerts(ref="alerts")
  .col-3
  .col-6
    .space3
    h2 {{ $t('update_your_message') }}:
    .space3
    textarea.form-control(placeholder="Write something on the blockchain", v-model="editedMessage")
    .space3
    b-button(:disabled="loading", variant="primary", :block="true", @click="sendUpdate()", size="lg")
      span(v-if="loading")
        i.fa.fa-spinner.fa-pulse.mr-2
      | {{ $t('update') }}
    p.mt-3(v-if="message")
      a(:href="'/messages/'+message.id") {{ $t('go_back') }}
</template>

<script>
import batchEvents from '../libs/batch-events';

export default {
  props: [
    'message'
  ],
  data() {
    return {
      currentUser: null,
      editedMessage: null,
      loading: false,
    }
  },
  methods: {
    async sendUpdate () {
      console.log("sending")
      this.loading = true;
      try {
        const result = await $.ajax({
          url: `/messages/${this.message.id}`,
          method: 'PUT',
          data: { body: this.editedMessage }
        });

        batchEvents.triggerNewBatch();
        const link = `<br/><a href="/messages/${this.message.id}">this.$t('view_message')</a>`;
        this.alertSuccess(this.$t('successfully_updated'), { text: link });
      } catch (error) {
        console.log(error);
        this.alertError(this.$t('errors_update_message'));
      }
      this.loading = false;
    },
    messageUpdateSuccess(message) {
      console.log(message);
    }
  },
  mounted() {
    this.currentUser = window.currentUser;
    this.editedMessage = this.message.body;
  }
}
</script>

<style lang="sass" scoped>

</style>
