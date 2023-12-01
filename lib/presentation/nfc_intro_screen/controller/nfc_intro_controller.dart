import 'package:khim_s_application8/core/app_export.dart';
import 'package:khim_s_application8/presentation/nfc_intro_screen/models/nfc_intro_model.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../data_screen/controller/data_controller.dart';

/// A controller class for the NfcIntroScreen.
///
/// This class manages the state of the NfcIntroScreen, including the
/// current nfcIntroModelObj
class NfcIntroController extends GetxController {
  Rx<NfcIntroModel> nfcIntroModelObj = NfcIntroModel().obs;
  String textFieldValue1 = '';
  String textFieldValue2 = '';
  String textFieldValue3 = '';
  bool isLoading = false;

  Map<String, dynamic>? result;
  String? dataMRZ = '';
  final DataController dataController = Get.put(DataController());
  PermissionStatus _permissionStatus = PermissionStatus.denied;

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    _permissionStatus = status;
  }

  String convertToYYMMDD(String input) {
    List<String> parts = input.split(' ')[0].split('-');
    String year = parts[0].substring(2);
    String month = parts[1];
    String day = parts[2];

    return '$year$month$day';
  }

  String convertToCCCDFormat(String input) {
    if (input.length >= 2) {
      return input.substring(0, input.length - 3);
    } else {
      return input;
    }
  }

  Future<void> dataRe() async {
    print(
        "DATA=========================${convertToYYMMDD(result?['Birthdate'])}");
    print(
        "DATA=========================${convertToYYMMDD(result?['Expiry date'])}");
    print("DATA=========================${convertToCCCDFormat(result?['ID'])}");
  }

  // Future<void> _scanMRZ() async {
  //   if (_permissionStatus == PermissionStatus.granted) {
  //     result = await Navigator.push<Map<String, dynamic>>(
  //       context,
  //       MaterialPageRoute(builder: (context) => CameraPage()),
  //     );

  //     if (result != null) {
  //       setState(() {
  //         textFieldValue2 =
  //             '${convertToYYMMDD(result!['Birthdate'].toString())}';
  //         textFieldValue3 =
  //             '${convertToYYMMDD(result!['Expiry date'].toString())}';
  //         textFieldValue1 = '${convertToCCCDFormat(result!['ID'].toString())}';
  //       });
  //     }
  //   } else {
  //     _requestCameraPermission();
  //   }
}
