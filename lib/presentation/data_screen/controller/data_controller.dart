import 'package:khim_s_application8/core/app_export.dart';
import 'package:khim_s_application8/presentation/data_screen/models/data_model.dart';
import 'package:flutter/material.dart';

/// A controller class for the DataScreen.
///
/// This class manages the state of the DataScreen, including the
/// current dataModelObj
class DataController extends GetxController {
  TextEditingController faceImageController = TextEditingController();

  TextEditingController validityController = TextEditingController();

  TextEditingController personalInformationController = TextEditingController();

  Rx<DataModel> dataModelObj = DataModel().obs;

  @override
  void onClose() {
    super.onClose();
    faceImageController.dispose();
    validityController.dispose();
    personalInformationController.dispose();
  }
}
