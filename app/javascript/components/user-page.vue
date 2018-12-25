<template lang="jade">
.row.mt-2
  common
  .col-md-4.col-xs-16
    demo(:account="account")
  .col-md-5.col-xs-16
    h4 {{ $t('timeline')}} 
    <br>
    messages-list(:messages="messages")
  .col-md-3.col-xs-16
    h4 {{ $t('thread_following')}} 
    <br>
</template>

<script>
import NavTop from '../components/shared/_nav_top';
export default {
  props: [
    'account',
    'messages'
  ],
  data() {
    return {
      currentAccount: window.currentAccount
    }
  },
  methods: {
    addMessage(message) {
      // do something
    }
  },
  mounted() {
  }
}
</script>

<style lang="sass" scoped>
</style>
