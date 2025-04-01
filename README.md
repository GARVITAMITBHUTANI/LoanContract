# LoanContract
# Collateralized Loan Smart Contract

## Overview
This Solidity smart contract enables users to deposit Ether as collateral, take out loans based on their collateral value, and repay with interest. The contract enforces a Loan-to-Value (LTV) ratio and calculates interest based on elapsed blocks.

## Features
- **Deposit Collateral**: Users can deposit Ether as collateral.
- **Borrow Loan**: Users can borrow up to 50% of their collateral.
- **Interest Calculation**: Interest is accrued per block at a rate of 5%.
- **Repayment System**: Users repay debt with accumulated interest.
- **Collateral Withdrawal**: Users can withdraw collateral once the debt is cleared.

## Contract Details
- **Interest Rate**: 5% per block.
- **Loan-to-Value Ratio (LTV)**: 50%.

## Deployment
Ensure you have a compatible Ethereum environment (e.g., Remix, Hardhat, or Truffle) and deploy the contract using any Ethereum-compatible wallet.

## Contract Address
```
0x3c1e5C3e39f8B695a34191f442811cb02DB8A084
```

## Usage
### 1. Deposit Collateral
Users deposit Ether into the contract as collateral.
```solidity
contract.depositCollateral({ value: X });
```

### 2. Borrow Loan
Users can borrow up to 50% of their collateral.
```solidity
contract.borrow();
```

### 3. Repay Loan
Users must repay their debt plus accrued interest.
```solidity
contract.repay({ value: X });
```

### 4. Withdraw Collateral
Once the debt is repaid, users can withdraw their collateral.
```solidity
contract.withdrawCollateral();
```

## Security Considerations
- Ensure sufficient Ether is available in the contract for loan withdrawals.
- Interest is calculated based on block numbers, which may vary in real-world conditions.
- Always test with testnets before deploying to the mainnet.

## License
MIT License.

