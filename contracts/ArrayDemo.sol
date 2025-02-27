// SPDX-License-Identifier: MIT

pragma solidity >0.8.0;

contract ArrayDemo {
    uint[] public a; // 不定长
    uint[3] public b = [1,2,3]; // 定长数组(可以不给默认值)

    // function setArr(uint[3] memory _b) public {
    //     b = _b
    // }

    function getArr() public view returns(uint[3] memory) {
        return b;
    }

    // 求和
    function getSum() public view returns(uint) {
        uint sum = 0;
        for (uint i = 0; i < b.length; i++) {
            sum += b[i];
        }
        return sum;
    }

    // 修改数组项
    function changeArr(uint i, uint val) public {
        b[i] = val;
    }

    // push
    function pushArr(uint val) public {
        a.push(val);
    }
    function getA() public view returns(uint[] memory) {
       return a;
    }
}