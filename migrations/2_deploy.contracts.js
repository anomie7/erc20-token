var Owned = artifacts.require("./Owned.sol");
var SafeMathMock = artifacts.require("./SafeMathMock.sol");
var ERC20Mock = artifacts.require("./ERC20Mock.sol");

module.exports = function(deployer) {
  deployer.deploy(Owned);
  deployer.deploy(SafeMathMock);
  deployer.deploy(ERC20Mock);
};
