// SPDX-License-Identifier:MIT

pragma solidity ^0.8.7;

contract VictimFundRaiser {
    mapping(address => uint) balances;

    function getBalance() external view returns (uint) {
        return address(this).balance;
    }

    // funds the contract
    function fund() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() external {
        require(balances[msg.sender] > 0, "Error while sending");

        uint funds = balances[msg.sender];

        // before sending ether set caller acccount to 0 to fix
        balances[msg.sender] = 0;

        (bool sent, ) = msg.sender.call{value: funds}("");

        if (!sent) revert("Error occurred");
    }
}
