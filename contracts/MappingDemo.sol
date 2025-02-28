// SPDX-License-Identifier: MIT

pragma solidity >0.8.0;

contract MappingDemo {
    mapping(address => uint) balances;

    function balanceOf() external view returns (uint256) {
        return balances[msg.sender];
    }

    function setBalances(uint amount) public {
        balances[msg.sender] = amount;
    }
}