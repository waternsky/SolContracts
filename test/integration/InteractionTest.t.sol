// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test, console} from "@forge-std/src/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {FundMeScript} from "../../script/FundMe.s.sol";
import {FundFundMe, WithdrawFundMe} from "../../script/Interaction.s.sol";

contract InterationsTest is Test {
    FundMe fundMe;

    address USER = makeAddr("user");
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 STARTING_BALANCE = 10 ether;

    function setUp() external {
        FundMeScript deploy = new FundMeScript();
        fundMe = deploy.run();
        vm.deal(USER, STARTING_BALANCE);
    }

    function testUserCanFundInteractions() public {
        FundFundMe fundFundMe = new FundFundMe();
        fundFundMe.fundFundMe(address(fundMe));

        WithdrawFundMe withdrawFundMe = new WithdrawFundMe();
        withdrawFundMe.withdrawFundMe(address(fundMe));

        assert(address(fundMe).balance == 0);
    }
}
