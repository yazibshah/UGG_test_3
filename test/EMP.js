// SPDX-License-Identifier: MIT
const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("EmpressToken", function () {
  let owner;
  let addr1;
  let addr2;
  let tokenContract;

  before(async function () {
    [owner, addr1, addr2] = await ethers.getSigners();

    tokenContract = await ethers.deployContract("EmpressToken");
     
  });

  it("Should have correct initial state", async function () {
    expect(await tokenContract.name()).to.equal("Empress Token");
    expect(await tokenContract.symbol()).to.equal("EMP");
    expect(await tokenContract.decimals()).to.equal(18);
    expect(await tokenContract.owner()).to.equal(owner.address);
    expect(await tokenContract.tokenPrice()).to.equal(ethers.parseEther("1"));
  });

  it("Should mint EMP tokens when ETH is sent", async function () {
    const initialBalance = await tokenContract.balanceOf(addr1.address);
    const ethToSend = ethers.parseEther('1') // Sending 1 ETH
    await addr1.sendTransaction({ to: tokenContract.address, value: ethToSend });
    const finalBalance = await tokenContract.balanceOf(addr1.address);
    expect(tokenContract.balanceOf(addr1.address)).to.equal(finalBalance); // 1 ETH should mint 1 EMP token
  });

  it("Should unwrap EMP tokens and return ETH", async function () {
    const initialBalance = await ethers.provider.getBalance(addr1.address);
    const empToUnwrap = ethers.parseEther("1"); // Unwrapping 1 EMP token
    await tokenContract.unwrap(empToUnwrap);
    const finalBalance = await ethers.provider.getBalance(addr1.address);
    expect(finalBalance.sub(initialBalance)).to.equal(empToUnwrap);
  });

  it("Should allow owner to update token price", async function () {
    const newPrice = ethers.utils.parseEther("2"); // New token price: 2 ETH
    await tokenContract.connect(owner).setTokenPrice(newPrice);
    expect(await tokenContract.tokenPrice()).to.equal(newPrice);
  });

  it("Should revert if non-owner tries to update token price", async function () {
    const newPrice = ethers.parseEther("3"); // Attempted new token price
    await expect(tokenContract.connect(addr1).setTokenPrice(newPrice)).to.be.revertedWith("Only the owner can call this function");
  });

});
