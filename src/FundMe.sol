// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {PriceConverter} from "./PriceConverter.sol";
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe {
    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 5e18;

    /* State variables*/
    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;
    address public immutable i_owner;
    AggregatorV3Interface private s_priceFeed;

    error FundMe__NotOwner();
    error FundMe__WithdrawFailed();
    error FundMe__NotEnoughETH();

    constructor(address priceFeed) {
        i_owner = msg.sender;
        s_priceFeed = AggregatorV3Interface(priceFeed);
    }

    modifier onlyOwner() {
        if (msg.sender != i_owner) {
            revert FundMe__NotOwner();
        }
        _;
    }

    function fund() public payable {
        if (msg.value.getConversionRate(s_priceFeed) <= MINIMUM_USD) {
            revert FundMe__NotEnoughETH();
        }
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public onlyOwner {
        for (uint256 i = 0; i < funders.length; i++) {
            address funder = funders[i];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);
        (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        if (!callSuccess) {
            revert FundMe__WithdrawFailed();
        }
    }

    function getVersion() public view returns (uint256) {
        return s_priceFeed.version();
    }

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }
}
