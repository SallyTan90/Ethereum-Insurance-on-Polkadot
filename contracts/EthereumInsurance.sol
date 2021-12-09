pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import './CreateNewPolicy.sol';

contract EthereumInsurance is ERC721, Ownable {

    using SafeMath for uint256;
    using Strings for Uint256;
    using Address for address;

    struct Policy {
        uint id;
        address policyAdmin;
        uint256 payout;
        uint256 approvedDiagnoses;
        uint256 approvedDuration;
        uint256 approvedClinicOrHospital;
        uint256 newClaimId;
        uint[] claimIds;
        bool approveClaim;
    }

    struct Claim {
        uint256 id;
        address customerAddress;
        uint256 diagnosis;
        uint256 coverageDuration;
        uint256 clinicOrHospitalName; //also applies to hospital name
        uint256 visitDuration; //date of clinic visit, also applies to hospitalisation duration
        uint256 billingAmount;
        uint256 dateOfClaim;
        //uint[] newClaimIds;
    }

    mapping (uint => Policy) private policies;
    mapping (uint => Claim) private claims;
    mapping(address => uint[]) private adminPolicies;
    mapping(address => uint[]) private customerClaims;
    mapping (bytes32 => bool) public validClaims;
    mapping (uint256 => uint256) public certificateIdToPolicy;
    uint private nextPolicyId = 1;
    uint private nextClaimId = 1;

    address public customer;
    address public policyAdmin;

    event newClaimRegistered(uint256 id, customer, uint256 diagnosis, uint256 coverageDuration, uint256 clinicOrHospitalName, uint256 medicalCertificate, uint256 billingAmount);
    event claimIsValid(uint claimId);
    event paidOut(address policyAdmin, uint payout, uint paymentId, uint date);

    constructor() {
        policyAdmin = msg.sender;
    }

    constructor() ERC721('Tokenised medical certificate', 'TMC') {
        _mint(address customer, 1);
    }

    function createClaim(uint256 _diagnosis, uint256 _coverageDuration, uint256 _clinicOrHospitalName,, uint256 billingAmount, uint256 _dateOfClaim) external {
        Claim storage newClaim = claims[policy.newClaimId];
        claims[nextClaimId] = Claim(
            nextClaimId,
            customer,
            _diagnosis,
            _coverageDuration,
            _clinicOrHospitalName,
            _visitDuration,
            billingAmount,
            block.timestamp
        );
        customerClaims[address customer].push(nextClaimId);
        nextClaimId++;
    }

    function sendCertificateToInsurer(uint256 _tokenId) {
        uint256 claim = certificateIdToClaim;
        address customer = ownerOf(_certificateId);
        _transfer(customer, msg.sender, _certificateId);
    }

    //add function to mint medical certificate and send it to insurance company

    //function createClaim(uint _policyId) external payable policyExists(_policyId) {
        //Policy storage policy = policies[_policyId];
        //Claim storage newClaim = claims[policy.newClaimId];
        //policy.newClaimId = nextClaimId;
        //policy.claimIds.push(nextClaimId);
        //claims[nextClaimId] = Claim(nextClaimId, _policyId, address _customer, _policyNumber, _diagnosis, _clinicName, _visitDate, _medicalCertificate, billingAmount);
        //customerClaims[address customer].push(nextClaimId);
        //nextClaimId++;
    //}


    function getAdminPolicies(address _policyAdmin) onlyPolicyAdmin() view external returns(Policy[] memory) {
        uint[] storage adminPolicyIds = adminPolicies[_policyAdmin];
        Policy[] memory _policies = new Policy[](adminPolicyIds.length);
        for(uint i= 0; i < adminPolicyIds.length; i++) {
            uint policyId = adminPolicyIds[i];
            _policies[i] = _policies[policyId];
        }
        return _policies;
    }
    
    function approvePayout(uint  _policyId) onlyPolicyAdmin() external policyExists(_policyId) {
        Policy storage policy = policies[_policyId];
        Claim storage newClaim = claims[policy.newClaimId];
        require (claim.diagnosis != policy.approvedDiagnoses);
        require (claim.visitDuration <= policy.approvedDuration);
        require(claim.clinicOrHospitalName != policy.clinicOrHospitalName);
        require(claim.billingAmount <= policy.payout);
        _claimId.policyAdmin.transferFrom(msg.sender, msg.value);
        emit paidOut(msg.sender, msg.value, block.timestamp); 
          
    }

    function getPolicies() view external returns(Policy[] memory) {
        uint[] memory _policies = new Policy[](nextPolicyId - 1);
        for(uint i = 1; i < nextPolicyId +1; i++) {
            _policies[i-1] = policies[i];
        }
        return _policies;
    }

    function getCustomerClaims(address _customer) view external returns(Policy[] memory) {
        uint[] storage holderClaimIds = customerClaims[_customer];
        Claim[] memory _claims = new Claim[](holderClaimIds.length);
        for(uint i = 0; i < holderClaimIds.length; i++) {
            uint claimId = holderClaimIds[i];
            _claims[i] = claims[claimId];
        }
        return _claims;
    }


    modifier policyExists(uint _policyId) {
        require(_policyId > 0 && _policyId < nextPolicyId, 'This policy does not exist');
        _;
    }

    modifier onlyPolicyAdmin(address _policyAdmin) {
        require(msg.sender == policyAdmin, 'You are not authorised to approve claim payouts');
        _;
    }

    modifier onlyPayoutValue(address _customer) {
        require(msg.value <= Policy.payout);
        _;
    }

    modifier onlyPolicyPurchased(address _holder) {
        require(customer.policyPurchased == true, 'You must have purchased a policy to qualify for coverage');
        _;
    }



}