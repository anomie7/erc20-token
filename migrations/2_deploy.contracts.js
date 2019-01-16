var Owned = artifacts.require("./Owned.sol");
var SafeMathMock = artifacts.require("./SafeMathMock.sol");
module.exports = function(deployer) {
  deployer.deploy(Owned);
  deployer.deploy(SafeMathMock);
};
