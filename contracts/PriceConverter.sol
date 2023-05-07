// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    function getPrice() internal view returns (uint256) {
        //ABI
        //Address 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
        /**
        This code declares an instance of the AggregatorV3Interface 
        contract and initializes it with the address 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e. 
        This allows the calling contract to interact with 
        the AggregatorV3Interface contract at that address 
        and access its functions and state variables.
        */
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
        );
        (, int256 price, , , ) = priceFeed.latestRoundData();
        //ETH in terms of USD
        //3000.00000000
        return uint256(price * 1e10);
    }

    function getVersion() internal view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
        );
        return priceFeed.version();
    }

    function getConversionRate(
        uint256 ethAmount
    ) internal view returns (uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }
}


/**
function latestRoundData() public view virtual override returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound) {
    unchecked {
        roundId = latestRound;
        (answer, startedAt, updatedAt, answeredInRound) = getRoundData(roundId);
    }
}

 */