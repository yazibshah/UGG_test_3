// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract EmpressToken is ERC20 {
    address public owner;
    uint256 public tokenPrice; // Price of 1 EMP in Ether
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    constructor() ERC20("Empress Token", "EMP") {
        owner = msg.sender;
        tokenPrice = 1 ether;
    }

    receive() external payable {
        uint256 empAmount = (msg.value * 10**18) / tokenPrice; // Calculate EMP amount based on the sent value and token price
        require(empAmount > 0, "Insufficient funds for minting");
        _mint(msg.sender, empAmount); // Mint EMP tokens to sender
    }

    function setTokenPrice(uint256 newPrice) external onlyOwner {
        tokenPrice = newPrice;
    }

    function unwrap(uint256 amount) external {
        require(amount > 0 && amount <= balanceOf(msg.sender), "Invalid amount");
        uint256 ethAmount = (amount * tokenPrice) / 10**18; // Calculate ETH amount based on the token amount and token price
        _burn(msg.sender, amount); // Burn EMP tokens from sender
        payable(msg.sender).transfer(ethAmount); // Send ETH to sender
    }
}
