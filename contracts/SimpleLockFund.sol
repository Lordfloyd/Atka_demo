pragma solidity >=0.4.22 <0.8.0;

contract SimpleLockFund {
    
    enum State {Locked, Release}
    State public state;

    struct FundData {
        uint balance;
        uint releaseBlock;
    }
    mapping (address => FundData) funds;

    modifier inState(State _state) {
        require(
            state == _state,
            "Invalid state."
        );
        _;
    }

    modifier onlyAfter() {
        require(block.timestamp > funds[msg.sender].releaseBlock,"Lock Time is not ended yet" );
        _;
    }

    function cashIn() public payable {
        uint amount = msg.value;
        address payable sender = msg.sender;
        
        if(msg.sender.balance > amount ) {
            state = State.Release;
            msg.sender.transfer(amount);

        }
    }

    function cashOut() public payable onlyAfter() {
        state = State.Release;

        msg.sender.transfer(funds[msg.sender].balance);
    }


    function getFundLock () external view returns (uint x) {
        return funds[msg.sender].balance;
    }

    function getLockTime () external view returns (uint x) {
        return funds[msg.sender].releaseBlock;
    }

}