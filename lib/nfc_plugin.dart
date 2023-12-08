
import 'nfc_plugin_platform_interface.dart';

class NfcPlugin {
  Future<String?> getPlatformVersion() {
    return NfcPluginPlatform.instance.getPlatformVersion();
  }
}
