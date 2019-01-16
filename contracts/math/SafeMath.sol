pragma solidity ^0.5.0;


library SafeMath {
  
  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    require(c >= a);
    return c;
  }

  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    require(a >= b);
    uint256 c = a - b;
    return c;
  }
}
