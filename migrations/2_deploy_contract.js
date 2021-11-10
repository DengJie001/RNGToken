const RNGToken = artifacts.require("RNGToken");

module.exports = function (deployer) {
    deployer.deploy(RNGToken);
}