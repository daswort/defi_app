pragma solidity ^0.5.0;

import "./PndrgnToken.sol";
import "./DaiToken.sol";

contract TokenFarm {

	string public name = "Pndrgn Token Farm";
	PndrgnToken public pndrgnToken;
	DaiToken public daiToken;

	address[] public stakers;

	mapping(address => uint) public stakingBalance;
	mapping(address => bool) public hasStaked;
	mapping(address => bool) public isStaking;

	constructor(PndrgnToken _pndrgnToken, DaiToken _daiToken) public {
		pndrgnToken = _pndrgnToken;
		daiToken = _daiToken;
	}

	// Stakes tokens (deposit)
	function stakeTokens(uint _amount) public {

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
}