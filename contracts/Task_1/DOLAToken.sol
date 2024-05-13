// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract DOLAToken is ERC20, ERC20Burnable {
    address public roiToken;
    address public bdolaToken;
    uint256 public constant ROI_TO_DOLA_RATE = 10; // 10 ROI = 1 DOLA
    uint256 public constant BDOLA_TO_DOLA_RATE = 5; // 5 BDOLA = 1 DOLA

    constructor(address _roiToken, address _bdolaToken) ERC20("DOLA", "DOLA") {
        roiToken = _roiToken;
        bdolaToken = _bdolaToken;
    }

    // Function to mint DOLA tokens against ROI collateral
    function mintWithROI(uint256 amount) external {
        require(amount > 0, "Amount must be greater than 0");
        require(IERC20(roiToken).balanceOf(tx.origin) >= amount, "Insufficient ROI balance");
        
        // Calculate DOLA tokens to mint based on ROI collateral
        uint256 dolaToMint = amount / ROI_TO_DOLA_RATE;

        // Transfer ROI tokens from sender to contract
        require(IERC20(roiToken).transferFrom(tx.origin, address(this), amount), "ROI transfer failed");

        // Mint DOLA tokens to sender
        _mint(tx.origin, dolaToMint);
    }

    // Function to mint DOLA tokens against BDOLA collateral
    function mintWithBDOLA(uint256 amount) external {
        require(amount > 0, "Amount must be greater than 0");
        require(IERC20(bdolaToken).balanceOf(tx.origin) >= amount, "Insufficient BDOLA balance");
        
        // Calculate DOLA tokens to mint based on BDOLA collateral
        uint256 dolaToMint = amount / BDOLA_TO_DOLA_RATE;

        // Transfer BDOLA tokens from sender to contract
        require(IERC20(bdolaToken).transferFrom(tx.origin, address(this), amount), "BDOLA transfer failed");

        // Mint DOLA tokens to sender
        _mint(tx.origin, dolaToMint);
    }

    // Function to burn DOLA By ROI tokens
    function burnByROI(uint256 value) public  {
        require(balanceOf(msg.sender)>=value,"You don't have funds");
        uint256 DolaBurn= value*ROI_TO_DOLA_RATE;
        require(IERC20(roiToken).balanceOf(address(this))>=DolaBurn,"Contract Don't have Funds");
        _burn(msg.sender, value);
        IERC20(roiToken).transfer(msg.sender,DolaBurn);

    }

    // Function to burn DOLA by BDola tokens
    function burnByBDola(uint256 value) external   {
        require(balanceOf(msg.sender)>=value,"You don't have funds");
        uint256 DolaBurn= value*BDOLA_TO_DOLA_RATE ;
        require(IERC20(bdolaToken).balanceOf(address(this))>=DolaBurn,"Contract Don't have Funds");
        _burn(msg.sender, value);
        IERC20(bdolaToken).transfer(msg.sender,DolaBurn);

    }
    
}
