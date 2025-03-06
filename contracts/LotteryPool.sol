// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract LotteryPool {
    address public owner;
    mapping(address => uint256) public playerTickets;
    uint256 public totalPool;

    constructor() {
        owner = msg.sender;
    }

    function buyTicket() external payable {
        require(msg.value > 0, "Must send ETH to buy a ticket");
        playerTickets[msg.sender] += msg.value;
        totalPool += msg.value;
    }
}
