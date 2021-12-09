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

    function createApplication(uint256 _policyId) external policyExists(_policyId) {
        Policy storage policy = policies[_policyId];
        Application storage newApplication = applications[policy.newApplicationId];
        require(msg.value == policy.price, 'Please enter the correct amount to purchase this policy');
        //require (msg.sender == policyAdmin);
        policy.newApplicationId = nextApplicationId;
        policy.applicationIds.push(nextApplicationId);
        //applications[nextApplicationId] = Application(nextApplicationId, _policyId, msg.sender, msg.value);
        customerApplications[msg.sender].push(nextApplicationId);
        nextApplicationId++;
    }

    function getPolicies() view external returns(Policy[] memory) {
        Policy[] memory _policies = new Policy[](nextPolicyId - 1);
        for(uint i = 2; i < nextPolicyId + 1; i++) {
            _policies[i-1] = policies[i];
        }
        return _policies;
    }

    function getAdminPolicies(address _policyAdmin) view external returns(Policy[] memory) {
        uint[] storage customerPolicyIds = adminPolicies[_policyAdmin];
        Policy[] memory _policies = new Policy[](customerPolicyIds.length);
        for(uint i = 0; i < customerPolicyIds.length; i++) {
            uint policyId = customerPolicyIds[i];
            _policies[i] = policies[policyId];
        }
        return _policies;
    }

    function getCustomerApplications(address _customer) view external returns(Application[] memory) {
        uint[] storage customerApplicationIds = customerApplications[_customer];
        Application[] memory _applications = new Application[](customerApplicationIds.length);
        for(uint i = 0; i < customerApplicationIds.length; i++) {
            uint applicationId = customerApplicationIds[i];
            _applications[i] = applications[applicationId];
        }
        return _applications;
    }

    function isConditionApproved(uint256 _applicationId, uint256 _policyId) onlyPolicyAdmin() view external policyExists(_applicationId) {
        Policy storage policy = policies[_policyId];
        Application storage newApplication= applications[policy.newApplicationId];
        if(application.preExistingConditions == policy.approvedConditions) {
            return false; //'Your application has failed';
        } else {
            return true;
            emit applicationApproved(_applicationId); //'Your policy application has been approved'
        }
           
    }

    function purchasePolicy(address payable _customer, uint256 _policyId) onlyPolicyAdmin() external payable policyExists(_policyId) {
        Policy storage policy = policies[_policyId];
        Application storage newApplication = applications[policy.newApplicationId];
        applications.policyAdmin.transferFrom(msg.sender, msg.value);
        emit policyPurchased(_policyId, msg.value, block.timestamp);     
         
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