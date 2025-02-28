// SPDX-License-Identifier: MIT

pragma solidity >0.8.0;

contract StructDemo {
    struct Student {
        string name;
        string gender;
        uint8 age;
        string[2] hobby;
    }

    Student student = Student('xiaogang', 'male', 18, ['swimming', 'basketball']);

    function getStu() external view returns(Student memory) {
        return student;
    }
    function setStuName(string calldata _name) external {
        student.name = _name;
    }
    function setStuHobby(uint i, string calldata hobby) external {
        student.hobby[i] = hobby;
    }
}