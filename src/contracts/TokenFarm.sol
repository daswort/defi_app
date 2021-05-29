pragma solidity ^0.5.0;

import "./PndrgnToken.sol";
import "./DaiToken.sol";

contract TokenFarm {

	string public name = "Pndrgn Token Farm";
	address public owner;
	PndrgnToken public pndrgnToken;
	DaiToken public daiToken;

	address[] public stakers;

	mapping(address => uint) public stakingBalance;
	mapping(address => bool) public hasStaked;
	mapping(address => bool) public isStaking;

	constructor(PndrgnToken _pndrgnToken, DaiToken _daiToken) public {
		pndrgnToken = _pndrgnToken;
		daiToken = _daiToken;
		owner = msg.sender;
	}

	// Stakes tokens (deposit)
	function stakeTokens(uint _amount) public {
		
		// Require amount greater than zero
		require(_amount > 0, "amount cannot be 0");

		// Transfer fake DAI tokens to this contract for staking
		daiToken.transferFrom(msg.sender, address(this), _amount);

		// Update staking balance
		stakingBalance[msg.sender] = stakingBalance[msg.sender] + _amount;

		// Add user to stakers array only if they haven't staked already
		if (!hasStaked[msg.sender]) {
			stakers.push(msg.sender);
		}

		// Update staking status
		isStaking[msg.sender] = true;
		hasStaked[msg.sender] = true;
	}

	// Unstaking tokens (withdraw)

	// Issuing tokens
	function issueToken() public {

		// Only owner can call this function
		require(msg.sender == owner, "caller must be the owner");

		for (uint i = 0; i < stakers.length; i++) {

			address recipient = stakers[i];
			uint balance = stakingBalance[recipient];

			if (balance > 0) {
				pndrgnToken.transfer(recipient, balance);
			}
		}
	}
}