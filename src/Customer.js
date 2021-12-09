import React, { useState, useEffect } from "react";
import { drizzleReactHooks } from "@drizzle/react-plugin";
import { newContextComponents } from "@drizzle/react-components";
import { Link } from "react-router-dom";

const { useDrizzle, useDrizzleState } = drizzleReactHooks;
const { ContractData } = newContextComponents;

export default () => {
    const [isPolicyAdmin, setIdPolicyAdmin] = useState(false);
    const { drizzle } = useDrizzle();
    const state = useDrizzleState(state => state);

    return (
        <>
            <div>
                <div>
                    <h3>Customer Applications</h3>
                    <ContractData
                        drizzle={drizzle}
                        drizzleState={state}
                        contract="PurchasePolicy"
                        method="getCustomerApplications"
                        methodArgs={[state.accounts[0]]}
                        render={applications => {
                            return (
                                applications && applications.length > 0 ? (
                                    <table className="table">
                                        <thead>
                                            <th scope="col">Cusotmer ID</th>
                                            <th scope="col">Pre-Existing Conditions</th>
                                            <th scope="col">Date of Application</th>
                                            <th scope="col">Application Status</th>
                                        </thead>
                                        <tbody>
                                            {applications.map(application => (
                                                <tr key={application.id}>
                                                    <td>{application.preExistingConditions}</td>
                                                    <td>{toDate(application.Date)}</td>
                                                    <td>
                                                        <Link
                                                            to={`/policies/${application.policyId}`}
                                                        >
                                                            Link
                                                        </Link>
                                                    </td>
                                                </tr>
                                            ))}
                                        </tbody>
                                    </table>
                                ) : <p>No application yet</p>
                            );
                        }}
                    />
                </div>
            </div>
            <div>
            <div>
                    <h3>Customer Claims</h3>
                    <ContractData
                        drizzle={drizzle}
                        drizzleState={state}
                        contract="EthereumInsurance"
                        method="getCustomerClaims"
                        methodArgs={[state.accounts[0]]}
                        render={claims => {
                            return (
                                claims && claims.length > 0 ? (
                                    <table className="table">
                                        <thead>
                                            <th scope="col">Cusotmer ID</th>
                                            <th scope="col">Diagnosis</th>
                                            <th scope="col">Duration of Coverage</th>
                                            <th scope="col">Name of Clinic or Hospital</th>
                                            <th scope="col">Duration of Visit or Stay</th>
                                            <th scope="col">Billing Amount</th>
                                            <th scope="col">Date</th>
                                        </thead>
                                        <tbody>
                                            {claims.map(claim => (
                                                <tr key={claim.id}>
                                                    <td>{claim.diagnosis}</td>
                                                    <td>{claim.coverageDuration}</td>
                                                    <td>{claim.clinicOrHospitalName}</td>
                                                    <td>{claim.visitDuration}</td>
                                                    <td>{claim.billingAmount}</td>
                                                    <td>{toDate(claim.dateOfClaim)}</td>
                                                    <td>
                                                        <Link
                                                            to={`/policies/${claim.policyId}`}
                                                        >
                                                            Link
                                                        </Link>
                                                    </td>
                                                </tr>
                                            ))}
                                        </tbody>
                                    </table>
                                ) : <p>No claims have been made yet</p>
                            );
                        }}
                    />
                </div>
            </div>
        </>
    );
};


