import React from 'react';
import UserName from './UserName';
import { Link } from 'react-router-dom';
import DeleteTodoItem from './DeleteTodoItem';

const TodoItem = (props) => {
    const completedClass = props.completed ? 'todo__item--completed' : '';
    return (<div className={`todo__item ${completedClass}`}>
        {/* {console.log("item props", props)} */}
        <p className='todo__title'>{props.title}</p>
        <div className='todo__assignee'>
            <div className = 'todo__ulabel'>Assigned To:</div>
            <UserName {...props.user} />
        </div>
        <div className="todo__edit">
        {console.log("props user",props.user.id, props.id)}
            <Link to={`/update/${props.user.id}/${props.id}`}>Update</Link>
        </div>
        <div className="todo__delete">
            <DeleteTodoItem id={props.id} update={props.update} />
        </div>
    </div>);
}


export default TodoItem;
