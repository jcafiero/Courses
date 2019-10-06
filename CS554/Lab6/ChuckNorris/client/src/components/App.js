import React from 'react';
import './App.css';
import { Nav } from 'react-bootstrap';
import Quotes from './Quotes';

function App() {
  return (
    <div className="App">
      <link
        rel="stylesheet"
        href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
        integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
        crossOrigin="anonymous"
      />  
      <header className="App-header">
        <h1>Chuck Norris Quote Generator</h1>
        <h2>CS 554 Lab 6</h2>
        <Nav variant="tabs" defaultActiveKey="/quotes">
          <Nav.Item>
            <Nav.Link href="/quotes">View Quotes</Nav.Link>
          </Nav.Item>
        </Nav>
      </header>

      <div className="chuck-body">
        <Quotes />
      </div>
    </div>
  );
}

export default App;
