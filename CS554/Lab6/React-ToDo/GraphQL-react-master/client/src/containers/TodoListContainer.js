import React from 'react';
import TodoList from '../components/TodoList';
import ApiService from '../ApiService';
import { Link } from 'react-router-dom';

class TodoListContainer extends React.Component {

    constructor(props) {
        super(props);
        this.state = {
            todos: [],
        };
        this.update = this.update.bind(this);
    }

    async update() {
        const userId = parseInt(this.props.match.params.userId, 10);
        try {
            const todos = await ApiService.getTodos({userId});
            this.setState({todos});
        } catch (e) {
            console.error(`An error ${e.message} occured while loading tasks for user ${userId}`);
        }
    }

    async componentDidMount() {
        const userId = parseInt(this.props.match.params.userId, 10);
        try {
            const todos = await ApiService.getTodos({userId});
            this.setState({todos});
        } catch (e) {
            console.error(`An error ${e.message} occured while loading tasks for user ${userId}`);
        }
    }

    render () {
        return (
           <div className="todo">
               <TodoList todos={this.state.todos} update={this.update} />
               <Link className="todo__linkback" to='/'>Back to Users search</Link>
               {/* {console.log("users",this.state.todos)} */}
           </div>
        );
    }

}

export default TodoListContainer;


