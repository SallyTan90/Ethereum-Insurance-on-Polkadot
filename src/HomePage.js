import React, { useState } from "react";
import { drizzleReactHooks } from "@drizzle/react-plugin";
import { newContextComponents } from "@drizzle/react-components";
import PolicyList from "./PolicyList";

const { useDrizzle, useDrizzleState } = drizzleReactHooks;
const { ContractData } = newContextComponents;

export default () => {
    const [isPolicyAdmin, setIsPolicyAdmin] = useState(false);
    const { drizzle } = useDrizzle();
    const state = useDrizzleState(state => state);

    return (
        <>
            <div>
                <h3>All Policies</h3>
                <ContractData
                    drizzle={drizzle}
                    drizzleState={state}
                    contract="PurchasePolicy"
                    render={PolicyList}
                />
            </div>
        </>
    );
}

