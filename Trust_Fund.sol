// SPDX-License-Identifier: MIT

pragma solidity  ^0.8.18;

// Build a smart contract that will allow 
// Allow a child to claim thier funds only when they are 18yrs old
// Only the father should have the ability to deposit in the trust fund
// The constructor shuold be used to set the amount ,child address amd birthday

contract Trustfund {
    address payable public father;
    address public child;
    uint withdrawAge;
    uint depositAmount;
    uint dateofbirth;

    constructor(address _child ,uint _birthday) payable{
        father = payable(msg.sender);
        child = _child;
        dateofbirth = _birthday;
        withdrawAge = 18;
        depositAmount = msg.value ;
    }

    modifier OnlyFather() {
        require(msg.sender == father, "Only father can perform this action.");
        _;
    }
    modifier OnlyChild() {
        require(msg.sender == child, "Only child can perform this action.");
        _;
    }
    modifier onlyAtWithdrawAge() {
        require(getAge() >= withdrawAge, "Child has not reached the withdrawal age yet.");
        _;
    }

    function deposit() external payable OnlyFather {
        depositAmount += msg.value;
    }

    function withdraw() external OnlyChild onlyAtWithdrawAge {
        uint amount = depositAmount;
        depositAmount = 0;
        payable(child).transfer(amount);
    }

    function getAge() public view returns (uint) {
        return (block.timestamp - dateofbirth) / 365 days;
    }
}