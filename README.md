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