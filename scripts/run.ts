import { ethers } from "hardhat";

// run.js
const main = async () => {
  // コントラクトがコンパイルされる。
  // コントラクトを扱うために必要なファイルが `artifacts` ディレクトリの直下に生成されます。
  const nftContractFactory = await ethers.getContractFactory("MyEpicNFT");
  // Hardhat がローカルの Ethereum ネットワークを作成します。
  const nftContract = await nftContractFactory.deploy();
  // コントラクトが Mint され、ローカルのブロックチェーンにデプロイされるまで待ちます。
  await nftContract.deployed();
  console.log("Contract deployed to:", nftContract.address);
  let txn = await nftContract.makeAnEpicNFT();
  await txn.wait();
  txn = await nftContract.makeAnEpicNFT();
  await txn.wait();
};
// エラー処理を行っています。
const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};
runMain();
