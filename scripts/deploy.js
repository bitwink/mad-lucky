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
