/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: {
    version: "0.8.24",
    settings: {
      optimizer: false
    }
  },
  paths: {
    sources: "./test",
  }
};
