import React from 'react';
import ApiService from '../ApiService';

const DeleteTodoItem = props => {
  const id = props.id.toString();
  return <button onClick={() => {
    ApiService.deleteTodoItem({ id: id })
    props.update()
  }}>x</button>;
}

export default DeleteTodoItem;