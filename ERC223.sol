pragma solidity ^0.4.23;

interface ERC223{
    function transfer(address to, uint value, bytes data) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint value, bytes indexed data);
}