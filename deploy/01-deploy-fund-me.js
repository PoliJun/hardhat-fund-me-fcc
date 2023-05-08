// import
// main function
// calling of main function

const { network } = require("hardhat")

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

    
    // well what happens when we want to  change the chains?
    // when going for localhost or hardhat networks we want to use a mock
}
