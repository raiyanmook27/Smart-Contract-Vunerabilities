// SPDX-License-Identifier:MIT

pragma solidity ^0.8.7;

import "./ParityBug_Library.sol";

contract VictimFundRaiser {
    mapping(address => uint) balances;

    //using an external library
    CustomLib public clb;

    function getBalance() external view returns (uint) {
        return address(this).balance;
    }

    constructor(address libAddress) {
        clb = CustomLib(libAddress);
    }

    // funds the contract
    function fund() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() external {
        //where vunnerabilty could occur
        require(clb.isNotPositive(balances[msg.sender]), "Error while sending");
        uint funds = balances[msg.sender];

        (bool sent, ) = msg.sender.call{value: funds}("");

        if (!sent) revert("Error occurred");
        // wrong code
        balances[msg.sender] = 0;
    }
}
