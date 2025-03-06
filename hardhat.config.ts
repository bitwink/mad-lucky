import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox-viem";
import "@nomicfoundation/hardhat-toolbox";
import { vars } from "hardhat/config";

const config: HardhatUserConfig = {
  solidity: "0.8.28",
  networks: {
    monadTestnet: {
      url: vars.get("MONAD_RPC_URL"),
      accounts: [vars.get("PRIVATE_KEY")],
      chainId: Number(vars.get("MONAD_CHAIN_ID")),
    },
  },
};

export default config;