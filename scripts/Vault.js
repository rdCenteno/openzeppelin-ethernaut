const Web3 = require("web3");

const contractAddress = "0x2d85150abcB73474751816440026f355B4dB99DA";
const rpcUrl = "https://rinkeby.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161";
const web3 = new Web3(new Web3(rpcUrl));

;(async () => {
    const password = await web3.eth.getStorageAt(contractAddress, 1);

    console.log("The password is: ", password);
    console.log("The password in text is: ", web3.utils.toAscii(password));
})()

//await contract.unlock("0x412076657279207374726f6e67207365637265742070617373776f7264203a29")