// SPDX-License-Identifier: MIT
pragma solidity >0.8.0;

contract QCTokenContext {
    function _msgSender() internal view returns (address) {
        return msg.sender;
    }
}