import 'package:flutter/material.dart';
import 'package:khim_s_application8/core/app_export.dart';
import 'package:khim_s_application8/presentation/data_screen/models/data_model.dart';

/// A controller class for the DataScreen.
///
/// This class manages the state of the DataScreen, including the
/// current dataModelObj
class DataController extends GetxController {
  TextEditingController faceImageController = TextEditingController();

  TextEditingController validityController = TextEditingController();

  TextEditingController personalInformationController = TextEditingController();

  Rx<DataModel> dataModelObj = DataModel().obs;
  Map<dynamic, dynamic>? reNFC;

  @override
  void onClose() {
    super.onClose();
    faceImageController.dispose();
    validityController.dispose();
    personalInformationController.dispose();
    reNFC = Get.arguments;
    print("NFC DATA: $reNFC");
  }
}
