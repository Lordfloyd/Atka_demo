import React from 'react';
import { DrizzleProvider } from '@drizzle/react-plugin';
import { LoadingContainer, AccountData, ContractData, ContractForm} from '@drizzle/react-components';
import drizzleOptions from '../drizzleOptions';
import {MDBCol, MDBRow, MDBContainer} from "mdbreact";
import 'mdbreact/dist/css/mdb.css';
import './components.css';

function Body() {
    return (
      <DrizzleProvider options={drizzleOptions}>
          <MDBContainer className="">
            <LoadingContainer>
              <MDBRow>
                <MDBCol size="12">
                <h3>Your account: </h3>
                <AccountData accountIndex={1} units={"ether"} precision={2}/>
                </MDBCol>
                <MDBCol size="12">
                <h3>Current Greeting:</h3>
                <ContractData contract="Greeter" method="get"/>
                </MDBCol>
                <MDBCol size="12">
                <h3>Set greeting:</h3>
                <div className="md-form">
                  <ContractForm contract="Greeter" method="set" className="form-control" />
                </div>
                </MDBCol>
              </MDBRow>
            </LoadingContainer>
          </MDBContainer> 

      </DrizzleProvider>
    );
  }
export default Body;