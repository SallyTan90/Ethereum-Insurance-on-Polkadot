pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;

import './CreateNewPolicy.sol';

contract PurchasePolicy {

   struct Policy {
        uint256 id;
        address policyAdmin;
        uint256 payout;
        uint256 price;
        uint256 coverageDuration;
        uint256 newApplicationId;
        uint256[] applicationIds;
        bool approveApplication;
    }

    struct Application {
        uint256 id;
        address customer;
        uint256 date;
        uint256 preExistingConditions;
    }

    mapping (uint256 => Policy) private policies;
    mapping (uint256 => Application) private applications;
    mapping(address => uint[]) private adminPolicies;
    mapping(address => uint[]) private customerApplications;
    //mapping (bytes32 => bool) public approvedConditions;
    uint256 private nextPolicyId = 1;
    uint256 private nextApplicationId = 1;

    address public customer;
    address public policyAdmin;

    event applicationApproved(uint256 applicationId);
    event policyPurchased(uint256 applicationId, uint256 price, uint256 date);

    constructor() {
        policyAdmin = msg.sender;
    }

    modifier policyExists(uint256 _policyId) {
        require(_policyId > 0 && _policyId < nextPolicyId, 'This policy does not exist');
        _;
    }

    modifier onlyPolicyAdmin() {
        require(msg.sender == policyAdmin);
        _;
    }



  

    //Find out how to add Only policyAdmin may approve of applications for insurance

    //Use the EatTheBlocks e-commerce tutorial for this function
    //Consider using the ssteiger repository for the ownership transfer function

}