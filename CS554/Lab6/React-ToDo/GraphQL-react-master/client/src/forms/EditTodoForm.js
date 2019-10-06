import React from "react";
import ApiService from "../ApiService";

class EditTodoForm extends React.Component {
  constructor(props) {
    super(props);

    this.userId = parseInt(this.props.match.params.userId, 10);

    this.state = {
      title: "",
      completed: false,
      taskId: ''
    };
  }

  async componentDidMount() {
    const taskId = this.props.match.params.taskId;
    this.setState({
      taskId: taskId
    });
    const task = await ApiService.getTodos(
      taskId
    );
    // console.log(taskId);
    console.log("hello", task)
    for (let i = 0; i < task.length; i++) {
      // console.log(typeof taskId);
      // console.log(typeof task[i].id);
      // console.log(taskId == task[i.id]);
      if (taskId === task[i].id.toString()) {
        // console.log("here", task[i])
        const title = task[i].title;
        const completed = task[i].completed;
        this.setState({ title, completed });
      } else {
        // console.log(task);
      }
    }
    // if (task[0]) {
    //   const [{ title, completed }] = task;
    //   this.setState({ title, completed });
    // } else {
    //   console.log(task);
    // }
  }

  handleChange = event => {
    if (event.target.name === "completed") {
      // if (this.state.completed === false) {
      //   this.setState({
      //     completed: true
      //   });
      // }
      // else {
      //   this.setState({
      //     completed: false
      //   })
      // }
      this.setState(prevState => {
        return {
          completed: !prevState.completed
        };
      });
    } else {
      this.setState({ [event.target.name]: event.target.value });
    }
  };

  handleSubmit = async event => {
    event.preventDefault();
    const { title, completed } = this.state;

    if (title.trim() === "") {
      return;
    }
    // console.log(this.state);

    const newTodo = {
      id: this.state.taskId,
      user: parseInt(this.userId, 10),
      title,
      completed
    };
    // console.log(newTodo);
    await ApiService.updateTodoItem(newTodo);
    this.setState({
      title: newTodo.title,
      completed: newTodo.completed
    })
    // this.state.title = newTodo.title;
    // this.state.completed = newTodo.completed;
    this.props.history.push(`/todos/${newTodo.user}`);
  };

  render() {
    return (
      <div>
        <hr />
        <h2>Edit user {this.userId}'s task</h2>
        <form className="user__form" onSubmit={this.handleSubmit}>
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
            Completed:
            <input
              type="checkbox"
              name="completed"
              checked={this.state.completed}
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
export default EditTodoForm;