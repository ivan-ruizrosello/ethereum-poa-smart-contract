pragma solidity ^0.5.0;

/**
 * @title Ownable
 * @dev The Ownable contract has an owner address, and provides basic authorization control
 * functions, this simplifies the implementation of "user permissions".
 */
contract Ownable {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev The Ownable constructor sets the original `owner` of the contract to the sender
     * account.
     */
    constructor () internal {
        _owner = address(0xCa85a29D61a75A2c360F12FBCc6BdDCD5C2CF0c6);
        emit OwnershipTransferred(address(0), _owner);
    }

    /**
     * @return the address of the owner.
     */
    function owner() public view returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(isOwner(), "msg.sender is not the owner");
        _;
    }

    /**
     * @return true if `msg.sender` is the owner of the contract.
     */
    function isOwner() public view returns (bool) {
        return msg.sender == _owner;
    }

    /**
     * @dev Allows the current owner to relinquish control of the contract.
     * @notice Renouncing to ownership will leave the contract without an owner.
     * It will not be possible to call the functions with the `onlyOwner`
     * modifier anymore.
     */
    function renounceOwnership() public onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Allows the current owner to transfer control of the contract to a newOwner.
     * @param newOwner The address to transfer ownership to.
     */
    function transferOwnership(address newOwner) public onlyOwner {
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers control of the contract to a newOwner.
     * @param newOwner The address to transfer ownership to.
     */
    function _transferOwnership(address newOwner) internal {
        require(newOwner != address(0), "0x0 is not a valid account for this setup");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

contract BaseOwnedSet is Ownable {
	// EVENTS
    event ChangeFinalized(address[] currentSet);

	// STATE

	// Was the last validator change finalized. Implies validators == pending
    bool public finalized;

	// TYPES
    struct AddressStatus {
        bool isIn;
        uint index;
    }

	// EVENTS
    event Report(address indexed reporter, address indexed reported, bool indexed malicious);

	// STATE
    uint public recentBlocks = 20;

    // Current list of addresses entitled to participate in the consensus.
    address[] validators;
    address[] pending;
    mapping(address => AddressStatus) status;

	// MODIFIERS

	/// Asserts whether a given address is currently a validator. A validator
	/// that is pending to be added is not considered a validator, only when
	/// that change is finalized will this method return true. A validator that
	/// is pending to be removed is immediately not considered a validator
	/// (before the change is finalized).
	///
	/// For the purposes of this contract one of the consequences is that you
	/// can't report on a validator that is currently active but pending to be
	/// removed. This is a compromise for simplicity since the reporting
	/// functions only emit events which can be tracked off-chain.
    modifier isValidator(address _someone) {
        bool isIn = status[_someone].isIn;
        uint index = status[_someone].index;

        require(
            isIn && index < validators.length && validators[index] == _someone,
            "Is in = false || index > validador list  || validadors[index] != _someone"
        );
        _;
    }

    modifier isNotValidator(address _someone) {
        require(!status[_someone].isIn, "_someone is not validator");
        _;
    }

    modifier isRecent(uint _blockNumber) {
        require(
            block.number <= _blockNumber + recentBlocks && _blockNumber < block.number,
            "cannot be applied because recent blocks threshold exeeded"
        );
        _;
    }

    modifier whenFinalized() {
        require(finalized, "change not finalized yet");
        _;
    }

    modifier whenNotFinalized() {
        require(!finalized, "change already finalized");
        _;
    }

    constructor(address[] memory _initial)
        public
    {
        pending = _initial;
        for (uint i = 0; i < _initial.length; i++) {
            status[_initial[i]].isIn = true;
            status[_initial[i]].index = i;
        }
        validators = pending;
    }

    // OWNER FUNCTIONS

    // Add a validator.
    function addValidator(address _validator)
        external
        onlyOwner
        isNotValidator(_validator)
    {
        status[_validator].isIn = true;
        status[_validator].index = pending.length;
        pending.push(_validator);
        triggerChange();
    }

    // Remove a validator.
    function removeValidator(address _validator)
        external
        onlyOwner
        isValidator(_validator)
    {
        // Remove validator from pending by moving the
        // last element to its slot
        uint index = status[_validator].index;
        pending[index] = pending[pending.length - 1];
        status[pending[index]].index = index;
        delete pending[pending.length - 1];
        pending.length--;

        // Reset address status
        delete status[_validator];

        triggerChange();
    }

    function setRecentBlocks(uint _recentBlocks)
        external
        onlyOwner
    {
        recentBlocks = _recentBlocks;
    }

    // GETTERS

    // Called to determine the current set of validators.
    function getValidators()
        external
        view
        returns (address[] memory)
    {
        return validators;
    }

    // Called to determine the pending set of validators.
    function getPending()
        external
        view
        returns (address[] memory)
    {
        return pending;
    }

    // INTERNAL

    // Report that a validator has misbehaved in a benign way.
    function baseReportBenign(address _reporter, address _validator, uint _blockNumber)
        internal
        isValidator(_reporter)
        isValidator(_validator)
        isRecent(_blockNumber)
    {
        emit Report(_reporter, _validator, false);
    }

    // Report that a validator has misbehaved maliciously.
    function baseReportMalicious(
        address _reporter,
        address _validator,
        uint _blockNumber,
        bytes memory _proof
    )
        internal
        isValidator(_reporter)
        isValidator(_validator)
        isRecent(_blockNumber)
    {
        emit Report(_reporter, _validator, true);
    }

    // Called when an initiated change reaches finality and is activated.
    function baseFinalizeChange()
        internal
        whenNotFinalized
    {
        validators = pending;
        finalized = true;
        emit ChangeFinalized(validators);
    }

    // PRIVATE

    function triggerChange()
        private
        whenFinalized
    {
        finalized = false;
        initiateChange();
    }

    function initiateChange()
        private;
}

interface ValidatorSet {
	/// Issue this log event to signal a desired change in validator set.
	/// This will not lead to a change in active validator set until
	/// finalizeChange is called.
	///
	/// Only the last log event of any block can take effect.
	/// If a signal is issued while another is being finalized it may never
	/// take effect.
	///
	/// _parentHash here should be the parent block hash, or the
	/// signal will not be recognized.
	event InitiateChange(bytes32 indexed _parentHash, address[] _newSet);

	/// Called when an initiated change reaches finality and is activated.
	/// Only valid when msg.sender == SYSTEM (EIP96, 2**160 - 2).
	///
	/// Also called when the contract is first enabled for consensus. In this case,
	/// the "change" finalized is the activation of the initial set.
	function finalizeChange()
		external;

	/// Reports benign misbehavior of validator of the current validator set
	/// (e.g. validator offline).
	function reportBenign(address validator, uint256 blockNumber)
		external;

	/// Reports malicious misbehavior of validator of the current validator set
	/// and provides proof of that misbehavor, which varies by engine
	/// (e.g. double vote).
	function reportMalicious(address validator, uint256 blockNumber, bytes calldata proof)
		external;

	/// Get current validator set (last enacted or initial if no changes ever made).
	function getValidators()
		external
		view
		returns (address[] memory);
}

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
