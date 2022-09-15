const Web3 = require("web3");

const contractAddress = "0xa4B26DfC256492411aCa506589BC18081787f644";
const rpcUrl = "https://rinkeby.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161";
const web3 = new Web3(new Web3(rpcUrl));

;(async () => {
    //Gets the last element of the array data
    const arrayValue = await web3.eth.getStorageAt(contractAddress, 5);
    //The element type is a bytes32, need to cast it to bytes16
    /*function cast(bytes32 _key) public pure returns(bytes16) {
        return bytes16(_key);
    }*/
    const key = arrayValue.toString().slice(0, 34);
    console.log("The first key value is: ", key);
})()

//await contract.unlock("0x2c30f006c04f919851844cf403b938fe")
