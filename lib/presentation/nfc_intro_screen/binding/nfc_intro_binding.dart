import '../controller/nfc_intro_controller.dart';
import 'package:get/get.dart';

/// A binding class for the NfcIntroScreen.
///
/// This class ensures that the NfcIntroController is created when the
/// NfcIntroScreen is first loaded.
class NfcIntroBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NfcIntroController());
  }
}
