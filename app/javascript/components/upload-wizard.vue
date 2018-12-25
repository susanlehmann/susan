<template lang="jade">
div
  alerts(ref="alerts")
  b-modal(ref="modal", title="Post to Ethereum", :ok-disabled="loading || metamaskPending", 
          ok-title="Post on Smart Contract", @ok="postOnEthereum", @cancel="cancel")
    h5 {{ $t('step_upload_ipfs')}}
    div(v-if="loading")
      p
        i.fa.fa-spin.fa-refresh
        |  {{ $t('in_progress') }}
    div(v-else)
      p 
        i.fa.fa-check
        |  {{ $t('complete') }}
      p
        | {{ $t('ipfs_link') }}
        a.mt-1.d-block.text-truncate(:href="ipfsLink", target="_blank") {{ ipfsLink }}
        a.mt-1.d-block.text-truncate(:href="ipfsGatewayLink", target="_blank") {{ ipfsGatewayLink }}

    h5 Step 2: Send to Ethereum
    p(v-if="metamaskPending")
      | {{ $t('confirm_transaction') }}
    p(v-else)
      | {{ $t('confirm_transaction1') }}
      | {{ $t('confirm_transaction2') }}

</template>

<script>
import metamask from '../libs/metamask';
import ipfs from '../libs/ipfs_utils';
import batchEvents from '../libs/batch-events';

export default {
  props: [
    'model',
  ],
  data() {
    return {
      loading: false,
      ipfsHash: null,
      address: currentAccount.hash_address,
      metamaskPending: false,
      modelData: null,
    };
  },
  methods: {
    ipfsUploadSuccess(data) {
      console.log('uploaded to ipfs', data);
      this.modelData = data;
      this.ipfsHash = data.ipfs_hash;
      this.loading = false;
    },
    show() {
      this.loading = true;
      this.$refs.modal.show();
    },
    hide() {
      this.loading = false;
      this.modelData = null;
      this.ipfsHash = null;
      this.$refs.modal.hide();
    },
    async attachTransaction(result) {
      const url = `/batches/${this.modelData.id}/attach_transaction`;

      try {
        const response = await $.ajax({
          url: url,
          method: 'post',
          dataType: 'json',
          data: {
            tx_hash: result
          }
        });
        console.log(response);
        if (this.modelData) {
          this.modelData.tx_id = response.transaction.id;
        }
        let link = `<a href="${response.transaction.url}">View Transaction</a>`;
        this.alertSuccess(this.$t('recored_transaction'), { text: link });
        batchEvents.triggerNewBatch();
      } catch (error) {
        console.log(error);
        this.alertError(this.$t('error_update_transaction'));
      }
    },
    async sendTransaction() {
      const contract = await metamask.contract();
      try {
        const result = await contract.newBatch.sendTransaction(this.ipfsBytes32, this.transactionOptions);
        console.log(result);
        await this.attachTransaction(result);
        this.alertSuccess(this.$t('success_batch'));
        this.hide();
        this.$emit('batchSuccess');
      } catch (error) {
        console.log(error);
        this.cancel();
      }
    },
    async postOnEthereum(event) {
      event.preventDefault();
      this.metamaskPending = true;
      await this.sendTransaction();
      this.metamaskPending = false;
    },
    async cancel() {
      this.loading = true;
      this.metamaskPending = false;
      try {
        await $.ajax({
          url: `/batches/${this.modelData.id}/cancel`,
          method: 'post'
        });

        batchEvents.triggerNewBatch();
        this.loading = false;
        this.alertSuccess(this.$t('cancel_batch'));
      } catch (error) {
        console.log(error);
        this.alertError(this.$t('error_batch_so_cancel'));
      }
      this.hide();
    }
  },
  computed: {
    ipfsLink() {
      return `ipfs://${this.ipfsHash}`;
    },
    ipfsGatewayLink() {
      return `${ipfsGatewayAddress}/ipfs/${this.ipfsHash}`;
    },
    ipfsBytes32() {
      return ipfs.bytes32(this.ipfsHash);
    },
    transactionOptions() {
      return { from: this.address };
    }
  },
  async mounted() { }
};
</script>

<style lang="sass" scoped>

</style>
