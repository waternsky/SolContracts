// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract SimpleStorage {
    uint256 favNum;

    struct Person {
        string name;
        uint256 favNum;
    }

    Person[] public listOfPeople;
    mapping(string => uint256) public peopleToFavNum;

    function store(uint256 _favNum) public {
        favNum = _favNum;
    }

    function retrieve() public view returns (uint256) {
        return favNum;
    }

    function addPerson(string memory _name, uint256 _favNum) public {
        listOfPeople.push(Person(_name, _favNum));
        peopleToFavNum[_name] = _favNum;
    }
}
