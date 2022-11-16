const { ethers } = require("hardhat");

(async () => {
  const RedemptionFactory = await ethers.getContractFactory("VEFRedemption");
  let redemption = await RedemptionFactory.deploy();
  redemption = await redemption.deployed();

  console.log("Address: ", redemption.address);
})();
