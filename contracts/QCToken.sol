// SPDX-License-Identifier: MIT
pragma solidity >0.8.0;

import './QCTokenContext.sol';

contract QCToken is QCTokenContext {
    /*
    代币信息：
    代币名称 name
    代币标识 symbol
    代币小数位 decimals
    代币的总发行量 totalSupply
    代币数量 balance
    授权代币数量 allowance


    function name() public view returns (string)
    function symbol() public view returns (string)
    function decimals() public view returns (uint8)
    function totalSupply() public view returns (uint256)
    function balanceOf(address _owner) public view returns (uint256 balance)

    function transfer(address _to, uint256 _value) public returns (bool success)
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success)
    function approve(address _spender, uint256 _value) public returns (bool success)
    function allowance(address _owner, address _spender) public view returns (uint256 remaining)

    event Transfer(address indexed _from, address indexed _to, uint256 _value)
    event Approval(address indexed _owner, address indexed _spender, uint256 _value)
    */

    // 1.代币信息
    string private _name;
    string private _symbol;
    uint8 private _decimals;
    uint256 private _totalSupply;
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    // 事件
    event Transfer(address indexed from, address indexed to, uint256 amount);
    event Approval(address indexed owner, address indexed spender, uint256 amount);
 
    constructor() {
        // 2. 初始化
        _name = 'QCoin';
        _symbol = 'QC';
        _decimals = 18;
        // 初始化货币池
        _mint(_msgSender(), 100 * 10000 * (10 ** _decimals));
    }

    function _mint(address account, uint256 amount) internal {
       require(account != address(0), 'ERC20: mint to the zero address!');
       // 初始化货币数量
       _totalSupply += amount;
       // 给某个账号注入起始资金
       unchecked {
           _balances[account] += amount;
       }
    }
    function _transfer(address from, address to, uint256 amount) internal {
        require(from != address(0), 'ERC20: transfer from the zero address!');
        require(to != address(0), 'ERC20: transfer to the zero address!');

        uint fromBalance = _balances[from];
        require(fromBalance >= amount, 'ERC20: Insufficient balance!');

        unchecked {
            _balances[from] -= amount;
            _balances[to] += amount;
        }

        emit Transfer(from, to, amount);
    }

    function _approve(address owner, address spender, uint256 amount) internal {
        require(owner != address(0), 'ERC20: approve owner the zero address!');
        require(spender != address(0), 'ERC20: approve spender the zero address!');

        // 执行授权
        unchecked {
            _allowances[owner][spender] = amount;
        }

        emit Approval(owner, spender, amount);
    }

    function _spendAllowance(address owner, address spender, uint256 amount) internal {
        uint curAllowance = allowanceOf(owner, spender);
        if (curAllowance != type(uint256).max) {
            require(curAllowance >= amount, 'ERC20: Insufficient balance!');
            unchecked {
                _approve(owner, spender, curAllowance - amount);
            }
        }
    }

    // 3.取值器
    function name() public view returns(string memory) {
        return _name;
    }
    function symbol() public view returns (string memory) {
        return _symbol;
    }
    function decimals() public view returns (uint8) {
        return _decimals;
    }
    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }
    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }
    // 返回授权账户代币数量
    function allowanceOf(address owner, address spender) public view returns (uint256) {
        return _allowances[owner][spender];
    }

    // 4.函数
    // 转账
    function transfer(address to, uint256 amount) public returns (bool) {
        _transfer(_msgSender(), to, amount);
        return true;
    }

    function transferFrom(address from, address to, uint256 amount) public returns (bool) {
        address owner = _msgSender();
        _spendAllowance(from, owner, amount);
        // 执行转账
        _transfer(from, to, amount);
        return true;
    }
    // 授权代币的转发
    function approve(address spender, uint256 amount) public returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, amount);
        return true;
    }

}

// 例子：银行授权 100 给我，我提款 10，付款给卖方 80，付款给中介 10（交易中执行函数的账号就是 owner），如果我提款 需要切换账号为我自己
// 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4 相当于银行
// 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2 银行授权给我 100，我提款 10
// 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db 卖方 80
// 0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB 中介 10