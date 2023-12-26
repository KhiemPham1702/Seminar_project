import 'package:khim_s_application8/core/app_export.dart';
import 'package:khim_s_application8/presentation/nfc_instruction_screen/models/nfc_instruction_model.dart';
import 'package:nfc_plugin/nfc_plugin.dart';

/// A controller class for the NfcInstructionScreen.
///
/// This class manages the state of the NfcInstructionScreen, including the
/// current nfcInstructionModelObj
class NfcInstructionController extends GetxController {
  Rx<NfcInstructionModel> nfcInstructionModelObj = NfcInstructionModel().obs;
  Map<String, dynamic>? result;
  RxBool isNfcScanning = false.obs;
  @override
  void onInit() {
    super.onInit();
    NfcPlugin.nfcProgressChannel
        .receiveBroadcastStream()
        .listen((dynamic event) {
      isNfcScanning.value = true;
      print("ISCANNING:${isNfcScanning.value}");
    });
  }
}
