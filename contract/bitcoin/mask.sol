// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Mask {
    address public owner;
    uint256 public totalSupply;

    event MaskCreated(address indexed user, uint256 amount);
    event MaskTransferred(address indexed from, address indexed to, uint256 amount);

    constructor() {
        owner = msg.sender;
        totalSupply = 1000; // Initial supply of masks
    }

    function createMask(uint256 amount) public {
        require(amount > 0, "Amount must be greater than 0");
        require(totalSupply >= amount, "Not enough masks available");

        totalSupply -= amount;
        emit MaskCreated(msg.sender, amount);
    }

    function transferMask(address to, uint256 amount) public {
        require(totalSupply >= amount, "Not enough masks available");
        require(msg.sender == owner, "Only owner can transfer masks");

        totalSupply -= amount;
        emit MaskTransferred(msg.sender, to, amount);
    }

    function getTotalSupply() public view returns (uint256) {
        return totalSupply;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }
}
