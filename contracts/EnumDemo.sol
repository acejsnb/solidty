// SPDX-License-Identifier: MIT

pragma solidity >0.8.0;

// 枚举
contract EnumDemo {
    enum State {
        Off, // 0
        On // 1
    }

    State public state;

    function getState() public view returns(State) {
        return state;
    }

    // 修改为输入的值
    function setState(State _state) public {
        state = _state;
    }

    // 修改
    function on() public {
        state = State.On;
    }

    // 修改
    function off() public {
        state = State.Off;
    }

    // 讲枚举重置为第一个值 0
    function reset() public {
        delete state;
    }
}