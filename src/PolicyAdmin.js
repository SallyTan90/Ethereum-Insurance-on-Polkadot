import React, { useState } from "react";
import { drizzleReactHooks } from "@drizzle/react-plugin";
import { newContextComponents } from "@drizzle/react-components";
import PolicyList from "./PolicyList";

const { useDrizzle, useDrizzleState } = drizzleReactHooks;
const { ContractForm, ContractData } = newContextComponents;

export default () => {
    const [isPolicyAdmin, setIdPolicyAdmin] = useState(false);
    const { drizzle } = useDrizzle();
    const state = useDrizzleState(state => state);

    return (
        <>
        <div>
            <h3>Create New Policy</h3>
            <ContractForm
            drizzle={drizzle}
            drizzleState={state}
            contract="CreateNewPolicy"
            method="createPolicy"
            />
        </div>
        <div>
            <h3>Policies Under Admin's Control</h3>
            <ContractData
            drizzle={drizzle}
            drizzle={state}
            contract= "EthereumInsrance"
            method="getAdminPolicies"
            methodArgs={[state.accounts[0]]}
            render={PolicyList}
            />
        </div>
        </>
    );
};