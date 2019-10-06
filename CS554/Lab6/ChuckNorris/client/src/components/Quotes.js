import React, {Component} from 'react';
import { Query } from 'react-apollo';
import gql from 'graphql-tag';
// import { buildQueryFromSelectionSet } from 'apollo-utilities';

import AddQuote from './AddQuote';
import DeleteQuote from './DeleteQuote';
import EditQuote from './EditQuote';

const getAll = gql`
  query {
    quotes {
      id
      quote
    }
  }
`;

class Quotes extends Component {
  constructor(props) {
    super(props);
    this.state = {
      showAddQuote: false,
      showDeleteQuote: false,
      showEditQuote: false,
      editQuote: null,
      deleteQuote: null
    };
    this.handleOpenAddQuote = this.handleOpenAddQuote.bind(this);
    this.handleOpenDeleteQuote = this.handleOpenDeleteQuote.bind(this);
    this.handleOpenEditQuote = this.handleOpenEditQuote.bind(this);
    this.handleCloseQuotes = this.handleCloseQuotes.bind(this);
  }
  handleCloseQuotes() {
    this.setState({
      showAddQuote: false,
      showDeleteQuote: false,
      showEditQuote: false
    });
  }
  handleOpenAddQuote() {
    this.setState({ showAddQuote: true });
  }
  handleOpenDeleteQuote(quote) {
    this.setState({
      showDeleteQuote: true,
      deleteQuote: quote
    });
  }
  handleOpenEditQuote(quote) {
    this.setState({
      showEditQuote: true,
      editQuote: quote
    });
  }


  render() {
    return (
      <div className="container">
      <button type="button" className="btn btn-primary" onClick={this.handleOpenAddQuote}>
        Add Quote
      </button>
      <br/>
      <Query query={getAll}>
        {({ data }) => {
          if (!data) {
            console.log(data);
            return null;
          }
          const { quotes } = data;
          if (!quotes) {
            return null;
          }
          return (
            <div>
              {quotes.map(quote => {
                return (<div className="quote" key={quote.id}>
                  {quote.quote}
                  <div className="quote-btns">
                    <button type="button" className="btn btn-warning" onClick={() => {
                      this.handleOpenEditQuote(quote);
                    }}>
                      Edit
                    </button>
                    <button type="button" className="btn btn-danger" onClick={() => {
                      this.handleOpenDeleteQuote(quote);
                    }}>
                      Delete
                    </button>
                  </div>
                </div>)
              })}
            </div>
          )
        }}
      </Query>

      {this.state && this.state.showAddQuote && (
        <AddQuote
          isOpen={this.state.showAddQuote}
          handleClose={this.handleCloseQuotes}
          modal="addQuote"
        />
      )}
      {this.state && this.state.showDeleteQuote && (
        <DeleteQuote 
          isOpen={this.state.showDeleteQuote}
          handleClose={this.handleCloseQuotes}
          deleteQuote={this.state.deleteQuote}
        />
      )}
      {this.state && this.state.showEditQuote && (
        <EditQuote 
          isOpen={this.state.showEditQuote}
          quote={this.state.editQuote}
          handleClose={this.handleCloseQuotes}
          modal="editQuote"
        />
      )}
    </div>
    );
  }
}

export default Quotes;