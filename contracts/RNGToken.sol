// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract RNGToken {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 private _totalSupply;
    address public tokenOwner;
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 valueis
    );

    constructor() {
        name = "RoyalNeverGiveUp";
        symbol = "RNG";
        decimals = 18;
        _totalSupply = 1000 * 10**decimals;
        balanceOf[msg.sender] = _totalSupply;
        tokenOwner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == tokenOwner, "Caller is not owner");
        _;
    }
 
    function mint(address account, uint256 amount) public onlyOwner {
        require(account != address(0));
        _totalSupply += amount;
        balanceOf[account] += amount;
        emit Transfer(address(0), account, amount);
    }

    function burn(address account, uint256 amount) public onlyOwner {
        require(account != address(0));
        require(amount <= balanceOf[account]);

        _totalSupply -= amount;
        balanceOf[account] -= amount;
        emit Transfer(account, address(0), amount);
    }

    function getBalanceOf(address owner) public view returns (uint256) {
        return balanceOf[owner];
    }

    function getAllowance(address owner, address spender)
        public
        view
        returns (uint256)
    {
        return allowance[owner][spender];
    }

    function approve(address spender, uint256 value) public returns (bool) {
        require(spender != address(0));
        allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    function increaseAllowance(address spender, uint256 addedValue)
        public
        returns (bool)
    {
        require(spender != address(0));
        allowance[msg.sender][spender] += addedValue;
        emit Approval(msg.sender, spender, allowance[msg.sender][spender]);
        return true;
    }

    function decreaseAllowance(address spender, uint256 subValue)
        public
        returns (bool)
    {
        require(spender != address(0));
        allowance[msg.sender][spender] -= subValue;
        emit Approval(msg.sender, spender, allowance[msg.sender][spender]);
        return true;
    }

    function transfer(address to, uint256 value) public returns (bool) {
        require(value > 0);
        require(value <= balanceOf[msg.sender]);
        require(to != address(0));

        balanceOf[msg.sender] -= value;
        balanceOf[to] += value;
        emit Transfer(msg.sender, to, value);
        return true;
    }

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) public returns (bool) {
        require(value <= balanceOf[from]);
        require(value <= allowance[from][msg.sender]);
        require(to != address(0));

        balanceOf[from] -= value;
        balanceOf[to] += value;
        allowance[from][msg.sender] -= value;
        emit Transfer(from, to, value);
        return true;
    }
}