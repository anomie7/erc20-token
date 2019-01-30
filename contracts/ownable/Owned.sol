pragma solidity ^0.5.0;

import "./Ownable.sol";

contract Owned is Ownable{

 function transferOwnership(address newOwner) public {
     _transferOwnership(newOwner);
    }
}
