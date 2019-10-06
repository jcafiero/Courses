import React, { Component } from "react";
import { Mutation } from "react-apollo";
import ReactModal from "react-modal";
import gql from 'graphql-tag';

const deleteQuote = gql`
  mutation deleteQuote($id: String!) {
    deleteQuote(
      input: {
        id: $id
      }
    ){
      id
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

class DeleteQuote extends Component {
  constructor(props) {
    super(props);
    this.state = {
      showDeleteQuote: this.props.isOpen,
      quote: this.props.deleteQuote
    };
    this.handleOpenDeleteQuote = this.handleOpenDeleteQuote.bind(this);
    this.handleCloseDeleteQuote = this.handleCloseDeleteQuote.bind(this);
    console.log(this.state.quote);
  }

  handleOpenDeleteQuote() {
    this.setState({ showDeleteQuote: true });
  }

  handleCloseDeleteQuote() {
    this.setState({ showDeleteQuote: false });
    this.props.handleClose(false);
  }
  render() {
    return (
      <div>
        <ReactModal
          name="deleteQuote"
          isOpen={this.state.showDeleteQuote}
          contentLabel="Delete Quote"
        >
          <Mutation
            mutation={deleteQuote}
            update={(cache, { data: { deleteQuote } }) => {
              const { quotes } = cache.readQuery({
                query: getAll
              });
              cache.writeQuery({
                query: getAll,
                data: {
                  quotes: quotes.filter(
                    q => q.id !== this.state.quote.id
                  )
                }
              });
            }}
          >
            {(deleteQuote, { data }) => (
              <div>
                <p>
                  Are you sure you want to delete{" "}
                  {this.state.quote.quote}
                  ?
                </p>

                <form
                  className="form"
                  id="delete-quote"
                  onSubmit={e => {
                    e.preventDefault();
                    deleteQuote({
                      variables: {
                        id: this.state.quote.id
                      }
                    });
                    this.setState({ showDeleteQuote: false });
                    alert("Quote Deleted");
                    this.props.handleClose();
                  }}
                >
                  <button className="btn btn-danger" type="submit">
                    Delete Quote
                  </button>
                </form>
              </div>
            )}
          </Mutation>
          <button
            className="btn btn-secondary"
            onClick={this.handleCloseDeleteQuote}
          >
            Cancel
          </button>
        </ReactModal>
      </div>
    );
  }
}

export default DeleteQuote;