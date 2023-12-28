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
  Image? image;

  @override
  void onClose() {
    super.onClose();
    faceImageController.dispose();
    validityController.dispose();
    personalInformationController.dispose();
  }

  String convertDateFormat(String inputDate) {
    List<String> dateParts = inputDate.split('/');
    int day = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int year = int.parse(dateParts[2]);

    DateTime newDate = DateTime(year + 25, month, day);

    String formattedDate = '${newDate.day.toString().padLeft(2, '0')}/'
        '${newDate.month.toString().padLeft(2, '0')}/'
        '${newDate.year.toString()}';

    return formattedDate;
  }
}
