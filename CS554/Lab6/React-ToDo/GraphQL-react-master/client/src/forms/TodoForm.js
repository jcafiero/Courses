// Author: Jennifer Cafiero
// It does not currently work to add a task, i think it's a very simple fix, but I have other things to study for finals
///// NEED TO FIX THIS
import React, { Component } from "react";
import ApiService from "../ApiService";

class TodoForm extends Component {
  constructor(props) {
    super(props);

    this.state = {
      user: "",
      title: "",
      users: []
    };
  }

  async componentDidMount() {
    const users = await ApiService.getUsers({
      first_name: '',
      last_name: ''
    });
    console.log(users[0].id);
    this.setState({
      user: parseInt(users[0].id, 10),
      users: users
    });
    console.log("moutned ", this.state)
  }

  handleChange = event => {
    // console.log(event.target)
    if (event.target.name === "user") {
      const id = parseInt(event.target.value, 10);
      const user = this.props.users.find(user => user.id === id);
      console.log(user);
      this.setState({ user });
    } else if (event.target.name === "title") {
      const title = event.target.value;
      this.setState({
        title: title
      });
    } else {
      this.setState({ [event.target.name]: event.target.value });
      // console.log("change state", this.state)
    }
  };

  handleSubmit = async event => {
    event.preventDefault();
    const { user, title } = this.state;

    console.log("submit state", this.state);

    if (title.trim() === "" || user === "") {
      return;
    }

    const newTodo = {
      user: parseInt(this.state.user, 10),
      title
    };

    await ApiService.createTodoItem(newTodo);
    this.setState({ title: "" });
    // console.log("last straw", typeof newTodo.user);
    this.props.history.push(`/todos/${newTodo.user}`);
  };

  render() {
    const usersSelect = this.state.users.map(user => {
      const userName = user.first_name + " " + user.last_name;
      return (
        <option key={`user${user.id}Select`} value={user.id}>
          {userName}
        </option>
      );
    });

    return (
      <div>
        <h3 className="add-title">Add a New Todo</h3>
        <form className="user__form" onSubmit={this.handleSubmit}>
          <label>
            User:
          <select
              name="user"
              value={this.state.user.id}
              onChange={this.handleChange}
            >
              {usersSelect}
            </select>
          </label>

          <label>
            Task Title:
          <input
              type="text"
              name="title"
              value={this.state.title}
              onChange={this.handleChange}
            />
          </label>

          <label>
            <input type="submit" value="Submit" />
          </label>
        </form>
      </div>
    );
  }
}
export default TodoForm;