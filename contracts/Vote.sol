// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <0.7.0;

contract Vote {

    struct candidator {
        string name;
        uint upVote;
    }

    candidator[] public candidators;
    bool isLive;
    address owner;

    mapping(address => bool) Voted;

    event AddCandidator(string _name);
    event UpVote(string candidator, uint upVote);
    event FinishVote(bool isLive);
    event Voting(address owner);

    modifier onlyOwner {
        require(
            msg.sender == owner,
            "Only owner can do this"
        );
        _;
    }

    constructor() public {
        owner = msg.sender;
        isLive = true;

        emit Voting(owner);
    }

    function addCandidator(string memory _name) public {
        require(
            isLive == true,
            "Voting is over"
        );
        require(
            candidators.length < 5,
            "Too much candidators"
        );
        candidators.push(candidator(_name, 0));

        emit AddCandidator(_name);
    }

    function upVote(uint _indexOfCandidator) public {
        require(
            isLive == true,
            "Voting is over"
        );
        require(
            _indexOfCandidator < candidators.length,
            "Invalid Candidator Index"
        );
        require(
            Voted[msg.sender] == false,
            "You already voted"
        );
        candidators[_indexOfCandidator].upVote++;

        Voted[msg.sender] = true;

        emit UpVote(candidators[_indexOfCandidator].name, candidators[_indexOfCandidator].upVote);
    }

    function finishVote() public onlyOwner {
        require(
            isLive == true,
            "Voting is over"
        );
        isLive = false;

        emit FinishVote(isLive);
    }
}