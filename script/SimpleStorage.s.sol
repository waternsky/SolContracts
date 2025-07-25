// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "@forge-std/src/Script.sol";
import {SimpleStorage} from "../src/SimpleStorage.sol";

contract SimpleStorageScript is Script {
    function run() external returns (SimpleStorage) {
        vm.startBroadcast();

        SimpleStorage simpleStorage = new SimpleStorage();

        vm.stopBroadcast();

        return simpleStorage;
    }
}
