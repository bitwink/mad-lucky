#!/bin/bash
# 创建智能合约文件
cat <<EOL > contracts/LotteryPool.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract LotteryPool {
    address public owner;
    mapping(address => uint256) public playerTickets;
    uint256 public totalPool;

    constructor() {
        owner = msg.sender;
    }

    function buyTicket() external payable {
        require(msg.value > 0, "Must send ETH to buy a ticket");
        playerTickets[msg.sender] += msg.value;
        totalPool += msg.value;
    }
}
EOL

cat <<EOL > contracts/RegularLotteryPool.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./LotteryPool.sol";

contract RegularLotteryPool is LotteryPool {
    // Regular pool-specific logic can be added here
}
EOL

cat <<EOL > contracts/AILotteryPool.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./LotteryPool.sol";

contract AILotteryPool is LotteryPool {
    address public aiAgent;

    modifier onlyAI Agent() {
        require(msg.sender == aiAgent, "Only AI agent can call");
        _;
    }

    constructor(address _aiAgent) {
        aiAgent = _aiAgent;
    }

    // Example investment function (to be expanded)
    function invest(uint256 amount) external onlyAI Agent {
        // Placeholder for investment logic
    }
}
EOL

# 创建接口文件（示例：Aave 接口）
cat <<EOL > interfaces/IAave.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IAave {
    function deposit(address asset, uint256 amount, address onBehalfOf, uint16 referralCode) external;
}
EOL

# 创建 Hardhat 配置文件
cat <<EOL > hardhat.config.js
require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

module.exports = {
  solidity: "0.8.20",
  networks: {
    monadaTestnet: {
      url: process.env.MONADA_TESTNET_RPC || "https://monada-testnet-rpc-url",
      chainId: 1234, // Replace with actual Monada Testnet chain ID
      accounts: process.env.PRIVATE_KEY ? [process.env.PRIVATE_KEY] : [],
    },
  },
};
EOL

# 创建部署脚本
cat <<EOL > scripts/deploy.js
async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("Deploying contracts with:", deployer.address);

  const LotteryPool = await ethers.getContractFactory("LotteryPool");
  const lotteryPool = await LotteryPool.deploy();
  await lotteryPool.deployed();
  console.log("LotteryPool deployed to:", lotteryPool.address);

  const RegularLotteryPool = await ethers.getContractFactory("RegularLotteryPool");
  const regularPool = await RegularLotteryPool.deploy();
  await regularPool.deployed();
  console.log("RegularLotteryPool deployed to:", regularPool.address);

  const AILotteryPool = await ethers.getContractFactory("AILotteryPool");
  const aiPool = await AILotteryPool.deploy(deployer.address); // Using deployer as AI agent for now
  await aiPool.deployed();
  console.log("AILotteryPool deployed to:", aiPool.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
EOL

# 创建 AI 代理相关文件
cat <<EOL > ai-agent/index.js
const Web3 = require("web3");
const config = require("./config/monada-testnet.json");

const web3 = new Web3(config.rpcUrl);

console.log("AI Agent running on:", config.chainId);
EOL

cat <<EOL > ai-agent/config/monada-testnet.json
{
  "chainId": 1234,
  "rpcUrl": "https://monada-testnet-rpc-url",
  "contractAddress": "0x..."
}
EOL

# 初始化前端（使用 create-react-app）
npx create-react-app frontend

# 创建 .env 文件模板
cat <<EOL > .env
PRIVATE_KEY=your_private_key
MONADA_TESTNET_RPC=https://monada-testnet-rpc-url
EOL

# 创建 README 文件
cat <<EOL > README.md
# Mad-Lucky

## Introduction
Mad-Lucky is a decentralized lottery DApp that fuses traditional lottery mechanics with AI-powered investment strategies. Players can join one of two pools: a **Regular Lottery Pool** with a fixed prize or an **AI Lottery Pool**, where an AI agent grows the prize pool by investing in DeFi protocols or executing trading strategies. Initially developed on the **Monada Testnet**, Mad-Lucky is fully compatible with all EVM-based chains and will launch on the **Monada Mainnet** upon its release.

## Features
- **Lottery Pools**:  
  - **Regular Pool**: A standard lottery with fixed rewards and random winner selection.  
  - **AI Pool**: An enhanced pool where the AI dynamically increases the prize through investments.  
- **AI Agent**:  
  - Built on the **elizaOS** framework.  
  - Supports low-risk (e.g., lending), medium-risk (e.g., liquidity provision), and high-risk (e.g., trading) strategies.  
- **Fairness & Transparency**:  
  - Random winner selection powered by **Chainlink VRF**.  
  - All operations are fully transparent and recorded on the blockchain.  
- **Cross-Chain Support**:  
  - Compatible with Ethereum, Polygon, BSC, and other EVM chains.

## Architecture
- **Smart Contracts**:  
  - \`LotteryPool.sol\`: Core logic for ticket sales and winner selection.  
  - \`RegularLotteryPool.sol\`: Manages the regular pool.  
  - \`AILotteryPool.sol\`: Handles AI-driven investments for the AI pool.  
- **AI Agent**:  
  - Runs off-chain using **elizaOS** and interacts with the blockchain via Web3.js.  
- **Frontend**:  
  - A React-based interface for buying tickets and viewing pool details.

## Installation
Clone the repository:
\`\`\`bash
git clone https://github.com/bitwink/mad-lucky.git
\`\`\`

Install dependencies:
\`\`\`bash
npm install
\`\`\`

Set up environment variables in \`.env\` (e.g., private keys, RPC URLs). Example:
\`\`\`bash
PRIVATE_KEY=your_private_key
MONADA_TESTNET_RPC=https://monada-testnet-rpc-url
\`\`\`

## Usage

### Deploying Smart Contracts
Deploy the contracts to Monada Testnet using Hardhat:
\`\`\`bash
npx hardhat run scripts/deploy.js --network monadaTestnet
\`\`\`

### Running the AI Agent
Start the AI agent to manage investments:
\`\`\`bash
node ai-agent/index.js
\`\`\`

### Launching the Frontend
Run the React frontend locally:
\`\`\`bash
cd frontend && npm start
\`\`\`

## Testing
Run smart contract unit tests with Hardhat:
\`\`\`bash
npx hardhat test
\`\`\`

Simulate AI agent investment strategies on Monada Testnet using test funds.

Test frontend ticket purchasing and pool interactions via the local interface.

## Contribution
We welcome contributions! Feel free to submit a pull request or open an issue with your ideas.

## License
This project is licensed under the MIT License.
EOL

# 安装 Web3.js 用于 AI 代理
npm install web3

# 添加 .gitignore 文件
cat <<EOL > .gitignore
node_modules/
.env
dist/
EOL

