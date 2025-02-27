// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

contract HelloWord {
    string name;

    constructor() {
        name = 'web3';
    }

    function getName() public view returns(string memory) {
        return name;
    }

    function setName(string memory _nane) public {
        name = _nane;
    }
}
