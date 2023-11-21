import '../controller/data_controller.dart';
import 'package:get/get.dart';

/// A binding class for the DataScreen.
///
/// This class ensures that the DataController is created when the
/// DataScreen is first loaded.
class DataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DataController());
  }
}
