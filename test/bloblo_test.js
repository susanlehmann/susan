const BloBlo = artifacts.require("BloBlo");
const { web3 } = BloBlo;
const util = require('util');
const { randomHex, logGasEstimate, assertEvent } = require('./helpers')

contract('BloBlo', function (accounts) {
  it('fires an event', async () => {
    const BloBlo = await BloBlo.deployed();
    let hash = await randomHex();
    await BloBlo.newBatch(hash, { from: accounts[0] });
    await assertEvent(BloBlo, { event: 'NewBatch' });
  });

  it('estimates gas', async () => {
    const BloBlo = await BloBlo.deployed();
    let hash = await randomHex();
    const gas = await BloBlo.newBatch.estimateGas(hash, { from: accounts[3] });
    logGasEstimate(gas, 'BloBlo.newBatch');
  });
});