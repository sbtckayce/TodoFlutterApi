package com.todo.todo_api.exception;


import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.NOT_FOUND)
public class TaskNotFoundException extends Throwable {
    private static final long serialVersionUID =1 ;
    public TaskNotFoundException(String message){
        super(message);
    }

}