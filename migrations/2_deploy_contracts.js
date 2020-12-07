const SimpleLockFund = artifacts.require("SimpleLockFund");

module.exports = function (deployer) {
  deployer.deploy(SimpleLockFund);
};