var BloBlo = artifacts.require("BloBlo");

module.exports = function (deployer, network, accounts) {
  deployer.deploy(BloBlo);
};