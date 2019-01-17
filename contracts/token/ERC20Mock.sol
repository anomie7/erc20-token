pragma solidity ^0.5.0;

import "./ERC20.sol";

contract ERC20Mock is ERC20 {

  constructor() public {
  }

  function mint(address account, uint256 tokens) public {
    _mint(account, tokens);
  }

  function burn(address account, uint256 tokens) public {
    _burn(account, tokens);
  }

  function burnFrom(address account, uint256 tokens) public {
    _burnFrom(account, tokens);
  }
}
