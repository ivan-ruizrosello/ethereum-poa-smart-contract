pragma solidity ^0.5.0;

contract SSPermissions {
 address alice = 0xcF13C2a66e2D99696eF5d8cb9E835B5E6d83C1C8;
 address bob = 0x36DFacb13c4985a1DE236B57394D4B3745eeE507;

 /// Both Alice and Bob can access any document
 function checkPermissions(address user, bytes32 document) public view returns (bool) {
  if (user == alice || user == bob) return true;
  return false;
 }
}