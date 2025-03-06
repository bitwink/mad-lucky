// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IAave {
    function deposit(address asset, uint256 amount, address onBehalfOf, uint16 referralCode) external;
}
