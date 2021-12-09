import React, { useState, useEffect } from "react";
import { useParams } from "react-router";
import { drizzleReactHooks } from "@drizzle/react-plugin";
import { newContextComponents } from "@drizzle/react-components";
import { toDate } from "./utils";
import { Link } from "react-router-dom";

const { useDrizzle, useDrizzleState } = drizzleReactHooks;
const { ContractData } = newContextComponents;

export default () => {
    const [isPolicyAdmin, setIsPolicyAdmin] = useState(false);
    const { drizzle } = useDrizzle();
    const state = useDrizzleState(state => state);
    const { policyId } = useParams();

    return (
        <>
            <nav aria-label="breadcrumb" style={{ marginTop: "15px" }}>
                <ol className="breadcrumb">
                    <li className="breadcrumb-item"><Link to="/">Policies</Link></li>
                    <li className="breadcrumb-item active">{policyId}</li>
                </ol>
            </nav>
            <div>
                <ContractData
                    drizzle={drizzle}
                    drizzleState={state}
                    contract="PurchasePolicy"
                    method="policies"
                    methodArgs={[policyId]}
                    render={policy => {
                        return (
                            <div className="card">
                                <div className="card-body">
                                    <h5 className="card-title">{policy.name}</h5>
                                    <p className="card-text">{policy.description}</p>
                                </div>
                                <ul className="list-group list-group-flush">
                                    <li className="list-group-item">
                                        <strong>New Applications</strong>: {policy.newApplication}
                                    </li>
                                    <li className="list-group-item">
                                        <strong>Application status</strong>: {policy.applicationApproved}
                                    </li>
                                    <li className="list-group-item">
                                        <strong>Policy Administered By</strong>: {policy.policyAdmin}

                                    </li>
                                    <li className="list-group-item">
                                        <strong>Maximum Payout</strong>: {policy.payout}
                                    </li>
                                    <li className="list-group-item">
                                        <strong>Approved Diagnoses</strong>: {policy.approvedDiagnoses}
                                    </li>
                                    <li className="list-group-item">
                                        <strong>Approved Medicalcare Duration</strong>: {policy.approvedDuration}

                                    </li>
                                    <li className="list-group-item">
                                        <strong>Approved Clinics and Hospitals</strong>: {policy.approvedClinicOrHospital}

                                    </li>
                                </ul>
                            </div>
                        );
                    }}
                />

            </div>
            <div>
                <ContractData
                    drizzle={drizzle}
                    drizzleState={state}
                    contract="EthereumInsurance"
                    method="policies"
                    methodArgs={[policyId]}
                    render={policy => {
                        return (
                            <div className="card">
                                <div className="card-body">
                                    <h5 className="card-title">{policy.name}</h5>
                                    <p className="card-text">{policy.description}</p>
                                </div>
                                <ul className="list-group list-group-flush">
                                    <li className="list-group-item">
                                        <strong>New Applications</strong>: {policy.newClaim}
                                    </li>
                                    <li className="list-group-item">
                                        <strong>Customer ID</strong>: {policy.customerId}
                                    </li>
                                    <li className="list-group-item">
                                        <strong>Claim Status</strong>: {policy.claimApproved}
                                    </li>
                                    <li className="list-group-item">
                                        <strong>Policy Administered By</strong>: {policy.policyAdmin}
                                    </li>
                                    <li className="list-group-item">
                                        <strong>Maximum Payout</strong>: {policy.payout}
                                    </li>
                                    <li className="list-group-item">
                                        <strong>Approved Diagnoses</strong>: {policy.approvedDiagnoses}
                                    </li>
                                    <li className="list-group-item">
                                        <strong>Approved Medicalcare Duration</strong>: {policy.approvedDuration}

                                    </li>
                                    <li className="list-group-item">
                                        <strong>Approved Clinics and Hospitals</strong>: {policy.approvedClinicOrHospital}

                                    </li>
                                </ul>
                            </div>
                        );
                    }}

                />
            </div>

        </>
    );
};