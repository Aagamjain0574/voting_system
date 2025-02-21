pragma solidity ^0.8.0;

contract SentimentVoting {
    mapping(string => uint256) public votes;
    string[] public candidates = ["Alice", "Bob", "Charlie"];
    int256 public sentimentScore;
    address public owner;
    bool public votingClosed;

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    constructor() {
        owner = msg.sender;
        sentimentScore = 0;
        votingClosed = false;
    }

    function updateSentiment(int256 newScore) public onlyOwner {
        require(!votingClosed, "Voting is closed");
        sentimentScore = newScore;
    }

    function vote() public {
        require(!votingClosed, "Voting is closed");
        string memory selectedCandidate = determineVote();
        votes[selectedCandidate]++;
    }

    function determineVote() internal view returns (string memory) {
        if (sentimentScore > 0) {
            return candidates[0]; // Alice
        } else if (sentimentScore < 0) {
            return candidates[1]; // Bob
        } else {
            return candidates[2]; // Charlie
        }
    }

    function closeVoting() public onlyOwner {
        votingClosed = true;
    }
}
