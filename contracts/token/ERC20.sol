pragma solidity ^0.5.0;

import "./ERC20Interface.sol";
import "./../math/SafeMath.sol";

contract ERC20 is ERC20Interface {
    using SafeMath for uint256;

    string public symbol;
    string public  name;
    uint8 public decimals;

    mapping (address => uint256) private _balances;
    mapping (address => mapping(address => uint256)) private _allowed;
    uint256 private _totalSupply;
    
    constructor(address _owner, uint8 _decimals) public {
        decimals = _decimals;
        _totalSupply = 1000 * (10**uint(decimals));
        _balances[_owner] = _totalSupply;
        emit Transfer(address(0), _owner, _totalSupply);
    }

    function totalSupply() external view returns (uint){
        return _totalSupply;
    }

    function balanceOf(address tokenOwner) external view returns(uint balance){
        return _balances[tokenOwner];
    }

    function allowance(address tokenOwner, address spender) external view returns (uint remaining){
        return _allowed[tokenOwner][spender];
    }

    function increaseAllowance(address spender, uint256 addedValue) public returns (bool) {
        require(spender != address(0), "argument 'spender' is invalid address value");

        _allowed[msg.sender][spender] = _allowed[msg.sender][spender].add(addedValue);
        emit Approval(msg.sender, spender, _allowed[msg.sender][spender]);
        return true;
    }

    function decreaseAllowance(address spender, uint256 subtractedValue) public returns (bool) {
        require(spender != address(0), "argument 'spender' is invalid address value");

        _allowed[msg.sender][spender] = _allowed[msg.sender][spender].sub(subtractedValue);
        emit Approval(msg.sender, spender, _allowed[msg.sender][spender]);
        return true;
    }

    function approve(address spender, uint tokens) external returns (bool success){
        require(spender != address(0), "");
        _allowed[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        return true;
    }

    function transfer(address to, uint tokens) external returns (bool success){
        _transfer(msg.sender, to, tokens);
        return true;
    }

    function transferFrom(address from, address to, uint tokens) external returns (bool success){
        _allowed[from][msg.sender] = _allowed[from][msg.sender].sub(tokens);
        _transfer(from, to, tokens);
        emit Approval(from, msg.sender, _allowed[from][msg.sender]);
        return true;
    }

    function _transfer (address from, address to, uint tokens) internal {
        require(to != address(0), "argument 'to' is invalid address value");

        _balances[from] = _balances[from].sub(tokens);
        _balances[to] = _balances[to].add(tokens);
        emit Transfer(from, to, tokens);
    }

    function _mint(address account, uint tokens) internal {
        require(account != address(0), "invalid address value!");

        _totalSupply = _totalSupply.add(tokens);
        _balances[account] = _balances[account].add(tokens);
        emit Transfer(address(0), account, tokens);
    }

    function _burn(address account, uint tokens) internal {
        require(account != address(0), "invalid address value!");

        _totalSupply = _totalSupply.sub(tokens);
        _balances[account] = _balances[account].sub(tokens);
        emit Transfer(account, address(0), tokens); 
    }

    function _burnFrom(address account, uint tokens) internal {
        _allowed[account][msg.sender] = _allowed[account][msg.sender].sub(tokens);
        _burn(account, tokens);
        emit Approval(account, msg.sender, _allowed[account][msg.sender]);
    }
}