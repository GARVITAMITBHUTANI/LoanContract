// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CollateralizedLoan {
    mapping(address => uint256) public collateral;
    mapping(address => uint256) public debt;
    mapping(address => uint256) public lastBorrowTime;
    uint256 public interestRate = 5; // 5% interest rate per block
    uint256 public loanToValue = 50; // 50% LTV ratio

    function depositCollateral() external payable {
        require(msg.value > 0, "Must deposit collateral");
        collateral[msg.sender] += msg.value;
    }

    function borrow() external {
        uint256 maxLoan = (collateral[msg.sender] * loanToValue) / 100;
        require(maxLoan > 0, "Insufficient collateral");
        require(debt[msg.sender] == 0, "Existing debt must be repaid first");
        
        debt[msg.sender] = maxLoan;
        lastBorrowTime[msg.sender] = block.number;
        payable(msg.sender).transfer(maxLoan);
    }

    function calculateInterest(address user) public view returns (uint256) {
        if (debt[user] == 0) return 0;
        uint256 blocksElapsed = block.number - lastBorrowTime[user];
        return (debt[user] * interestRate * blocksElapsed) / 100;
    }

    function repay() external payable {
        uint256 interest = calculateInterest(msg.sender);
        uint256 totalOwed = debt[msg.sender] + interest;
        require(msg.value >= totalOwed, "Insufficient repayment amount");
        
        debt[msg.sender] = 0;
        lastBorrowTime[msg.sender] = 0;
        payable(msg.sender).transfer(msg.value - totalOwed); // Refund excess amount
    }

    function withdrawCollateral() external {
        require(debt[msg.sender] == 0, "Outstanding debt must be repaid first");
        uint256 amount = collateral[msg.sender];
        require(amount > 0, "No collateral to withdraw");
        
        collateral[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
    }
}
