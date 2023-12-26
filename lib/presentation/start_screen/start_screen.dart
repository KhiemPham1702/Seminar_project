import 'package:flutter/material.dart';
import 'package:khim_s_application8/core/app_export.dart';
import 'package:khim_s_application8/widgets/app_bar/custom_app_bar.dart';
import 'package:khim_s_application8/widgets/custom_elevated_button.dart';

import 'controller/start_controller.dart';

class StartScreen extends GetWidget<StartController> {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 17.v),
                child: Column(children: [
                  SizedBox(height: 41.v),
                  Container(
                      width: 400.h,
                      padding:
                          EdgeInsets.symmetric(horizontal: 19.h, vertical: 3.v),
                      decoration: AppDecoration.fillOnPrimaryContainer,
                      child: Text("lbl_use_readid_me".tr,
                          style: theme.textTheme.headlineSmall)),
                  SizedBox(height: 12.v),
                  Container(
                      width: 382.h,
                      margin: EdgeInsets.symmetric(horizontal: 9.h),
                      child: Text("msg_the_readid_me_app".tr,
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                          style: theme.textTheme.bodyLarge)),
                  Spacer(),
                ])),
            bottomNavigationBar: _buildGetStarted()));
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
        // actions: [
        //   AppbarTrailingImage(
        //       imagePath: ImageConstant.imgVector,
        //       margin: EdgeInsets.symmetric(horizontal: 24.h, vertical: 25.v))
        // ],
        styleType: Style.bgOutline);
  }

  /// Section Widget
  Widget _buildGetStarted() {
    return CustomElevatedButton(
        text: "lbl_get_started".tr,
        margin: EdgeInsets.only(left: 25.h, right: 25.h, bottom: 42.v),
        onPressed: () {
          onTapGetStarted();
        });
  }

  /// Common widget
  Widget _buildFrameOne({
    required String settings,
    required String settings1,
  }) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 5.v),
        decoration: AppDecoration.fillOnPrimaryContainer,
        child: Row(mainAxisSize: MainAxisSize.max, children: [
          CustomImageView(
              imagePath: settings,
              height: 30.adaptSize,
              width: 30.adaptSize,
              margin: EdgeInsets.only(top: 2.v, bottom: 1.v)),
          Padding(
              padding: EdgeInsets.only(left: 18.h, top: 2.v),
              child: Text(settings1,
                  style: CustomTextStyles.headlineSmallPrimary
                      .copyWith(color: theme.colorScheme.primary)))
        ]));
  }

  /// Navigates to the mrzIntroScreen when the action is triggered.
  onTapGetStarted() {
    Get.toNamed(
      AppRoutes.mrzIntroScreen,
    );
  }
}
