package com.example.nfc_plugin;

import android.app.Activity;
import android.content.Context;
import android.graphics.Bitmap;
import android.nfc.NfcAdapter;

import androidx.annotation.NonNull;

import java.io.ByteArrayOutputStream;
import java.util.HashMap;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** NfcPlugin */
public class NfcPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware, NfcCheckCallback {
  private MethodChannel channel;

  private EventChannel progressEventChannel;
  private EventChannel.EventSink progressEventSink;
  private Context context;
  private FlutterPluginBinding pluginBinding;
  private NfcAdapter nfcAdapter;
  private Activity activity;

  private Result nfcResultCallback;

  String progress;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "com.example.nfc_reader/channel");
    progressEventChannel = new EventChannel(flutterPluginBinding.getBinaryMessenger(), "com.example.nfc_reader/progress");
    channel.setMethodCallHandler(this);
    progressEventChannel.setStreamHandler(
            new EventChannel.StreamHandler() {
              @Override
              public void onListen(Object arguments, EventChannel.EventSink eventSink) {
                progressEventSink = eventSink;
              }

              @Override
              public void onCancel(Object arguments) {
                progressEventSink = null;
              }
            }
    );

    context = flutterPluginBinding.getApplicationContext();
    nfcAdapter = NfcAdapter.getDefaultAdapter(context);
    pluginBinding = flutterPluginBinding;
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    }
    else if (call.method.equals("updateProgress")) {
    }
    else if (call.method.equals("getNFCAvailability")) {
      if (nfcAdapter == null) {
        result.success("NFCAvailability.not_supported");
      }else if (nfcAdapter.isEnabled()) {
        result.success("NFCAvailability.available");
      }else {
        result.success("NFCAvailability.disabled");
      }
    }
    else if (call.method.equals("sendDataToNative")) {

      String data1 = call.argument("data1");
      String data2 = call.argument("data2");
      String data3 = call.argument("data3");

      ClientScanInfo clientScanInfo = ClientScanInfo.getInstance();
      clientScanInfo.set_idNumber(data1);
      clientScanInfo.set_birthDate(data2);
      clientScanInfo.set_expirationDate(data3);

      nfcResultCallback = result;
      NfcReaderActivity.startActivity(context, this);
    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onNfcCheckDone(Map<String, String> result, Bitmap photo) {
    // Khi nhận được kết quả từ NfcCheck, xử lý và gửi nó về Flutter thông qua nfcResultCallback.success()
    byte[] byteArray = null;
    if(photo != null) {
      ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
      photo.compress(Bitmap.CompressFormat.PNG, 80, byteArrayOutputStream);
      byteArray = byteArrayOutputStream.toByteArray();
    }

    // Truyền Bitmap và kết quả về Flutter qua Platform Channel
    Map<String, Object> resultMap = new HashMap<>();
    resultMap.put("nfcResult", result);
    resultMap.put("photo", byteArray);
    nfcResultCallback.success(resultMap);
  }

  @Override
  public void onProgress(String text) {
    //Truyền trạng thái nhận thẻ thông qua EventSink
    if (progressEventSink != null) {
      progressEventSink.success(text);
    } else progressEventSink.success("lỗi");
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
    activity = binding.getActivity();
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {
  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
  }

  @Override
  public void onDetachedFromActivity() {
  }
}
