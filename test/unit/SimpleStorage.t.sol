// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test, console} from "@forge-std/src/Test.sol";
import {SimpleStorage} from "../../src/SimpleStorage.sol";
import {SimpleStorageScript} from "../../script/SimpleStorage.s.sol";

contract SimpleStorageTest is Test {
    SimpleStorage simpleStorage;

    function setUp() external {
        SimpleStorageScript simpleStorageScript = new SimpleStorageScript();
        simpleStorage = simpleStorageScript.run();
        simpleStorage.store(42);
    }

    function testStore(uint256 x) public {
        simpleStorage.store(x);
        assertEq(simpleStorage.retrieve(), x);
    }

    function testRetrieve() public view {
        assertEq(simpleStorage.retrieve(), 42);
    }

    function testAddPerson(uint256 x) public {
        simpleStorage.addPerson("Kush", x);
        assertEq(simpleStorage.peopleToFavNum("Kush"), x);
    }
}
