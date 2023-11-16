package com.example.mobile_seminar_project.task;

public class TaskResult<T> {
    Throwable error;
    T data;

    public TaskResult(T data) {
        this.data = data;
    }

    public TaskResult(Throwable error) {
        this.error = error;
    }

    public Throwable getError() {
        return this.error;
    }

    public void setError(Throwable error) {
        this.error = error;
    }

    public T getData() {
        return this.data;
    }

    public void setData(T data) {
        this.data = data;
    }
}
