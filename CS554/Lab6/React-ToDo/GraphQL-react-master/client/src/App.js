import React, {Component} from 'react';
import './styles/style.css';
import UserListContainer from './containers/UserListContainer';
import TodoListContainer from './containers/TodoListContainer';
// import CreateTodoItem from './components/CreateTodoItem';
// import UpdateTodoItem from './components/UpdateTodoItem';
import TodoForm from './forms/TodoForm';
import EditTodoForm from './forms/EditTodoForm';
import { Route, Switch, Link } from 'react-router-dom';
import ApiService from './ApiService';

class App extends Component {
    constructor(props) {
        super(props);
        this.state = {
            users: [],
            isMounted: false
        }
    }
    async componentDidMount() {
        const users = await ApiService.getUsers({
            first_name: '',
            last_name: ''
        });
        this.setState({
            users: users,
            isMounted: true
        });
    }
    render() {
    return (
        <div className="werk">
            <Link to='/'><h1>Todo lists</h1></Link>
            <div className="todo__section">
                <Switch>
                    <Route exact path='/' component={UserListContainer}/>
                    <Route path='/todos/:userId' component={TodoListContainer}/>
                    {/* <Route path='/create' component={CreateTodoItem} /> */}
                    {/* <Route path='/update/:userId/:todoId' component={UpdateTodoItem} /> */}
                    
                    <Route path="/update/:userId/:taskId" component={EditTodoForm} />
                </Switch>
            </div>
            <hr />
            <div className="container">
                <TodoForm
                    formhandler={this.createTodo}
                    users={this.state.users} />
            </div>
        </div>
    );
    }
}

export default App;
