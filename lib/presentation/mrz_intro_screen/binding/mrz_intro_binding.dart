import '../controller/mrz_intro_controller.dart';
import 'package:get/get.dart';

/// A binding class for the MrzIntroScreen.
///
/// This class ensures that the MrzIntroController is created when the
/// MrzIntroScreen is first loaded.
class MrzIntroBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MrzIntroController());
  }
}
