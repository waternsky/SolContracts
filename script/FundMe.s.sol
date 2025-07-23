// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "@forge-std/src/Script.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundMeScript is Script {
    function run() external returns (FundMe) {
        vm.startBroadcast();

        FundMe fundMe = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);

        vm.stopBroadcast();

        return fundMe;
    }
}
