require("@nomicfoundation/hardhat-toolbox");

require('dotenv').config()


task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
      console.log(account.address);
  }
});

const GoerliUrl =
   process.env.ALCHEMY_API_KEY ?
      `https://eth-goerli.g.alchemy.com/v2/${process.env.ALCHEMY_API_KEY}` :
      process.env.OPTIMISM_GOERLI_URL


/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  networks: {
    "goerli": {
       url: GoerliUrl,
       accounts: { mnemonic: process.env.MNEMONIC }
    }
  }
};
