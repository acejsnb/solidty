// SPDX-License-Identifier: MIT

pragma solidity >0.8.0;

// 数据类型

contract DataType {
    int x = -100;
    uint x2 = 100;

    // 最大最小值
    int public minInt = type(int).min;
    int public maxInt = type(int).max;
    uint public minUint = type(uint).min;
    uint public maxUint = type(uint).max;

    address public  a = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    address public b = address(this); // 合约地址

    // payable 部署和约时消耗 gas
    // constructor() payable {}

    // 拼接字符串1
    function concat(string calldata _str1, string calldata _str2) public pure returns(string memory) {
        return string.concat(_str1, ' ', _str2);
    }
    // 拼接字符串2
    function concat_2(string calldata _str1, string calldata _str2) public pure returns(string memory) {
        return string(abi.encodePacked(_str1, ' ', _str2));
    }

    // 拼接字符串3，字符串转字节数组 bytes
    function concat2(string calldata _str1, string calldata _str2) public pure returns(bytes memory) {
        return bytes.concat(bytes(_str1), bytes(' '), bytes(_str2));
    }

    // 字节数组转字符串 bytes
    function concat3(string calldata _str1, string calldata _str2) public pure returns(string memory) {
        return string(bytes.concat(bytes(_str1), bytes(' '), bytes(_str2)));
    }

    // 获取字符串长度
    function getStrLen(string calldata _str) public pure returns(uint) {
        return bytes(_str).length;
    }

    // 字符串比较
    function compare(string calldata _str1, string calldata _str2) external pure returns(bool) {
        return keccak256(abi.encodePacked(_str1)) == keccak256(abi.encodePacked(_str2));
    }
}