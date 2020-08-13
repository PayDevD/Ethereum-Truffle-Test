const testJSON = require('../build/contracts/Vote.json');

const Web3 = require('web3');
let provider = new Web3.providers.HttpProvider('http://127.0.0.1:7545');
let web3 = new Web3(provider);
const contractAddr = "0x7A53036C6323762C86640d5A716baD70d26d0312";
const userAddress = "0x867545682917E0368c68694F01C88CB88F1eC6b0";

let ContractInstance = new web3.eth.Contract(testJSON.abi, contractAddr , {
    from: userAddress,
    gasPrice: '0'
});


ContractInstance.methods.addCandidator('alice').send();