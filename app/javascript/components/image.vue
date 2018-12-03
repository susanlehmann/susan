
<template lang="jade">
.card
  .card-body
    .row
      .col-4
        img.img-fluid.rounded-circle(:src='account.avatar.medium')
</template>

<script>
export default {
  props: [
    'account'
  ],
  data() {
    return {
      updatedBalance: null
    };
  },
  computed: {
    balance() {
      return this.updatedBalance || this.account.balance;
    },
    shortAddress() {
      const len = this.account.address.length;
      const addr = this.account.address;
      return addr.slice(0,15) + '..' + addr.slice(len-15);
    },
    isCurrentAccount() {
      return currentAccount && this.account.id == currentAccount.id;
    },
    fediverseHandle() {
      return `@${currentAccount.username}@${document.location.host}`;
    }
  }
};
</script>

<style lang="sass" scoped>

</style>
