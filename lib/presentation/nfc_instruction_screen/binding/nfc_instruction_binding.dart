import '../controller/nfc_instruction_controller.dart';
import 'package:get/get.dart';

/// A binding class for the NfcInstructionScreen.
///
/// This class ensures that the NfcInstructionController is created when the
/// NfcInstructionScreen is first loaded.
class NfcInstructionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NfcInstructionController());
  }
}
