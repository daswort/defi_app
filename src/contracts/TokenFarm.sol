pragma solidity ^0.5.0;

import "./PndrgnToken.sol";
import "./DaiToken.sol";

contract TokenFarm {

	string public name = "Pndrgn Token Farm";
	PndrgnToken public pndrgnToken;
	DaiToken public daiToken;

	constructor(PndrgnToken _pndrgnToken, DaiToken _daiToken) public {
		pndrgnToken = _pndrgnToken;
		daiToken = _daiToken;
	}
}