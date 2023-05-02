package com.todo.todo_api.controller;

import com.todo.todo_api.exception.TaskNotFoundException;
import com.todo.todo_api.model.Task;
import com.todo.todo_api.service.TaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("api/todo")
public class TaskController {

    @Autowired
    private TaskService taskService;

    @GetMapping("/tasks")
    public List<Task> getAllTasks(){
        return taskService.getAllTasks();
    }
    @GetMapping("/tasks/{id}")
    public Task getTask(@PathVariable int id) throws TaskNotFoundException {
        return taskService.getTask(id);
    }
    @PostMapping("/task")
    public void addTask(@RequestBody Task task){
       taskService.addTask(task);

    }
    @PutMapping("/tasks/{id}")
    public ResponseEntity<Task> updateTask(@PathVariable int id, @RequestBody Task task) throws TaskNotFoundException {
        return taskService.updateTask(id,task);
    }
    @DeleteMapping("/tasks/{id}")
    public ResponseEntity<Map<String,Boolean>> deleteTask(@PathVariable int id) throws TaskNotFoundException {
        return taskService.deleteTask(id);
    }

}
