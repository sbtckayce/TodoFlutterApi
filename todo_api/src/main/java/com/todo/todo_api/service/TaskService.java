package com.todo.todo_api.service;

import com.todo.todo_api.exception.TaskNotFoundException;
import com.todo.todo_api.model.Task;
import com.todo.todo_api.repository.TaskRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class TaskService {

    @Autowired
    private TaskRepository taskRepository;

    public List<Task> getAllTasks() {
        return taskRepository.findAll();
    }

    public void addTask(Task task) {
        taskRepository.save(task);
    }
    public Task getTask(int id) throws TaskNotFoundException {
        Task task = taskRepository.findById(id).orElseThrow(() -> new TaskNotFoundException("Task not found" + id));
        return ResponseEntity.ok(task).getBody();
    }
    public ResponseEntity<Task> updateTask(int id, Task taskNew) throws TaskNotFoundException {
        Task task = taskRepository.findById(id).orElseThrow(() -> new TaskNotFoundException("Task not found" + id));

        task.setTitle(taskNew.getTitle());
        task.setDescription(taskNew.getDescription());
        task.setDateTime(taskNew.getDateTime());
        task.setComplete(taskNew.isComplete());
        Task taskUpdate = taskRepository.save(task);
        return ResponseEntity.ok(taskUpdate);
    }

    public ResponseEntity<Map<String, Boolean>> deleteTask(int id) throws TaskNotFoundException {
        Task task = taskRepository.findById(id).orElseThrow(() -> new TaskNotFoundException("Task not found" + id));
        taskRepository.delete(task);
        Map<String,Boolean> re= new HashMap<>();
        re.put("delete",Boolean.TRUE);
        return ResponseEntity.ok(re);
    }

}
