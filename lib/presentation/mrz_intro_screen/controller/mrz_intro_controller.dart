import 'package:khim_s_application8/core/app_export.dart';
import 'package:khim_s_application8/presentation/mrz_intro_screen/models/mrz_intro_model.dart';

/// A controller class for the MrzIntroScreen.
///
/// This class manages the state of the MrzIntroScreen, including the
/// current mrzIntroModelObj
class MrzIntroController extends GetxController {
  Rx<MrzIntroModel> mrzIntroModelObj = MrzIntroModel().obs;
}
