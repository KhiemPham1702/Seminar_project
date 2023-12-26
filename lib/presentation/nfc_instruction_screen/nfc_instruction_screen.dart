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
            vertical: 58.v,
          ),
          child: Column(
            children: [
              Container(
                width: 400.h,
                padding: EdgeInsets.symmetric(
                  horizontal: 19.h,
                  vertical: 4.v,
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
              Container(
                child: Image.asset('assets/images/nfc_check.gif'),
                height: 400,
                width: 400,
              ),
              Obx(() {
                if (controller.isNfcScanning.value) {
                  return _buildNfcScanningDialog();
                } else {
                  return Container(
                    width: 366.h,
                    margin: EdgeInsets.symmetric(horizontal: 17.h),
                    child: Text(
                      "msg_keep_the_phone_on".tr,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyLarge,
                    ),
                  );
                }
              }),
              CustomElevatedButton(
                  text: "SCAN".tr,
                  margin: EdgeInsets.symmetric(horizontal: 10.h),
                  onPressed: () {
                    controller.onInit();
                    startNfcScanning();
                  }),
              Spacer(
                flex: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void startNfcScanning() async {
    try {
      NfcPlugin plugin = NfcPlugin();
      Map<dynamic, dynamic>? re = await plugin.sendDataToNative(
          controller.result?['ID'],
          controller.result?['Birthdate'],
          controller.result?['Expiry date']);
      if (re != null) {
        Get.toNamed(AppRoutes.dataScreen, arguments: re);
      }
    } catch (e) {
    } finally {
      controller.isNfcScanning.value = false;
    }
  }

  Widget _buildNfcScanningDialog() {
    startNfcScanning();
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text("Quét NFC đang diễn ra..."),
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
