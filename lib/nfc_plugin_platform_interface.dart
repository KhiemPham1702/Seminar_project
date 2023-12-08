import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'nfc_plugin_method_channel.dart';

abstract class NfcPluginPlatform extends PlatformInterface {
  /// Constructs a NfcPluginPlatform.
  NfcPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static NfcPluginPlatform _instance = MethodChannelNfcPlugin();

  /// The default instance of [NfcPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelNfcPlugin].
  static NfcPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [NfcPluginPlatform] when
  /// they register themselves.
  static set instance(NfcPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
