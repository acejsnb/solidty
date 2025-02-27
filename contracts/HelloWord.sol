// SPDX-License-Identifier: MIT

pragma solidity >0.8.0;

/**
    变量的储存，用于复合类型，如 string，uint 不需要
    storage 永久储存，会消耗 gas，比较贵
    memory 存在内存中，使用后会清除，消耗 gas 3，如果大于 22 个，gas 会增加
    calldata 类似 memory，比 memory 便宜，用在函数参数
    stack 保存很少的变量，免费使用
**/

/**
数据类型：
值类型：bool int uint address 定长字节数组 fixed ufixed enum function
引用类型：Array(不定长数组，字符串) struct mapping
**/

contract HelloWord {
    string name = unicode'小刚';
    event Log(address);
    event Log(string);

    constructor() {
        // name = 'web3';
    }

    function getName() public view returns(string memory) {
        return name;
    }

    function setName(string calldata _name) public {
        name = _name;
    }

    // 纯函数
    function foo() public pure returns(string memory) {
        string memory str = 'lucy';
        return str;
    }

    // 纯函数
    function num() public pure returns(uint) {
        uint x = 100;
        return x;
    }
    function boollean(uint x) public pure returns(bool) {
        if (x > 100) return true;
        return false;
    }

    // msg.sender 全局的 address 地址
    // 中文字符需要用 unicode
    function log() public {
        emit Log(msg.sender);
        emit Log(unicode'日志演示');
    }

    // external定义的函数等 只有外部可见
    function fzz() external pure returns(string memory)  {
        string memory str = 'text';
        return str;
    }
    
    // 结构体
    struct Student {
        string name;
        string gender;
        uint age;
    }
    Student public student;
    function setStudent(string calldata _name, string calldata _gender, uint _age) external {
        student.name = _name;
        student.gender = _gender;
        student.age = _age;
    }
    function getStudentName() external view returns(string memory) {
        return student.name;
    }
    /**
    require: 用于验证失败时，回退修改，返回 gas;
    revert: 用于验证失败时，回退修改，不返回 gas
    **/
    function changeGender(uint _val) external {
        require(_val == 0 || _val == 1, unicode'无效的性别');
        student.gender = _val == 0 ? unicode'女' : unicode'男';
    }
}
