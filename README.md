# DOLAToken Smart Contract

The DOLAToken smart contract is an ERC20-compatible token deployed on the Binance Smart Chain (BSC). It allows users to mint DOLA tokens against two different collateral options: ROI tokens and BDOLA tokens. The contract also supports burning DOLA tokens to redeem the equivalent amount of ROI tokens or BDOLA tokens based on the selected collateral.

## Contracts

- **DOLAToken.sol**: Implements the DOLAToken contract, allowing users to mint DOLA tokens against ROI or BDOLA collateral and burn DOLA tokens to redeem ROI or BDOLA tokens.

- **ROIToken.sol**: Implements the ROIToken contract, an ERC20-compatible token serving as collateral for minting DOLA tokens.

- **BDOLAToken.sol**: Implements the BDOLAToken contract, an ERC20-compatible token serving as collateral for minting DOLA tokens.




# Empress Token

Empress Token is an ERC20-compliant token implemented on the Ethereum blockchain. It provides a mechanism for wrapping Ether (ETH) into EMP tokens and unwrapping EMP tokens back into ETH. This token can be used for various purposes such as decentralized finance (DeFi) applications, payments, and more.

## Contract Overview

- **Contract Name**: EmpressToken
- **Token Symbol**: EMP
- **Token Name**: Empress Token
- **Decimal**: 18

## Features

- **Wrapping ETH**: Users can send ETH to the contract address, and the contract will mint EMP tokens based on the sent value and the current token price.
- **Unwrapping EMP**: Users can call the `unwrap` function to burn EMP tokens and receive ETH in exchange based on the current token price.
- **Updating Token Price**: Only the owner can update the token price using the `setTokenPrice` function.


## Installation

1. Clone the repository:
https://github.com/yazibshah/UGG_test_3

2. Install dependencies:
    npm i 

2. Run the tests:
    npx hardhat test test/DOLA.js
    npx hardhat test test/EMP.js

## Test Cases

Test cases for the DOLAToken contract are located in the `test/` directory. They cover various scenarios such as minting DOLA tokens with ROI or BDOLA collateral, burning DOLA tokens to redeem ROI or BDOLA tokens, etc.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
