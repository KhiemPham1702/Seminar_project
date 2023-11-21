import 'package:khim_s_application8/core/app_export.dart';
import 'package:khim_s_application8/data/apiClient/api_client.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(PrefUtils());
    Get.put(ApiClient());
    Connectivity connectivity = Connectivity();
    Get.put(NetworkInfo(connectivity));
  }
}
