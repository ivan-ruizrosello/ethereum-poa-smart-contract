const express =require('express');
const Web3 = require('web3');
const fs = require('fs');
const PASS = "123"
const web3 = new Web3(new Web3.providers.HttpProvider('http://localhost:8540'));

const mintableERC20_ABI = JSON.parse(fs.readFileSync('./contracts/ERC20Mintable.json', 'utf8'));
const mintableERC20_Contract = new web3.eth.Contract(mintableERC20_ABI, "0x0000000000000000000000000000000000000010", {})

const unlockAccount = (_account, _password) => {
    return web3.eth.personal.unlockAccount(_account, _password, "0xCAFE");
}

const PORT = 3000;
const app = express();

app.use(express.json());

app.get('/minter/:address', (req,res) => {
    const { address } = req.params;

    mintableERC20_Contract.methods.isMinter(address).call().then(data => {
        res.send(data);
    }).catch(err => {
        res.status(400).send(err);
    })
})
app.post('/unlock/:address/', (req, res) => {
    const { password, time } = req.body;
    const { address } = req.params;

    unlockAccount(address, password, time).then(data => {
        res.send(data);
    }).catch(err => {
        res.status(500).send(err);
    })
});

app.post('/mint/:address/:amount', (req, res) => {
    const { address, amount } = req.params;

    mintableERC20_Contract.methods.mint(address, amount).send({from: address}).then(data => {
        res.send(data);
    }).catch(err => {
        res.status(400).send(err);
    });
});


app.listen(PORT, () => {
    console.log(`Server running at ${PORT}`);
})





// web3.eth.getCoinbase().then(address => {
//     console.log('Using address:', address);
//     unlockAccount(address, PASS).then(unlocked => {
//         console.log(unlocked)

//         mintableERC20_Contract.methods.mint(address, 10).send({from: address}).then(data => {
//             console.log('mint', data)
//         }).catch(err => {
//             console.log('Error mint:', err);
//         });
//         mintableERC20_Contract.methods.isMinter(address).call().then(data => {
//             console.log('isMinter:', data)
//         })
//     })       
// });