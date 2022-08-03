// SPDX-License-Identifier:MIT

pragma solidity ^0.8.7;

contract CustomLib {
    //onwer not intialized
    //owner == address(0)
    address payable owner;

    modifier onlyBy() {
        require(msg.sender == owner);
        _;
    }

    //only onwer can destoy a contract
    function destroy() external onlyBy {
        selfdestruct(owner);
    }

    function isNotPositive(uint num) external pure returns (bool) {
        if (num > 0) {
            return true;
        } else {
            return false;
        }
    }

    function initOwner() external {
        // the owner address has not been initialized so
        //anyone can can become an owner
        if (owner == address(0)) {
            owner = payable(msg.sender);
        } else {
            revert();
        }
    }
}
