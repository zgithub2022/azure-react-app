/* eslint-disable */
import { useState } from 'react';

export default function TaskList() {
  const [tasks, setTasks] = useState([
    { id: 1, text: 'Learn React', completed: true },
    { id: 2, text: 'Build a task list', completed: false },
    { id: 3, text: 'Deploy your application', completed: false }
  ]);
  
  const [newTaskText, setNewTaskText] = useState('');
  
  const addTask = () => {
    if (newTaskText.trim() === '') return;
    
    const newTask = {
      id: Date.now(),
      text: newTaskText,
      completed: false
    };
    
    setTasks([...tasks, newTask]);
    setNewTaskText('');
  };
  
  const toggleTaskCompletion = (taskId) => {
    setTasks(tasks.map(task => 
      task.id === taskId ? { ...task, completed: !task.completed } : task
    ));
  };
  
  const deleteTask = (taskId) => {
    setTasks(tasks.filter(task => task.id !== taskId));
  };
  
  const handleKeyPress = (e) => {
    if (e.key === 'Enter') {
      addTask();
    }
  };
  
  return (
    <div className="max-w-md mx-auto p-6 bg-white rounded-lg shadow-lg">
      <h1 className="text-2xl font-bold mb-6 text-center text-gray-800">Devops Task List</h1>      
      <div className="flex mb-4">
        <input
          type="text"
          value={newTaskText}
          onChange={(e) => setNewTaskText(e.target.value)}
          onKeyPress={handleKeyPress}
          placeholder="Add a new task..."
          className="flex-grow px-4 py-2 border rounded-l focus:outline-none"
        />
        <button 
          onClick={addTask}
          className="bg-blue-500 hover:bg-blue-600 text-white px-4 py-2 rounded-r flex items-center justify-center"
        >
          <span className="text-lg font-bold">+</span>
        </button>
      </div>
      
      <ul className="space-y-2">
        {tasks.map(task => (
          <li 
            key={task.id} 
            className={`flex items-center justify-between p-3 border rounded ${
              task.completed ? 'bg-gray-100' : 'bg-white'
            }`}
          >
            <div className="flex items-center">
              <button 
                onClick={() => toggleTaskCompletion(task.id)}
                className={`mr-3 w-6 h-6 flex items-center justify-center rounded-full ${
                  task.completed ? 'bg-green-500 text-white' : 'bg-gray-200'
                }`}
              >
                {task.completed ? '✓' : ' '}
              </button>
              <span 
                className={`${
                  task.completed ? 'line-through text-gray-500' : 'text-gray-800'
                }`}
              >
                {task.text}
              </span>
            </div>
            <button 
              onClick={() => deleteTask(task.id)}
              className="text-red-500 hover:text-red-700 px-2"
              aria-label="Delete task"
            >
              <span className="text-xl">×</span>
            </button>
          </li>
        ))}
      </ul>
      
      {tasks.length === 0 && (
        <p className="text-center text-gray-500 mt-4">No tasks yet. Add some!</p>
      )}
      
      <div className="mt-4 text-sm text-gray-500">
        {tasks.filter(task => task.completed).length} of {tasks.length} tasks completed
      </div>
    </div>
  );
}