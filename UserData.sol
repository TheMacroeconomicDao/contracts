// SPDX-License-Identifier: AGPL
pragma solidity ^0.8.0;

// Contract Definition
contract DataStorage {

    // Owner address
    address private owner;

    // Addresses that can call contract functions
    mapping(address => bool) private authorizedAddresses;

    // Data structure
    struct Data {
        string dataType;
        string data;
    }

    // Mapping to store data by type
    mapping(string => mapping(address => Data)) private dataByType;

    // Contract constructor
    constructor() {
        owner = msg.sender;
    }

    // Modifier to check that the function is called only by the contract owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    // Modifier to check that the function is called only by an authorized address
    modifier onlyAuthorized() {
        require(authorizedAddresses[msg.sender], "Not authorized");
        _;
    }

    // Function to add an authorized address
    function addAuthorizedAddress(address _address) public onlyOwner {
        authorizedAddresses[_address] = true;
    }

    // Function to remove an authorized address
    function removeAuthorizedAddress(address _address) public onlyOwner {
        authorizedAddresses[_address] = false;
    }

    // Function to store data
    function storeData(string memory dataType, string memory data) public onlyAuthorized {
        dataByType[dataType][msg.sender] = Data(dataType, data);
    }

    // Function to retrieve data
    function retrieveData(string memory dataType, address userAddress) public view returns (string memory) {
        return dataByType[dataType][userAddress].data;
    }

}

