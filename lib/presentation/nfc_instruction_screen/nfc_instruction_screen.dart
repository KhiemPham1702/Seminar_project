import 'package:flutter/material.dart';
import 'package:khim_s_application8/core/app_export.dart';
import 'package:khim_s_application8/widgets/app_bar/custom_app_bar.dart';

import 'controller/nfc_instruction_controller.dart';

// ignore_for_file: must_be_immutable
class NfcInstructionScreen extends GetWidget<NfcInstructionController> {
  const NfcInstructionScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
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
              // Spacer(
              //   flex: 34,
              // ),
              Container(
                child: Image.asset('assets/images/nfc_check.gif'),
                height: 400,
                width: 400,
              ),
              // CustomImageView(
              //   imagePath: ImageConstant.imgMingcuteRightLine,
              //   height: 35.adaptSize,
              //   width: 35.adaptSize,
              //   alignment: Alignment.centerRight,
              // ),
              // Spacer(
              //   flex: 34,
              // ),
              Container(
                width: 366.h,
                margin: EdgeInsets.symmetric(horizontal: 17.h),
                child: Text(
                  "msg_keep_the_phone_on".tr,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge,
                ),
              ),
              // SizedBox(height: 19.v),
              // CustomImageView(
              //   imagePath: ImageConstant.imgGroup1,
              //   height: 18.v,
              //   width: 61.h,
              // ),
              Spacer(
                flex: 30,
              ),
            ],
          ),
        ),
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
      // actions: [
      //   AppbarTrailingImage(
      //     imagePath: ImageConstant.imgVector,
      //     margin: EdgeInsets.symmetric(
      //       horizontal: 24.h,
      //       vertical: 25.v,
      //     ),
      //   ),
      // ],
      styleType: Style.bgOutline,
    );
  }
}
