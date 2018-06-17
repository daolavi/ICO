pragma solidity ^0.4.23;

interface ERC20{
    function transferFrom(address from, address to, uint value) external returns (bool);
    function approve(address spender, uint value) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint);
    event Approval(address indexed owner, address indexed spender, uint value);
}
