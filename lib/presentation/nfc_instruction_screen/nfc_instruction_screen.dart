import 'package:flutter/material.dart';
import 'package:khim_s_application8/core/app_export.dart';
import 'package:khim_s_application8/widgets/app_bar/custom_app_bar.dart';
import 'package:khim_s_application8/widgets/custom_elevated_button.dart';
import 'package:nfc_plugin/nfc_plugin.dart';

import 'controller/nfc_instruction_controller.dart';

// ignore_for_file: must_be_immutable
class NfcInstructionScreen extends GetWidget<NfcInstructionController> {
  const NfcInstructionScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? data = Get.arguments;
    controller.result = data;

    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 15.h,
            vertical: 50.v,
          ),
          child: Column(
            children: [
              Container(
                width: 400.h,
                padding: EdgeInsets.symmetric(
                  horizontal: 19.h,
                  vertical: 0.v,
                ),
                decoration: AppDecoration.fillOnPrimaryContainer,
                child: Text(
                  "msg_read_the_nfc_chip".tr,
                  style: theme.textTheme.headlineSmall,
                ),
              ),
              SizedBox(height: 12.v),
              Container(
                width: 382.h,
                margin: EdgeInsets.symmetric(horizontal: 9.h),
                child: Text(
                  "msg_please_hold_the".tr,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                  style: theme.textTheme.bodyLarge,
                ),
              ),
              Obx(() {
                if (controller.isNfcScanning.value) {
                  return _buildNfcScanningDialog();
                } else {
                  return Column(
                    children: [
                      Container(
                        child: Image.asset('assets/images/nfc_check.gif'),
                        height: 400,
                        width: 400,
                      ),
                      Container(
                        width: 366.h,
                        margin: EdgeInsets.symmetric(horizontal: 17.h),
                        child: Text(
                          controller.instructionText.value,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  );
                }
              }),
            ],
          ),
        ),
        bottomNavigationBar: _buildNext(),
      ),
    );
  }

  Widget _buildNext() {
    return CustomElevatedButton(
        text: "Start Scan CCCD".tr,
        margin: EdgeInsets.only(left: 25.h, right: 25.h, bottom: 42.v),
        onPressed: () {
          controller.instructionText.value =
              "Place the card in the scanning area";
          controller.onInit();
          startNfcScanning();
        });
  }

  void startNfcScanning() async {
    try {
      NfcPlugin plugin = NfcPlugin();
      Map<dynamic, dynamic>? re = await plugin.sendDataToNative(
          controller.result?['ID'],
          controller.result?['Birthdate'],
          controller.result?['Expiry date']);
      if (re?['photo'] != null) {
        showSuccessDialog("Scan NFC success", re);
      } else {
        controller.instructionText.value = "msg_keep_the_phone_on".tr;
        showErrorDialog("Scan false. Please try again.");
      }
    } catch (e) {
    } finally {
      controller.isNfcScanning.value = false;
    }
  }

  void showErrorDialog(String successMessage) {
    Get.defaultDialog(
      title: 'Success',
      content: Column(
        children: [
          Icon(
            Icons.error_outlined,
            color: Colors.red,
            size: 50,
          ),
          SizedBox(height: 10),
          Text(
            successMessage,
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
      barrierDismissible: false,
      textConfirm: 'OK',
      buttonColor: Color.fromRGBO(147, 118, 224, 1),
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
      },
    );
  }

  void showSuccessDialog(String successMessage, Map<dynamic, dynamic>? re) {
    Get.defaultDialog(
      title: 'Success',
      content: Column(
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 50,
          ),
          SizedBox(height: 10),
          Text(
            successMessage,
            style: TextStyle(color: Colors.green),
          ),
        ],
      ),
      barrierDismissible: false,
      textConfirm: 'OK',
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
        Get.toNamed(AppRoutes.dataScreen, arguments: re);
      },
    );
  }

  Widget _buildNfcScanningDialog() {
    startNfcScanning();
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 300.v),
          Text(
            "Hold the CCCD card steady",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge,
          ),
          SizedBox(height: 12.v),
          Text(
            "Scanning...",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge,
          ),
          SizedBox(height: 12.v),
          LinearProgressIndicator(),
        ],
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      title: Padding(
        padding: EdgeInsets.only(left: 22.h),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "lbl_read".tr,
                style: CustomTextStyles.displayMediumPinkA100,
              ),
              TextSpan(
                text: "lbl_id".tr,
                style: CustomTextStyles.displayMediumYellow200,
              ),
            ],
          ),
          textAlign: TextAlign.left,
        ),
      ),
      styleType: Style.bgOutline,
    );
  }
}
