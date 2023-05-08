// import
// main function
// calling of main function

const { network } = require("hardhat")
const { networkConfig } = require("../helper-hardhat-config")

// function deployFunc(hre) {
//     console.log("hi")
//     hre.getNamedAccounts()
//     hre.deployments
// }

// module.exports.default = deployFunc

// module.exports = async (hre) => {
//     const { getNamedAccounts, deployments } = hre
//     // hre.getNamedAccounts
//     // hre.getDeployments
// }

// syntax sugar same as
module.exports = async ({ getNamedAccounts, deployments }) => {
    const { deploy, log } = deployments
    const { deployer } = await getNamedAccounts()
    const chainId = network.config.chainId

    // if chainId is X use address Y
    // if chainId is Z use address A

    const ethUsdPriceFeedAddress=networkConfig[chainId]["ethUsdPriceFeed"]

    // if the contract does not exist, we deploy a minimal version of it for our local testing

    // well what happens when we want to  change the chains?
    // when going for localhost or hardhat networks we want to use a mock
    const fundme = await deployer("FundMe", {
        from: deployer,
        args: [
            /**addresses? */
        ], // put price feed address
        log: true,
    })
}
