const eth = require('ethjs-abi');
const _ = require('underscore');

const BloBloContract = require(`../../build/contracts/BloBlo.json`);

const method = _.findWhere(BloBloContract.abi, { name: 'newBatch'});
const signed = eth.encodeMethod(method, [process.argv[2]]);


console.log(signed);