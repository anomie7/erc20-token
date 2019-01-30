pragma solidity ^0.5.0;

import "./ERC20.sol";
import "./../ownable/Owned.sol";

contract ERC20Mock is ERC20, Owned {

  constructor(string memory _symbol, string memory _name) ERC20(_owner, 0) public {
      symbol = _symbol;
      name = _name;
      
  }

  function mint(address account, uint256 tokens) public onlyOwner{
    _mint(account, tokens);
  }

  function burn(address account, uint256 tokens) public onlyOwner{
    _burn(account, tokens);
  }

  function burnFrom(address account, uint256 tokens) public {
    _burnFrom(account, tokens);
  }
}
