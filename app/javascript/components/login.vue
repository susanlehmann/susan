<template>
<div class="limiter">
  <div class="container-login100">
    <alerts ref="alerts"></alerts>
    <notifications group="login-error" :duration="10000"></notifications>
    <notifications group="login-success" :duration="10000"></notifications>
    <div class="wrap-login100 p-l-55 p-r-55 p-t-65 p-b-54">
      <div v-if="enabled">
        <div v-if="address">
          <form class="login100-form validate-form">
            <span class="login100-form-title p-b-49">
              {{ $t('login_ethereum') }}
            </span>
            <p v-if="pendingSignature">{{ $t('sent_request_sign') }}</p>
            <p v-else-if="loadingLogIn"><i class="fa fa-spinner fa-pulse mr-2"></i>{{ $t('logging_you') }}</p>
            <div class="wrap-input100 validate-input m-b-23">
              <span class="label-input100">{{ $t('address') }}</span>
              <input class="disabled form-control" type="text" v-model="address" disabled="disabled"/>          
            </div>
          </form>        
          <div class="container-login100-form-btn">
            <div class="wrap-login100-form-btn">
              <b-button variant="success" v-on:click="sign" :block="true">{{ $t('sign_in') }}</b-button>
            </div>
          </div>
        </div>
        <div v-else="v-else">
          <p class="text-center mt-1">{{ $t('metamask_locked')}}</p>
        </div>
      </div>
      <div v-else="v-else">
        <p class="text-center">{{ $t('use_web3')}}</p>
        <div class="text-center mt-1" v-if="isMobile">
          <p>{{ $t('mobile_app') }}:</p>
          <div class="card mt-2">
            <a class="card-body text-left" href="http://www.toshi.org/" target="_blank">
              <div class="row">
                <div class="col-4">
                  <img class="img-fluid rounded" src="/toshi.png" title="Toshi"/>
                </div>
                <div class="col-8"><h4 class="mt-3">Toshi</h4>
                </div>
              </div>
            </a>
          </div>
          <div class="card mt-2">
            <a class="card-body text-left" href="https://trustwalletapp.com/" target="_blank">
              <div class="row">
                <div class="col-4"><img class="img-fluid rounded" src="/trust.jpg" title="Trust"/></div>
                <div class="col-8"><h4 class="mt-3">Trust</h4></div>
              </div>
            </a>
          </div>
        </div>
        <div>
          <p>
            {{ $t('noti_metamask1')}}
            {{ $t('noti_metamask2')}}
          </p>
          <div class="mt-3"></div><a href="https://metamask.io" target="_blank"><img class="img-fluid" src="/metamask.png" title="MetaMask"/></a>
        </div>
      </div> 
    </div>
  </div>
</div>
</template>

<script>
import metamask from '../libs/metamask';

export default {
  data() {
    return {
      address: null,
      account: null,
      enabled: metamask.enabled,
      locked: false,
      pendingSignature: false,
      loadingLogIn: false,
    };
  },
  mounted() {
    if (this.enabled) {
      metamask.getAccount(this.accountCallback);
    }
  },
  methods: {
    accountCallback(address) {
      this.address = address;
    },
    async uploadSignature(signature) {
      this.loadingLogIn = true;
      try {
        const account = await $.ajax({
          url: '/auth/sign',
          dataType: 'json',
          data: {
            signature: signature,
            address: this.address
          }
        });
        console.log('logged in!', account);
        this.account = account;
        this.alertSuccess("You've been logged in!");

        if (account.aasm_state == 'draft') {
          document.location = `/u/${account.hash_address}/edit`;
        } else {
          document.location = '/';
        }
      } catch (error) {
        console.log(error);
        this.alertError(this.$t('unable_signature'));
      }
      this.loadingLogIn = false;
    },
    sign() {
      console.log('signing');
      this.pendingSignature = true;
      metamask.sign('bloblo', (error, signature) => {
        this.pendingSignature = false;
        if (error) {
          console.log(error);
          this.alertError(this.$t('unable_signature1'));
        } else {
          this.uploadSignature(signature);
        }
      });
    }
  },
  computed: {
    isMobile() {
      return /iPhone|iPad|iPod|Android/i.test(navigator.userAgent);
    }
  }
};
</script>

<style lang="scss" scoped>
.change{
  margin-top: 200px;
}

</style>
