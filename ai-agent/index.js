const Web3 = require("web3");
const config = require("./config/monada-testnet.json");

const web3 = new Web3(config.rpcUrl);

console.log("AI Agent running on:", config.chainId);
