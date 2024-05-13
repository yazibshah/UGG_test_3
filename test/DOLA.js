// test/DOLAToken.test.js
const { expect } = require("chai");

describe("DOLAToken", function () {
  let ROIToken;
  let roIToken;
  let BDOLAToken;
  let bdolaToken;
  let DOLAToken;
  let dolaToken;
  let owner;
  let addr1;
  let addr2;
  let addrs;

  beforeEach(async function () {
    [owner, addr1, addr2, ...addrs] = await ethers.getSigners();

    // Deploy ROIToken contract
    roIToken = await ethers.deployContract("ROIToken");
    // Deploy BDOLAToken contract
    bdolaToken = await ethers.deployContract("BDOLAToken");
    // Deploy DOLAToken contract
    dolaToken = await ethers.deployContract("DOLAToken");
    
  });

  it("Should mint DOLA tokens with ROI collateral", async function () {
    const amount = 100;
    await dolaToken.mintWithROI(amount);
    const balance = await dolaToken.balanceOf(owner.address);
    expect(balance).to.equal(amount / 10);
  });

  it("Should mint DOLA tokens with BDOLA collateral", async function () {
    const amount = 50;
    await dolaToken.mintWithBDOLA(amount);
    const balance = await dolaToken.balanceOf(owner.address);
    expect(balance).to.equal(amount / 5);
  });

  it("Should burn DOLA tokens and return ROI tokens", async function () {
    const initialDolaBalance = await dolaToken.balanceOf(owner.address);
    const initialROIBalance = await dolaToken.balanceOf(owner.address);
    const dolaToBurn = 10;
    await dolaToken.burnByROI(dolaToBurn);
    const finalDolaBalance = await dolaToken.balanceOf(owner.address);
    const finalROIBalance = await dolaToken.balanceOf(owner.address);
    expect(finalDolaBalance).to.equal(initialDolaBalance - dolaToBurn);
    expect(finalROIBalance - initialROIBalance).to.equal(dolaToBurn * 10);
  });

  it("Should burn DOLA tokens and return BDOLA tokens", async function () {
    const initialDolaBalance = await dolaToken.balanceOf(owner.address);
    const initialBDolaBalance = await dolaToken.balanceOf(owner.address);
    const dolaToBurn = 5;
    await dolaToken.burnByBDola(dolaToBurn);
    const finalDolaBalance = await dolaToken.balanceOf(owner.address);
    const finalBDolaBalance = await dolaToken.balanceOf(owner.address);
    expect(finalDolaBalance).to.equal(initialDolaBalance - dolaToBurn);
    expect(finalBDolaBalance - initialBDolaBalance).to.equal(dolaToBurn * 5);
  });
});
