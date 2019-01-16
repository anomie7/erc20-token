pragma solidity ^0.5.0;

import "./SafeMath.sol";

contract SafeMathMock {
  using SafeMath for uint256;

  constructor() public {
  }

  function add(uint256 a, uint256 b) public pure returns (uint256) {
    return a.add(b);
  }

  function sub(uint256 a, uint256 b) public pure returns (uint256) {
    return a.sub(b);
  }
}
