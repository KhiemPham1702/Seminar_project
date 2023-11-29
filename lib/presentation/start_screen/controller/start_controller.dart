import 'package:khim_s_application8/core/app_export.dart';
import 'package:khim_s_application8/presentation/start_screen/models/start_model.dart';

/// A controller class for the StartScreen.
///
/// This class manages the state of the StartScreen, including the
/// current startModelObj
class StartController extends GetxController {
  Rx<StartModel> startModelObj = StartModel().obs;

  @override
  void onReady() {}
}
