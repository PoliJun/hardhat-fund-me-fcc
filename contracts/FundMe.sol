// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

// import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "./PriceConverter.sol";

error NotOwner();

contract FundMe {
    using PriceConverter for uint256;
    //minimum USD
    //351 gas
    uint256 public constant MINIMUM_USD = 0 * 1e18; // 1 * 10 ** 18
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;
    address public immutable i_owner;

    constructor() {
        i_owner = msg.sender;
    }

    function fund() public payable {
        //msg.value.getConversionRate();

        //want to be able to set a minimum fund amount in usd
        //1. how do we send ETH to this contract?
        //what is reverting
        //undo any action before , and send remaining gas back

        // or PriceConverter.getConversionRate(msg.value);
        require(
            msg.value.getConversionRate() >= MINIMUM_USD,
            "Didn't send enough"
        ); //require is a checker,1e18=1*10*18
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public onlyOwner {
        // for loop
        for (
            uint256 funderIndex = 0;
            funderIndex < funders.length;
            funderIndex++
        ) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        } // reset the array
        funders = new address[](0);
        // actually withdraw the funds,there are three ways
        /** 1.transfer(2300 gas, throws error)
        2.send(2300 gas, returns bool)
        3.call(forward all gas or set gas, returns bool) */

        // msg.sender = address
        // payable(msg.sender) == payable address

        //transfor
        // payable(msg.sender).transfer(address(this).balance);
        //send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "send failed");

        //call
        (
            bool callSuccess, /**bytes memory dataReturned*/

        ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "call failed");
    }

    modifier onlyOwner() {
        // require(msg.sender == i_owner,"Sender is not owner!");
        if (msg.sender != i_owner) {
            revert NotOwner();
        }
        _; //require first,then execute the code
    }

    // What happens if soomeone sends this contract ETH without calling the fund function

    // receive()
    receive() external payable {
        fund();
    }

    // fallback
    fallback() external payable {
        fund();
    }
}
/** function call syntax:
    function myFunction(uint256 param1, string memory param2) public payable returns (bool) {
    // do something with the parameters
    // return a bool indicating success or failure
    return true;
}
 */