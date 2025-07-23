// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test, console} from "@forge-std/src/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import {FundMeScript} from "../script/FundMe.s.sol";

contract FundMeTest is Test {
    FundMe fundMe;

    function setUp() external {
        FundMeScript fundMeScript = new FundMeScript();
        fundMe = fundMeScript.run();
    }

    function testMinimumUSD() public view {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function testOwnerIsMsgSender() public view {
        assertEq(fundMe.i_owner(), msg.sender);
    }

    function testPriceFeedVersion() public view {
        assertEq(fundMe.getVersion(), 4);
    }
}
