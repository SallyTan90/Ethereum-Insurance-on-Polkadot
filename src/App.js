import React from "react";
import { Drizzle } from '@drizzle/store';
import { drizzleReactHooks } from "@drizzle/react-plugin";
import {
  BrowserRouter as Router,
  Switch,
  Route,
} from "react-router-dom";

import drizzleOptions from "./drizzleOptions";
import LoadingContainer from './LoadingContainer.js';
import HomePage from './HomePage.js';
import Policy from './Policy.js';
import PolicyAdmin from './PolicyAdmin.js';
import Customer from './Customer.js';
import Navbar from './Navbar.js';

const drizzle = new Drizzle(drizzleOptions);
const { DrizzleProvider } = drizzleReactHooks;

function App() {
  return (
    <Router>
      <DrizzleProvider drizzle={drizzle}>
        <LoadingContainer>
          <div className="container">
            <div className="row">
              <Navbar />
            </div>
          </div>
          <div className="row">
            <div className="col-sm-12">
              <Switch >
                <Route exact path="/" component={HomePage} />
                <Route path="/policies/:policyId" component={Policy} />
                <Route path="/policyAdmin" component={PolicyAdmin} />
                <Route path="/customer" component={Customer} />
              </Switch>
            </div>
          </div>
        </LoadingContainer>
      </DrizzleProvider>
    </Router>
  );
}

export default App;