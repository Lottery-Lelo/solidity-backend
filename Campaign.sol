pragma solidity ^0.4.17; // specifies the version of solidity

contract LotteryFactory {
    address[] public deployedLotteries;

    function createLottery(uint guess, uint fee) public {
        address newLottery = new Lottery(guess, fee);
        deployedLotteries.push(newLottery);
    }

    function getDeployedLotteries() public view returns (address[]) {
        return deployedLotteries;
    }
}

contract Lottery {
    address public manager;
    uint guess;
    uint public entryFee;
    string public complete = "Not complete!";
    uint comp = 0;

    function Lottery(uint guessNumber, uint fee) public {
        manager = msg.sender;
        guess = guessNumber;
        entryFee = fee;
    }

    function enter(uint guessNumber) public payable returns (string){
        require(msg.value > entryFee);
        if(comp == 1) {
            msg.sender.transfer(this.balance);
            return "Complete :(";
        }
        if(guessNumber == guess) {
            msg.sender.transfer(this.balance);
            complete = "Complete!";
            comp = 1;
            return "Winner!";
        }else if(guessNumber < guess) {
            return "Greater!";
        } else {
            return "Lower!";
        }
    }
}