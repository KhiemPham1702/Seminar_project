import 'package:flutter_test/flutter_test.dart';
import 'package:nfc_plugin/nfc_plugin.dart';
import 'package:nfc_plugin/nfc_plugin_platform_interface.dart';
import 'package:nfc_plugin/nfc_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockNfcPluginPlatform
    with MockPlatformInterfaceMixin
    implements NfcPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final NfcPluginPlatform initialPlatform = NfcPluginPlatform.instance;

  test('$MethodChannelNfcPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelNfcPlugin>());
  });

  test('getPlatformVersion', () async {
    NfcPlugin nfcPlugin = NfcPlugin();
    MockNfcPluginPlatform fakePlatform = MockNfcPluginPlatform();
    NfcPluginPlatform.instance = fakePlatform;

    expect(await nfcPlugin.getPlatformVersion(), '42');
  });
}
