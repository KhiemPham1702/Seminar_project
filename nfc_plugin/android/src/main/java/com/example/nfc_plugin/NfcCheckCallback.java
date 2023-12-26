package com.example.nfc_plugin;

import android.graphics.Bitmap;

import java.util.Map;

public interface NfcCheckCallback {
    void onNfcCheckDone(Map<String, String> nfcResult, Bitmap photo);
    void onProgress(String text);
}
