const PndrgnToken = artifacts.require('PndrgnToken')
const DaiToken = artifacts.require('DaiToken')
const TokenFarm = artifacts.require('TokenFarm')

module.exports = async function(deployer, netwotk, accounts) {

  // Deploy Fake Dai Token
  await deployer.deploy(DaiToken)
  const daiToken = await DaiToken.deployed()  

  // Deploy Pndrgn Token
  await deployer.deploy(PndrgnToken)
  const pndrgnToken = await PndrgnToken.deployed()

  // Deploy Token Farm
  await deployer.deploy(TokenFarm, pndrgnToken.address, daiToken.address)
  const tokenFarm = await TokenFarm.deployed()

  // Transfer all tokens to TokenFarm (1 million)
  await pndrgnToken.transfer(tokenFarm.address, '1000000000000000000000000')

  // Transfer 100 Fake DAI token to investor
  await daiToken.transfer(accounts[1], '100000000000000000000')

}
