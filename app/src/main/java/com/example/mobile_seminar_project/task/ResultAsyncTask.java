package com.example.mobile_seminar_project.task;

import android.os.AsyncTask;

public abstract class ResultAsyncTask<Params, Progress, R> extends AsyncTask<Params, Progress, TaskResult<R>> {
    public ResultAsyncTask() {
    }
}