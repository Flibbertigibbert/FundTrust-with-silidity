# FundTrust-with-silidity
A Solidity smart contract that implements a trust fund where a father can deposit funds and the child can only withdraw them once they reach 18 years of age. 
The constructor takes inputs for the amount to be deposited, the child's address, and their birthday.

Let's go through the code and explain each function and its use case:

1) Contract Declaration and Variables:
  The contract is declared with the name Trustfund.
  Variables are defined to store the addresses of the father and child (father and child), 
  the age at which the child can withdraw funds (withdrawAge), the total deposited amount (depositAmount), 
  and the child's birthday (dateofbirth).

2) Constructor:
  The constructor is a special function that runs only once when the contract is deployed.
  It takes the child's address (_child) and their date of birth in unix format (_birthday) as input parameters.
  It assigns the address of the person deploying the contract (msg.sender) to the father variable.
  It sets the child's address, birthday, and initializes the deposited amount by using msg.value (the value sent when deploying the contract).

3) Modifiers:
  Modifiers are used to add conditions to functions. They are like checks that ensure only certain accounts can execute specific functions.
  The OnlyFather modifier ensures that only the father can perform certain actions, such as depositing funds.
  The OnlyChild modifier ensures that only the child can perform certain actions, such as withdrawing funds.
  The onlyAtWithdrawalAge modifier ensures that the child has reached the withdrawal age before they can withdraw funds.
  
4) Deposit Function:
  The deposit() function allows the father (who is the contract deployer) to add more funds to the trust fund.
  It is marked with the OnlyFather modifier, which ensures only the father can call this function.
  The value sent along with the function call (msg.value) is added to the depositAmount variable to track the total deposited amount.

5) Withdraw Function:
  The withdraw() function allows the child to withdraw the entire deposited amount from the trust fund.
  It is marked with the OnlyChild and onlyAtWithdrawalAge modifiers to ensure only the child 
  and only when they have reached the withdrawal age can call this function.
  It transfers the entire depositAmount to the child's address using payable(child).transfer(amount). 
  The payable keyword is used to convert the child address to a payable address that can receive funds.

6) Get Age Function:
  The getAge() function calculates the age of the child in years based on their birthday and the current timestamp.
  It returns the calculated age by subtracting the birthday from the current timestamp and dividing by the number of seconds in a year (365 days).

