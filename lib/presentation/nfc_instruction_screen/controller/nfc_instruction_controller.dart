import 'package:khim_s_application8/core/app_export.dart';
import 'package:khim_s_application8/presentation/nfc_instruction_screen/models/nfc_instruction_model.dart';

/// A controller class for the NfcInstructionScreen.
///
/// This class manages the state of the NfcInstructionScreen, including the
/// current nfcInstructionModelObj
class NfcInstructionController extends GetxController {
  Rx<NfcInstructionModel> nfcInstructionModelObj = NfcInstructionModel().obs;
}
