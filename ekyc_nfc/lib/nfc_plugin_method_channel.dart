import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'nfc_plugin_platform_interface.dart';

/// An implementation of [NfcPluginPlatform] that uses method channels.
class MethodChannelNfcPlugin extends NfcPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('nfc_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
