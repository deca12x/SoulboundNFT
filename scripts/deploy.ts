import { ethers } from "hardhat";

async function main() {
  const certifiedBuilderFactory = await ethers.getContractFactory(
    "CertifiedBuilder"
  );
  const certifiedBuilder = await certifiedBuilderFactory.deploy();
  const certifiedBuilderReceipt = await certifiedBuilder.waitForDeployment();
  const certifiedBuilderAddress = await certifiedBuilder.getAddress();
  console.log(
    "Certified Builder Contract deployed to:",
    certifiedBuilderAddress
  );

  const mintTx = await certifiedBuilder.mint(2);
  const mintReceipt = await mintTx.wait();
  console.log("Mint tx receipt", mintReceipt);

  const airdropTx = await certifiedBuilder.airdrop([
    "0x04c5697Ab48a0DEC80770d008C1657b7108A7e2b",
    "0x82A29547CA8970c2aDECF4C2db7e364339f9a4B7",
  ]);
  const airdropReceipt = await airdropTx.wait();
  console.log("Airdrop tx receipt: ", airdropReceipt);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
