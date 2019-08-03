// import attentionABI from './attentionABI'
var web3 = new Web3(window.web3.currentProvider);

let metamaskWeb3 = new Web3('http://localhost:7545')
let account = null
let attentionContract
let attentionContractAddress = '' // Paste Contract address here

export function web3_1() {
    return metamaskWeb3
}

export const accountAddress = () => {
    return account
}

export async function setProvider() {
    // TODO: get injected Metamask Object and create Web3 instance
    if (window.ethereum) {
        metamaskWeb3 = new Web3(ethereum);
        try {
            // Request account access if needed
            await ethereum.enable();
        } catch (error) {
            // User denied account access...
        }
    }
    else if (window.web3) {
        metamaskWeb3 = new Web3(web3.currentProvider);
    }
    account = await metamaskWeb3.eth.getAccounts()
}


function getattentionContract() {
    // TODO: create and return contract Object
    attentionContract = attentionContract || new metamaskWeb3.eth.Contract(attentionABI.abi, attentionContractAddress)
    return attentionContract

}

export async function postVideo(name, description) {
    // TODO: call attention.addVideo
    const prop = await getattentionContract().methods.addVideo(name, description).send({
        from: account[0]
    })
    alert('Video Posted Successfully')
}

export async function startVideo(videoId) {
    // TODO: call attention.videoEarnings
    const prop = await getattentionContract().methods.videoEarnings(videoId).send({
        from: account[0]
    })
    alert('Payment Started Successfully')
}

// export async function fetchAllProperties() {
//     // TODO: call attention.propertyId
//
//     const propertyId = await getattentionContract().methods.propertyId().call()
//
//     // iterate till property Id
//     const properties = []
//     for (let i = 0; i < propertyId; i++) {
//         const p = await attentionContract.methods.properties(i).call()
//         properties.push({
//             id: i,
//             name: p.name,
//             description: p.description,
//             price: metamaskWeb3.utils.fromWei(p.price)
//         })
//
//     }
//     return properties
//     // push each object to properties array
// }