<template lang="jade">
  .container
    .row.profile
      .profile-sidebar
        .profile-userpic
          img.img-fluid.rounded-circle(:src='account.avatar.medium')
        .profile-usertitle
          .profile-usertitle-name
            a.small(:href='"/u/"+account.username') @{{ account.username }}
        .profile-userbuttons
          follow-button(:account="account")
        .profile-usermenu
          ul.nav
            li.active
              a(:href='"/u/"+account.username')
                i.fa.fa-home &nbsp&nbsp Home
            li
              a(:href='"/u/"+account.username')
                i.fa.fa-user &nbsp&nbsp Profile
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

<style lang="scss" scoped>
.nav{
  display: inline !important;
}
.profile {
  margin: 20px 0;
}

/* Profile sidebar */
.profile-sidebar {
  padding: 20px 0 10px 0;
  background: #fff;
}

.profile-userpic img {
  float: none;
  margin: 0 auto;
  width: 80%;
  height: 80%;
  -webkit-border-radius: 80% !important;
  -moz-border-radius: 80% !important;
  border-radius: 80% !important;
}

.profile-usertitle {
  text-align: center;
  margin-top: 20px;
}

.profile-usertitle-name {
  color: #5a7391;
  font-size: 16px;
  font-weight: 600;
  margin-bottom: 7px;
  display: inline-flex;
  margin-left: 35px;
}

.profile-usertitle-job {
  text-transform: uppercase;
  color: #5b9bd1;
  font-size: 12px;
  font-weight: 600;
  margin-bottom: 15px;
}

.profile-userbuttons {
  text-align: center;
  margin-top: 10px;
}

.profile-userbuttons .btn {
  text-transform: uppercase;
  font-size: 11px;
  font-weight: 600;
  padding: 6px 15px;
  margin-right: 5px;
}

.profile-userbuttons .btn:last-child {
  margin-right: 0px;
}
    
.profile-usermenu {
  margin-top: 30px;
}

.profile-usermenu ul li {
  border-bottom: 1px solid #f0f4f7;
}

.profile-usermenu ul li:last-child {
  border-bottom: none;
}

.profile-usermenu ul li a {
  color: #93a3b5;
  font-size: 14px;
  font-weight: 400;
}

.profile-usermenu ul li a i {
  margin-right: 8px;
  font-size: 14px;
}

.profile-usermenu ul li a:hover {
  background-color: #fafcfd;
  color: #5b9bd1;
}

.profile-usermenu ul li.active {
  border-bottom: none;
}

.profile-usermenu ul li.active a {
  color: #5b9bd1;
  background-color: #f6f9fb;
  border-left: 2px solid #5b9bd1;
  margin-left: -2px;
}

/* Profile Content */
.profile-content {
  padding: 20px;
  background: #fff;
  min-height: 460px;
}

</style>
