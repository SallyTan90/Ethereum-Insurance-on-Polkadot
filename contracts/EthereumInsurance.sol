pragma solidity ^0.8.0;

//import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import './CreateNewPolicy.sol';

contract EthereumInsurance {

    using SafeMath for uint256;
    //using Strings for uint256;
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

    event paidOut(address policyAdmin, uint payout, uint paymentId, uint date);

    constructor() {
        policyAdmin = msg.sender;
    }



}