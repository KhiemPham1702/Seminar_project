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
  RxBool isReady = false.obs;
  var instructionText = "msg_keep_the_phone_on".tr.obs;
  @override
  void onInit() {
    super.onInit();
    isReady.value = true;
    NfcPlugin.nfcProgressChannel
        .receiveBroadcastStream()
        .listen((dynamic event) {
      isNfcScanning.value = true;
    });
  }
}
