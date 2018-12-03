const HDWalletProvider = require("truffle-hdwallet-provider");
module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!
  networks: {
    ropsten: {
      provider: function() {
        return new HDWalletProvider("praise film airport era holiday zone prosper century deal toward gap shadow", "https://ropsten.infura.io/v3/6cc791eddbed44d383edfa4a87125068");
      },
      network_id: '3',
    },
  }
};