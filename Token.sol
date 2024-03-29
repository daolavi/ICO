pragma solidity ^0.4.23;

contract Token {
    string internal _symbol;
    string internal _name;
    uint8 internal _decimals;
    uint internal _totalSupply = 1000;
    mapping (address => uint) internal _balanceOf;
    mapping (address => mapping (address => uint)) internal _allowances;
    
    constructor(string symbol, string name, uint8 decimals, uint totalSupply) public {
        _symbol = symbol;
        _name = name;
        _decimals = decimals;
        _totalSupply = totalSupply;
    }
    
    function name() external view returns (string) {
        return _name;
    }
    
    function symbol() external view returns (string) {
        return _symbol;
    }
    
    function decimals() external view returns (uint8) {
        return _decimals;
    }
    
    function totalSupply() external view returns (uint) {
        return _totalSupply;
    }
    
    function balanceOf(address _addr) external view returns (uint);
    function transfer(address _to, uint _value) external returns (bool);
    event Transfer(address indexed _from, address indexed _to, uint _value);
}