pragma solidity ^0.5.0;

import "./BaseOwnedSet.sol";
import "./ValidatorSet.sol";


contract OwnedSet is ValidatorSet, BaseOwnedSet {
	// STATE

	// System address, used by the block sealer.
    address public systemAddress;

    // MODIFIERS
    modifier onlySystem() {
        require(msg.sender == systemAddress);
        _;
    }

    constructor(address[] memory _initial) BaseOwnedSet(_initial)
        public
    {
        systemAddress = 0xffffFFFfFFffffffffffffffFfFFFfffFFFfFFfE;
    }

    // Called when an initiated change reaches finality and is activated.
    function finalizeChange()
        external
        onlySystem
    {
        baseFinalizeChange();
    }

    // MISBEHAVIOUR HANDLING

    function reportBenign(address _validator, uint256 _blockNumber)
        external
    {
        baseReportBenign(msg.sender, _validator, _blockNumber);
    }

    function reportMalicious(address _validator, uint256 _blockNumber, bytes calldata _proof)
        external
    {
        baseReportMalicious(
            msg.sender,
            _validator,
            _blockNumber,
            _proof
        );
    }

    // PRIVATE

    // Log desire to change the current list.
    function initiateChange()
        private
    {
        emit InitiateChange(blockhash(block.number - 1), pending);
    }
}
