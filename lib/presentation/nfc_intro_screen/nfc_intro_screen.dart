import 'controller/nfc_intro_controller.dart';
import 'package:flutter/material.dart';
import 'package:khim_s_application8/core/app_export.dart';
import 'package:khim_s_application8/widgets/app_bar/appbar_trailing_image.dart';
import 'package:khim_s_application8/widgets/app_bar/custom_app_bar.dart';
import 'package:khim_s_application8/widgets/custom_elevated_button.dart';

class NfcIntroScreen extends GetWidget<NfcIntroController> {
  const NfcIntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 14.v),
                child: Column(children: [
                  SizedBox(height: 44.v),
                  Container(
                      width: 400.h,
                      padding:
                          EdgeInsets.symmetric(horizontal: 19.h, vertical: 4.v),
                      decoration: AppDecoration.fillOnPrimaryContainer,
                      child: Text("msg_read_the_nfc_chip".tr,
                          style: theme.textTheme.headlineSmall)),
                  SizedBox(height: 12.v),
                  Container(
                      width: 382.h,
                      margin: EdgeInsets.symmetric(horizontal: 9.h),
                      child: Text("msg_place_the_phone".tr,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                          style: theme.textTheme.bodyLarge)),
                  Spacer(),
                  CustomElevatedButton(
                      text: "lbl_next".tr,
                      margin: EdgeInsets.symmetric(horizontal: 10.h),
                      onPressed: () {
                        onTapNext();
                      }),
                  SizedBox(height: 23.v),
                  SizedBox(
                      height: 5.v,
                      width: 200.h,
                      child: Stack(alignment: Alignment.center, children: [
                        Align(
                            alignment: Alignment.center,
                            child: SizedBox(width: 200.h, child: Divider())),
                        Align(
                            alignment: Alignment.center,
                            child: SizedBox(width: 200.h, child: Divider()))
                      ]))
                ]))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
        title: Padding(
            padding: EdgeInsets.only(left: 22.h),
            child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "lbl_read".tr,
                      style: CustomTextStyles.displayMediumPinkA100),
                  TextSpan(
                      text: "lbl_id".tr,
                      style: CustomTextStyles.displayMediumYellow200)
                ]),
                textAlign: TextAlign.left)),
        actions: [
          AppbarTrailingImage(
              imagePath: ImageConstant.imgVector,
              margin: EdgeInsets.symmetric(horizontal: 24.h, vertical: 25.v))
        ],
        styleType: Style.bgOutline);
  }

  /// Navigates to the nfcInstructionScreen when the action is triggered.
  onTapNext() {
    Get.toNamed(
      AppRoutes.nfcInstructionScreen,
    );
  }
}
