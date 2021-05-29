const PndrgnToken = artifacts.require('PndrgnToken')
const DaiToken = artifacts.require('DaiToken')
const TokenFarm = artifacts.require('TokenFarm')

require('chai')
	.use(require('chai-as-promised'))
	.should()

function tokens(n) {
	return web3.utils.toWei(n, 'ether')
}

contract('TokenFarm', ([owner, investor]) => {

	let daiToken, pndrgnToken, tokenFarm

	before(async () => {
		// Load contracts
		daiToken = await DaiToken.new()
		pndrgnToken = await PndrgnToken.new()
		tokenFarm = await TokenFarm.new(pndrgnToken.address, daiToken.address)

		// Transfer all Pndrgn tokens to farm (1 million)
		await pndrgnToken.transfer(tokenFarm.address, tokens('1000000'))

		// Send tokens to investor
		await daiToken.transfer(investor, tokens('100'), {from: owner})
	})

	describe('Fake DAI deployment', async () => {
		it('has a name', async () => {
			const name = await daiToken.name()
			assert.equal(name, 'Mock DAI Token')
		})
	})

	describe('Pndrgn Token deployment', async () => {
		it('has a name', async () => {
			const name = await pndrgnToken.name()
			assert.equal(name, 'Pndrgn Token')
		})
	})

	describe('Token Farm deployment', async () => {
		it('has a name', async () => {
			const name = await tokenFarm.name()
			assert.equal(name, 'Pndrgn Token Farm')
		})

		it('contract has tokens', async () => {
			let balance = await pndrgnToken.balanceOf(tokenFarm.address)
			assert.equal(balance.toString(), tokens('1000000'))
		})
	})
})