# openzeppelin-ethernaut


## Fallback

The first step is to call the funtion contribute, to be able to call the fallback funtion a get the ownership of the contract 

`await contract.contribute({value: toWei("0.0001")});`

`await sendTransaction({ from: player, to: contract.address, value: toWei("0.0001")});`

After claiming the ownership of the contract, withdraw the total value of the contract, calling the withdraw method

`await contract.withdraw()`

## Fal1out

The alleged constructor is not well written, so it not called when the contract is created. To claim the ownership just call the Fal1out method and then withdraw the value of the contract calling the method collectAllocations

`await contract.Fal1out({value: toWei("0.0001")})`

`await contract.collectAllocations()`

## CoinFlip

Create a contract that calls the CoinFlip contract, this contract uses the same method to guess the coin side

`uint256 blockValue = uint256(blockhash(block.number.sub(1)));`
`uint256 coinFlip = blockValue.div(FACTOR);`
`bool guess = coinFlip == 1;`
`coinFlipContract.flip(guess);`

## Telephone

tx.origin and msg.sender should be different, to achieve this you can call the changeOwner method via another smart contract. This way the tx.origin(smar contract address) and msg.sender(user address) are not the same.

## Token

The smart contrac has an overflow vulnerability in every math operation, to solve this problem just call the transfer method (from other account) and send it to your main account.

## Delegatecall

Delegatecall is a low level function similar to call. When contract A executes delegatecall to contract , B's code is executed with contract A's storage, msg.sender and msg.value. IMPORTANT: IN B CONTRACT STORAGE LAYOUT MUST BE THE SAME AS CONTRACT A

To solve this problem you have to call the pwn method from Delegate contract, via the fallback function of the Delegation contract. To call the pwn method you from the fallback you have to encode the call `bytes4(sha3("pwn()")`

`await sendTransaction({from: player, to: contract.address, data: "0xdd365b8b0000000000000000000000000000000000000000000000000000000000000000"})`

## Force

A contract cannot refuse funds given by another contract's selfdestruction. Therefore, all we have to do is create a contract, send ether to it, and selfdestruct it in favor of the Force contract.

In solidity, for a contract to be able to receive ether, the fallback function must be marked payable.

## Vault

All the information in the blockchain is public, if a variable is private it only indicates that it only can be acceded from the current contract, others contracts cannot read that information. But knowing how the EVM storage works you can access that information from outside the blockchain.

`await web3.eth.getStorageAt(contract.address, 1);`

To ensure that data is private, it needs to be encrypted before being put onto the blockchain. In this scenario, the decryption key should never be sent on-chain, as it will then be visible to anyone who looks for it. zk-SNARKs provide a way to determine whether someone possesses a secret parameter, without ever having to reveal the parameter.

## King

You have to claim the kingdom by setting the higher bet. To solve this problem you have to deploy other contract with no fallback function, or just put a fallback function with a reject message.

From the hack contact call the King contract and become king.
 
`(bool success,) = _to.call{value:msg.value}(new bytes(0));`

## Reentrancy

To solve this problem, you have to retreive all the balance from the contract. 
As the balance deduction is made after the call msg.sender.call.value(_amount)() If the msg.sender is a contract, it will call the fallback function.
Therefore, if this code is called in the fallback function of the sender, it will cause a recursion, sending the value multiple times before reducing the sender's balance.
Important to star the recursion sending the smart contract the total balance of Reentrance contract.

Important: Transfer and send are no longer recommended solutions as they can potentially break contracts after the Istanbul hard fork

Important: Always assume that the receiver of the funds you are sending can be another contract, not just a regular address. Hence, it can execute code in its payable fallback method and re-enter your contract, possibly messing up your state/logic.

## Elevator

Sol in order to set top to true, the first call to isLastFloor has to return false and the second one, true.

You can use the view function modifier on an interface in order to prevent state modifications. The pure modifier also prevents functions
from modifying the state.

# Sending Ether (transfer, send, call)

Send ether to other contract or address. You can send ether to other contract or address by:

`transfer` (2300 gas, throw error)
`send` (2300 gas, returns bool)
`call` (foward all gas or set gas, returns bool)

To receive ether. A contract must implement at least one of this methods:

`receive() external payable {}`
`fallback() external payable {}`

receive is called if msg.data is empty (""), otherwise fallback method is called.

# Guard against Re-entrancy

To send ether the recommended is to use call method in combination with re-entrancy guard

Guard against re-entrancy by:

- Making all state changes before calling other contracts
- Using re-entrancy guard modifier

`(bool sent, bytes memory data) = to.call{ value: msg.value}("")`
`require(sent, "Failed to send Ether")`