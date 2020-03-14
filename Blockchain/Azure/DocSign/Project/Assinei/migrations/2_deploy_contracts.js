var DocSign = artifacts.require("DocSign");
var Arg = "Hello world";
module.exports = deployer => {
    deployer.deploy(DocSign, "id1", "id2", "hash", "url", 0x123412341);
};