pragma solidity ^0.5.0;

contract SSPermissions {
  bytes32 documentKeyId = 0x244de5e246a6371ca7b2ada1fc2f9c299e8477a92e6719f987888e7e0643aa04;
  address alice = 0xcF13C2a66e2D99696eF5d8cb9E835B5E6d83C1C8;
  address bob = 0x36DFacb13c4985a1DE236B57394D4B3745eeE507;

  /// Both Alice and Bob can access the specified document
  function checkPermissions(address user, bytes32 document) public view returns (bool) {
    if (document == documentKeyId && (user == alice || user == bob) ) 
        return true;
        
    return false;
  }
}