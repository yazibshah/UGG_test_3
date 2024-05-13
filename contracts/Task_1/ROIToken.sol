// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ROIToken is ERC20 {
    address public owner;

    constructor() ERC20("ROI", "ROI") {
        owner = msg.sender;
        _mint(msg.sender, 1000000 * 10 ** uint(decimals())); // Initial supply
    }

    function mint(address account, uint256 amount) external {
        require(msg.sender == owner, "Only owner can mint");
        _mint(account, amount);
    }
}
