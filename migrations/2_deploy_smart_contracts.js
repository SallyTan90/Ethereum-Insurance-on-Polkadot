const CreateNewPolicy = artifacts.require("CreateNewPolicy");
const EthereumInsurance = artifacts.require("EthereumInsurance");
const PurchasePolicy = artifacts.require("PurchasePolicy");

module.exports = function(deployer) {
    deployer.deploy(CreateNewPolicy);
    deployer.deploy(EthereumInsurance);
    deployer.deploy(PurchasePolicy);
}