pragma solidity ^0.5.0;

contract Private { 
    bytes32 public x; 
    function setX(bytes32 _x) public { 
        x = _x; 
    }
}