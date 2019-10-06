import React, { Component } from 'react';
import { Mutation } from 'react-apollo';
import ReactModal from 'react-modal';
import gql from "graphql-tag";

const addQuoteQuery = gql`
  mutation createQuote(
    $quote: String!
  ) {
    createQuote(
      input: {
        quote: $quote
      }
    ) {
      id
      quote
    }
  }
`;

const getAll = gql`
  query {
    quotes {
      id
      quote
    }
  }
`;

ReactModal.setAppElement("#root");

class AddQuote extends Component {
  constructor(props) {
    super(props);
    this.state = {
      showAddQuote: this.props.isOpen
    };
    this.handleOpenAddQuote = this.handleOpenAddQuote.bind(this);
    this.handleCloseAddQuote = this.handleCloseAddQuote.bind(this);
  }

  handleOpenAddQuote() {
    this.setState({ showAddQuote: true });
  }

  handleCloseAddQuote() {
    this.setState({ showAddQuote: false });
    this.props.handleClose(false);
  }

  render() {
    let body;
    if (this.props.modal === "addQuote") {
      let quote;
      body = (
        <Mutation 
          mutation={addQuoteQuery}
          update={(cache, { data: { createQuote } }) => {
            const { quotes } = cache.readQuery({
              query: getAll
            });
            cache.writeQuery({
              query: getAll,
              data: {
                quotes: quotes.concat([createQuote])
              }
            });
          }}
          >
            {(createQuote, { data }) => (
              <form 
                className="form"
                id="add-quote"
                onSubmit={e => {
                  e.preventDefault();
                  createQuote({
                    variables: {
                      quote: quote.value
                    }
                  });
                  quote.value="";
                  this.setState({ showAddQuote: false});
                  alert("Quote Added");
                  this.props.handleClose();
                }}
              >
                <div className="form-group">
                  <label>
                    Quote: 
                    <br />
                    <input ref={node => {
                      quote = node;
                    }} required
                    autoFocus={true}
                    />
                  </label>
                </div>
                <button className="btn btn-primary" type="submit">
                  Add Quote
                </button>
              </form>
            )}
          </Mutation>
      );
    }
    return (
      <div>
        <ReactModal
          name="addQuote"
          isOpen={this.state.showAddQuote}
          contentLabel="Add Quote"
        >
          {body}
          <button className="btn btn-secondary"
            onClick={this.handleCloseAddQuote}
          >
            Cancel
          </button>
        </ReactModal>
      </div>
    );
  }
}

export default AddQuote;
