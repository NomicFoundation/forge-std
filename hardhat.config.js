/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: {
    version: "0.8.24",
    settings: {
      optimizer: {enabled: false}
    }
  },
  paths: {
    sources: "./test",
  },
  solidityTest: {
    testFail: true,
    rpcEndpoints: {
      mainnet: "https://eth.merkle.io",
      optimism_sepolia: "https://sepolia.optimism.io/",
      arbitrum_one_sepola: "https://sepolia-rollup.arbitrum.io/rpc/",
      needs_undefined_env_var: "${UNDEFINED_RPC_URL_PLACEHOLDER}"
    },
    fuzz: {
      // Used to ensure deterministic fuzz execution
      seed: "0x1234567890123456789012345678901234567890",
    },
  }
};

