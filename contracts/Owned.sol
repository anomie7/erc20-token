pragma solidity ^0.5.0;

contract Owned {
    address public _owner;

    event TransferOwnership(address indexed oldaddr, address indexed newaddr);

    constructor () public {
      _owner = msg.sender;
      emit TransferOwnership(address(0), _owner);
    }

    function owner() public view returns(address) {
      return _owner;
    }

    modifier onlyOwner(){ 
      require(isOwner());
      _;
    }

    function isOwner() public view returns (bool) {
      return msg.sender == _owner;
    }

    function transferOwnership(address _newOwner) public onlyOwner{
      _transferOwnership(_newOwner);
    }

    function _transferOwnership(address _newOwner) internal {
      require(_newOwner != address(0));
      emit TransferOwnership(_owner, _newOwner);
      _owner = _newOwner;
    }
}