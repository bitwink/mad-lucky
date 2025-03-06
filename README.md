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
  - `LotteryPool.sol`: Core logic for ticket sales and winner selection.  
  - `RegularLotteryPool.sol`: Manages the regular pool.  
  - `AILotteryPool.sol`: Handles AI-driven investments for the AI pool.  
- **AI Agent**:  
  - Runs off-chain using **elizaOS** and interacts with the blockchain via Web3.js.  
- **Frontend**:  
  - A React-based interface for buying tickets and viewing pool details.

## Installation
Clone the repository:
```bash
git clone https://github.com/bitwink/mad-lucky.git
```

Install dependencies:
```bash
npm install
```

## Usage

### Deploying Smart Contracts
Deploy the contracts to Monada Testnet using Hardhat:
```bash
npx hardhat run scripts/deploy.js --network monadaTestnet
```

### Running the AI Agent
Start the AI agent to manage investments:
```bash
node ai-agent/index.js
```

### Launching the Frontend
Run the React frontend locally:
```bash
cd frontend && npm start
```

## Testing
Run smart contract unit tests with Hardhat:
```bash
npx hardhat test
```

Simulate AI agent investment strategies on Monada Testnet using test funds.

Test frontend ticket purchasing and pool interactions via the local interface.

## Contribution
We welcome contributions! Feel free to submit a pull request or open an issue with your ideas.

## License
This project is licensed under the MIT License.
