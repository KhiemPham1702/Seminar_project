import 'package:get/get.dart';
import 'package:khim_s_application8/presentation/camera_screen/controller/camera_controller.dart';

/// A binding class for the DataScreen.
///
/// This class ensures that the DataController is created when the
/// DataScreen is first loaded.
class CameraBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CameraController());
  }
}
