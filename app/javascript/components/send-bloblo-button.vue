<template lang="jade">
div(v-if="visible()")
  notifications(group="send-bloblo", :duration="-1")
  small
    a(href="javascript:;", @click="openSendModal()")
      | {{ $t('sent_bloblo_to') }} + ' ' + @{{account.username}}

  send-bloblo-modal(ref="modal",
                  :account="account"
                  @sent="(response) => { $emit('response', response) }")
</template>

<script>
// import utils from 'web3-utils';

export default {
  props: [
    'account',
  ],
  data() {
    return {
      currentUser: window.currentUser,
    }
  },
  methods: {
    openSendModal() {
      this.$refs.modal.modal.show();
    },
    visible() {
      return this.currentUser && (this.currentUser.account.id != this.account.id);
    }
  },
  async mounted() {
    if (!this.visible()) {
      return true;
    }
  }
}
</script>

<style lang="sass" scoped>

</style>

