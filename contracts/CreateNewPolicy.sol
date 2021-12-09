pragma solidity ^0.8.0;

contract CreateNewPolicy {

    struct Policy {
        uint256 id;
        address policyAdmin;
        uint256 payout;
        uint256 price;
        uint256 coverageDuration;
        uint256 approvedConditions;
        uint256[] applicationIds;
    }

    mapping(uint256 => Policy) private policies;
    mapping(address => uint256[]) private adminPolicies;
    uint256 private nextPolicyId = 1;
    address public policyAdmin;

    constructor() {
        policyAdmin = msg.sender;
    }

    function createPolicy(uint256 _payout, uint256 price, uint256 _coverageDuration, uint256 _approvedConditions) external onlyPolicyAdmin() {
        uint256[] memory applicationIds = new uint256[](0);
        policies[nextPolicyId] = Policy(
            nextPolicyId,
            msg.sender,
            _payout,
            price,
            _coverageDuration,
            _approvedConditions,
            applicationIds
        );
        adminPolicies[msg.sender].push(nextPolicyId);
        nextPolicyId++;
    }

    modifier onlyPolicyAdmin() {
        require(msg.sender == policyAdmin);

        _;
    }
  
}