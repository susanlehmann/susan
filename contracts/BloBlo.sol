pragma solidity ^0.4.2;

contract BloBlo {

    event NewBatch(
        bytes32 indexed ipfsHash
    );

    function BloBlo() public { }
    
    function newBatch(bytes32 ipfsHash) public {
        NewBatch(ipfsHash);
    }
}