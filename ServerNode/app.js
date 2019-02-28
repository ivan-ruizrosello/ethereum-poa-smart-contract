const Web3 = require('web3');
const fs = require('fs');
const PASS = "123"
const web3 = new Web3(new Web3.providers.HttpProvider('http://localhost:8540'));
const governmentABI = JSON.parse(fs.readFileSync('./contracts/OwnedSet.json', 'utf8'));

const governmentcontract = new web3.eth.Contract(governmentABI, "0x0000000000000000000000000000000000000009", {})

const getConnection = () => {
    return web3.eth.getCoinbase();
}

const unlockAccount = (_account, _password) => {
    return web3.eth.personal.unlockAccount(_account, _password, "0xCAFE");
}

const addValidator = async (_from, _toAdd, _password) => {
    return unlockAccount(_from, _password).then( unlocked => {
        if(unlocked) {
            console.log('Cuenta desbloqueada. \n -> Adding validator ' + _toAdd)
            return governmentcontract.methods.addValidator(_toAdd).send({from: _from});
        }
    })
    
}

getConnection()
    .then( () => {
        addValidator("0x0d5f58a5579380164e965031fff90865fab0c4e2", "0xC11b0514Ac6C90208a6D8dD034aBe451aCf48DCC", PASS)
            .then((res) => {
                console.log(res);
            })
    })
    .catch(err => console.err(new Error(err)))


