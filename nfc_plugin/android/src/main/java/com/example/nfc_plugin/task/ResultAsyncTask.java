package com.example.nfc_plugin.task;

import android.os.AsyncTask;

public abstract class ResultAsyncTask<Params, Progress, R> extends AsyncTask<Params, Progress, TaskResult<R>> {
    public ResultAsyncTask() {
    }
}