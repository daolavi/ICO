pragma solidity ^0.4.23;

import "./ERC20.sol";
import "./ERC223.sol";
import "./ERC223ReceivingContract.sol";
import "./Token.sol";

contract TCRToken is Token("TCR", "TechCafeRun", 18, 1000), ERC20, ERC223{

    constructor() public{
        _balanceOf[msg.sender] = _totalSupply;
    }

    function balanceOf(address addr) external view returns (uint){
        return _balanceOf[addr];
    }

    function transfer(address to, uint value) external returns (bool){
        if (value > 0 && 
            value <= _balanceOf[msg.sender] &&
            isContract(to)){
            _balanceOf[msg.sender] -= value;
            _balanceOf[to] += value;
            emit Transfer(msg.sender, to, value);
            return true;
        }
        return false;
    }

    function transfer(address to, uint value, bytes data) external returns (bool){
        if (value > 0 && 
            value <= _balanceOf[msg.sender] &&
            isContract(to)){
            _balanceOf[msg.sender] -= value;
            _balanceOf[to] += value;
            ERC223ReceivingContract _contract = ERC223ReceivingContract(to);
            _contract.tokenFallback(msg.sender, value, data);
            emit Transfer(msg.sender, to, value, data);
            return true;
        }
        return false;
    }

    function isContract(address addr) private view returns (bool){
        uint codeSize;
        assembly{
            codeSize := extcodesize(addr)
        }
        return codeSize > 0;
    }

    function transferFrom(address from, address to, uint value) external returns (bool){
        if (_allowances[from][msg.sender] > 0 &&
            value > 0 &&
            _allowances[from][msg.sender] >= value){
            _balanceOf[from] -= value;
            _balanceOf[to] += value;
            _allowances[from][msg.sender] -= value;
            emit Transfer(from, to, value);
            return true;
        }
        return false;
    }

    function approve(address spender, uint value) external returns (bool success){
        _allowances[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    function allowance(address owner, address spender) external view returns (uint remaining){
        return _allowances[owner][spender];
    }

    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
}