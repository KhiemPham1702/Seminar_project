import 'package:khim_s_application8/core/app_export.dart';
import 'package:khim_s_application8/presentation/mrz_intro_screen/models/mrz_intro_model.dart';
import 'package:permission_handler/permission_handler.dart';

/// A controller class for the MrzIntroScreen.
///
/// This class manages the state of the MrzIntroScreen, including the
/// current mrzIntroModelObj
class MrzIntroController extends GetxController {
  Rx<MrzIntroModel> mrzIntroModelObj = MrzIntroModel().obs;
  Future<void> requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (status.isDenied) {
      await Permission.camera.request();
      status = await Permission.camera.status;
    }
  }
}
