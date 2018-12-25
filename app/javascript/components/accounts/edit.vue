<template>
<div>
  <common></common>
  <alerts ref="alerts"></alerts>
  <div class="row" v-if="!account.ipfs_hash">
    <div class="col-3 d-none d-md-block"></div>
    <div class="col-md-6 col-xs-12">
      <div class="alert alert-danger mt-3 mb-3">{{ $t('alert_login_first') }}</div>
    </div>
  </div>
  <div class="limiter">
    <div class="container-login100">
      <div class="wrap-login100 p-l-55 p-r-55 p-t-65 p-b-54">
        <form class="login100-form validate-form">
          <span class="login100-form-title p-b-49">
            {{ $t('update_profile') }}
          </span>

          <div class="wrap-input100 validate-input m-b-23" >
            <span class="label-input100" for="username">{{ $t('username') }}</span>
            <input class="input100" type="text" v-model="username" name="username" v-bind:placeholder="$t('placeholder_1')"/>
          </div>

          <div class="wrap-input100 validate-input">
            <span class="label-input100"for="display_name">{{ $t('display_name') }}
              <span class="small text-muted"> Optional</span>
            </span>
            <input class="input100" type="text" v-model="display_name" name="display_name" v-bind:placeholder="$t('placeholder_2')"/>
          </div>
          
          <div class="wrap-input100 validate-input m-b-23">
            <span class="label-input100"for="bio">{{ $t('bio') }}
              <span class="small text-muted"> Optional</span>
            </span>
            <textarea class="input100" v-model="bio" name="bio" v-bind:placeholder="$t('placeholder_3')"></textarea>
          </div>

          <div class="wrap-input100 validate-input m-b-23">
            <span class="label-input100"for="location">{{ $t('location') }}
              <span class="small text-muted"> Optional</span>
            </span>
            <input class="input100" type="text" v-model="location" name="location" v-bind:placeholder="$t('placeholder_4')"/>
          </div>

          <div class="wrap-input100 validate-input m-b-23">
            <span class="label-input100"for="email">{{ $t('email_address') }}
              <span class="small text-muted"> Optional</span>
            </span>
            <input class="input100" type="email" v-model="email" name="email"/>
            <span class="small text-muted">{{ $t('noti_email_field') }}</span>
          </div>

          <div class="wrap-input100 validate-input m-b-23" >
            <span class="label-input100">{{ $t('avatar_label') }}</span>
            <p class="text-muted small">Max 2 MB.<span v-if="account.avatar &amp;&amp; account.avatar.medium"> {{ $t('account_avatar') }}</span></p>
            <vue-dropzone ref="dropzone" id="dropzone" :options="dropzoneOptions" @vdropzone-success="uploadSuccess" @vdropzone-error="uploadError"></vue-dropzone>
          </div>

          <div class="container-login100-form-btn">
            <div class="wrap-login100-form-btn">
              <div class="login100-form-bgbtn"></div>
              <b-button :block="true" variant="primary" size="lg" @click="sendUpdate">{{ $t('update') }}</b-button>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
</template>

<script>
import vue2Dropzone from 'vue2-dropzone';
import 'vue2-dropzone/dist/vue2Dropzone.css';
import batchEvents from '../../libs/batch-events';

export default {
  data() {
    return {
      account: currentAccount,
      dropzoneOptions: {
        url: "/upload_avatar",
        maxFileSize: 2,
        addRemoveLinks: true
      },
      avatar_ipfs_hash: currentAccount.avatar_ipfs_hash,
      username: currentAccount.username,
      display_name: currentAccount.display_name,
      bio: currentAccount.bio,
      location: currentAccount.location,
      email: currentAccountEmail,
    };
  },
  components: {
    vueDropzone: vue2Dropzone
  },
  mounted() {
    
  },
  methods: {
    uploadSuccess(file, response) {
      console.log(file, response);
      const json = JSON.parse(response);
      this.avatar_ipfs_hash = json.ipfs_hash;
      const { dropzone } = this.$refs.dropzone;
      while (dropzone.files.length > 1) {
        dropzone.removeFile(dropzone.files[0]);
      }
      this.alertSuccess(this.$t('success_upload_image'));
    },
    uploadError(file, data, xhr) {
      console.log(file, data, xhr);
      let message = this.$t('error_update_avatar');
      try {
        message = JSON.parse(data).message;
      } catch (error) { 
        console.log(error);
      }
      this.$refs.dropzone.removeAllFiles();
      this.alertError(message);
    },
    async sendUpdate() {
      console.log("sending data", this);
      const data = {
        username: this.username,
        bio: this.bio,
        location: this.location,
        avatar_ipfs_hash: this.avatar_ipfs_hash,
        display_name: this.display_name,
        email: this.email,
      };

      try {
        await $.ajax({
          url: `/u/${this.account.hash_address}`,
          method: 'put',
          dataType: 'json',
          data: { account: data },
        });
        batchEvents.triggerNewBatch();
        this.alertSuccess(this.$t('noti_update_info'));
        document.location = "/";
      } catch (error) {
        console.log(error);
        let message = this.$t('error_update');
        if (error.responseJSON && error.responseJSON.errors) {
          message += `: ${error.responseJSON.errors[0]}`;
        }
        this.alertError(message);
      }
    }
  }
};
</script>

<style lang="sass" scoped>

</style>
