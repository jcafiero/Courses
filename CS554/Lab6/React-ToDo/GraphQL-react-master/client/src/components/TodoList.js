import React from 'react';
import TodoItem from './TodoItem';
// import { Link } from 'react-router-dom';


const TodoList = (props) => {
    if(!props.todos.length) {
        return null;
    }
    return <div className="todo__list">
        {/* <Link className="btn btn-primary outline" to="/create">Create Todo Item</Link> */}

        {
            props.todos.map((item, index) => {
                console.log("list item", props.todos);
                return <TodoItem key={index} {...item} update={props.update} />;
            })
        }
    </div>
}

export default TodoList
