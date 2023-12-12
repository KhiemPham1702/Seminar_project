import 'package:flutter/services.dart';

import 'nfc_plugin_platform_interface.dart';

class NfcPlugin {
  Future<String?> getPlatformVersion() {
    return NfcPluginPlatform.instance.getPlatformVersion();
  }

  static const EventChannel nfcProgressChannel =
      EventChannel('com.example.nfc_reader/progress');

  Future<Map<dynamic, dynamic>?> sendDataToNative(String textFieldValue1,
      String textFieldValue2, String textFieldValue3) async {
    const MethodChannel platformChannel =
        MethodChannel('com.example.nfc_reader/channel');
    try {
      final Map<String, String> data = {
        'data1': textFieldValue1,
        'data2': textFieldValue2,
        'data3': textFieldValue3,
      };
      return await platformChannel.invokeMethod('sendDataToNative', data);
    } on PlatformException catch (e) {
      // var logger = Logger();
      // logger.e("Error: ${e.message}");
      return null;
    }
  }

  static Future<String?> getNFCAvailability() async {
    const MethodChannel platformChannel =
        MethodChannel('com.example.nfc_reader/channel');
    try {
      final String? result =
          await platformChannel.invokeMethod('getNFCAvailability');

      return result;
    } catch (ex) {}
  }
}
