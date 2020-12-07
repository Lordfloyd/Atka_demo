pragma solidity >=0.4.22 <0.8.0;

contract SimpleLockFund {
    
    enum State {Created, Locked, Release}
    State public state;

    struct FundData {
        address payable fundCustodian;
        uint balance;
        uint releaseTime;
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
        require(block.timestamp > funds[msg.sender].releaseTime , "Rent is not ended yet");
        _;
    }
    
    modifier onlyFundCustodian () {
        require(msg.sender == funds[msg.sender].fundCustodian, "You don't have the right for this action !");
        _;
    }

    function getContractBalance() external view returns (uint) {
        return address(this).balance;
    }

    function cashIn(uint lockTimeS)public payable {

        uint amount = msg.value;
        if (funds[msg.sender].balance > 0)
            
            msg.sender.transfer(msg.value);
        else {
            state = State.Locked;
            funds[msg.sender].fundCustodian = msg.sender;
            funds[msg.sender].balance = amount;
            funds[msg.sender].releaseTime = now + lockTimeS;
        }
    }
    
    
    function cashOut() public onlyAfter onlyFundCustodian {
        if (funds[msg.sender].balance != 0) {
            state = State.Release;
            msg.sender.transfer(funds[msg.sender].balance);
            funds[msg.sender].balance = 0;
            funds[msg.sender].releaseTime = 0;
        }
    }

    function getMyLockedFunds() public view onlyFundCustodian returns (uint x) {
        return funds[msg.sender].balance;
    }
    
    function getMyLockedFundsReleaseTime() public view onlyFundCustodian returns (uint x) {
	    return funds[msg.sender].releaseTime;
    }

    function getNow() public view returns (uint x) {
        return block.timestamp;
    }
}