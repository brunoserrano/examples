const HDWalletProvider = require("truffle-hdwallet-provider");
const fs = require("fs");
module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 8545,
      network_id: "*"
    },
    abs_assineiconsortium_assinei_assinei: {
      network_id: "*",
      gas: 0,
      gasPrice: 0,
      provider: new HDWalletProvider(fs.readFileSync('e:\\Projects\\Self\\examples\\Blockchain\\Azure\\DocSign\\AssineiProject\\Assinei\\assineiblockchainmember.env', 'utf-8'), "https://assinei.blockchain.azure.com:3200/VdfSz_Fr4LhqCb1XIAZvewSq")
    }
  }
};
