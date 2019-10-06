import React, { Component } from "react";
import { Mutation } from "react-apollo";
import ReactModal from "react-modal";
import gql from 'graphql-tag';


ReactModal.setAppElement("#root");

const editQuoteQuery = gql`
mutation updateQuote(
  $id: String!,
  $quote: String!
) {
  updateQuote(
    input: {
      id: $id,
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

class EditQuote extends Component {
  constructor(props) {
    super(props);
    this.state = {
      showEditQuote: this.props.isOpen,
      quote: this.props.quote
    };
    this.handleCloseEditQuote = this.handleCloseEditQuote.bind(this);
  }

  handleCloseEditQuote() {
    this.setState({ showEditQuote: false, quote: null });
    this.props.handleClose();
  }

  render() {
    let quote;
    let body;
    if (this.props.modal === "editQuote") {
      body = (
        <Mutation 
          mutation={editQuoteQuery}
        >
          {(updateQuote, { data }) => (
            <form
              className="form"
              id="update-quote"
              onSubmit={e => {
                console.log(this.props)
                console.log(quote.value);
                e.preventDefault();
                updateQuote({
                  variables: {
                    id: this.props.quote.id,
                    quote: quote.value
                  }
                });
                quote.value = "";
                this.setState({ showEditQuote: false });
                alert("Quote Updated");
                this.props.handleClose();
              }}
            >
              <div className="form-group">
                <label>
                  Quote:
                  <br />
                  <input
                    ref={node => {
                      quote = node;
                    }}
                    defaultValue={this.props.quote.quote}
                    autoFocus={true}
                  />
                </label>
              </div>
              <br />

              
              <br />
              <br />
              <button className="button btn-warning" type="submit">
                Update Quote
              </button>
            </form>
          )}
        </Mutation>
      );
    }

    return (
      <div>
        <ReactModal
          name="updateQuote"
          isOpen={this.state.showEditQuote}
          contentLabel="Edit Quote"
        >
          {body}
          <button className="btn btn-secondary"
            onClick={this.handleCloseEditQuote}
          >
            Cancel
          </button>
        </ReactModal>
      </div>
    );
  }
}

export default EditQuote;
