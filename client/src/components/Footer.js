import React from "react";
import { MDBCol, MDBContainer, MDBRow, MDBFooter } from "mdbreact";
import './components.css';

const Footer = () => {
  return (
    <MDBFooter className="font-small bgBlack">
      <div className="footer-copyright text-center py-3">
        <MDBContainer fluid>
          &copy; {new Date().getFullYear()} Copyright: <a> Floyd </a>
        </MDBContainer>
      </div>
    </MDBFooter>
  );
}

export default Footer;