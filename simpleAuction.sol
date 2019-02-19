pragma solidity >=0.4.2 <0.6.0;

contract SimpleAuction {
    // parameters of the auction.
    address payable public beneficiary;
    uint public auctionEndTime;

    // current state of the auction.
    address public highestBidder;
    uint public highestBid;

    // allowed withrawals of previous bids
    mapping(address => uint) pendingReturns;

    // set to true at the end, disallows any change.
    // by default initialized to 'false'.
    bool ended;

    event HighestBidIncreased(address bidder, uint amount);
    event AuctionEnded(address winner, uint amount);

    constructor(uint _biddingTime, address payable _beneficiary) public {
        beneficiary = _beneficiary;
        auctionEndTime = now + _biddingTime;
    }

    function bid() public payable {
        require (now <= auctionEndTime, "Auction already ended.");
        require (msg.value > highestBid);

        if(msg.value !=0) {
            pendingReturns[highestBidder] += highestBid;
        }

        highestBidder = msg.sender;
        highestBid = msg.value;

        emit HighestBidIncreased(msg.sender, msg.value);
    }

    function withdraw() public returns (bool) {
        uint amount = pendingReturns[msg.sender];
        if (amount > 0) {
            pendingReturns[msg.sender] = 0;
        
            if(!msg.sender.send(amount)) {
                pendingReturns[msg.sender] = amount;
                return false;
            }
        }   
    return true;
    }

    function auctionEnd() public {
        // 1. Conditions
        require(now >= auctionEndTime, "Auction not yet ended");
        require(!ended, "auctionEnd has already been called.");

        // 2. Effects
        ended = true;
        emit AuctionEnded(highestBidder, highestBid);

        // 3. Interaction
        beneficiary.transfer(highestBid);
    }
}