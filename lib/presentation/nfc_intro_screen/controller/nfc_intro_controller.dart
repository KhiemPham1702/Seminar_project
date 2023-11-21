import 'package:khim_s_application8/core/app_export.dart';
import 'package:khim_s_application8/presentation/nfc_intro_screen/models/nfc_intro_model.dart';

/// A controller class for the NfcIntroScreen.
///
/// This class manages the state of the NfcIntroScreen, including the
/// current nfcIntroModelObj
class NfcIntroController extends GetxController {
  Rx<NfcIntroModel> nfcIntroModelObj = NfcIntroModel().obs;
}
