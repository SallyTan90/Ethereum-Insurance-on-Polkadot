import React from "react";
import { Link } from "react-router-dom";
import { toDate } from "./utils.js";

export default (policies) => (
    claims && claims.length > 0 ? (
        <table className="table">
            <thead>
                <th scope="col">Policy ID</th>
                <th scope="col">Approved Diagnoses</th>
                <th scope="col">Approved Medicalcare Duration</th>
                <th scope="col">Approved Clinics and Hospitals</th>
                <th scope="col">Maximum Payout</th>
            </thead>
            <tbody>
                {policies.map(policy => (
                    <tr key={policy.id}>
                        <td>{policy.payout}</td>
                        <td>{policy.approvedDiagnoses}</td>
                        <td>{policy.approvedDuration}</td>
                        <td>{policy.approvedClinicOrHospitalName}</td>
                        <td>{polic.payout}</td>
                        <td><Link to={`/policies/${policy.id}`}>Link</Link></td>
                    </tr>
                ))}
            </tbody>
        </table>
    ) : <p>No claims have been made yet</p>
);