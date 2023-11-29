import 'package:flutter/material.dart';
import 'package:khim_s_application8/core/app_export.dart';
import 'package:khim_s_application8/widgets/app_bar/custom_app_bar.dart';
import 'package:khim_s_application8/widgets/custom_elevated_button.dart';

import 'controller/mrz_intro_controller.dart';

class MrzIntroScreen extends GetWidget<MrzIntroController> {
  const MrzIntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 58.v),
                child: Column(children: [
                  Container(
                      width: 400.h,
                      padding:
                          EdgeInsets.symmetric(horizontal: 19.h, vertical: 3.v),
                      decoration: AppDecoration.fillOnPrimaryContainer,
                      child: Text("msg_scan_the_document".tr,
                          style: theme.textTheme.headlineSmall)),
                  SizedBox(height: 12.v),
                  Container(
                      width: 382.h,
                      margin: EdgeInsets.symmetric(horizontal: 9.h),
                      child: Text("msg_flip_the_identity".tr,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                          style: theme.textTheme.bodyLarge)),
                  SizedBox(height: 5.v),
                  Container(
                    child: Image.asset('assets/images/mrz_intro.gif'),
                    height: 400,
                    width: 400,
                  )
                ])),
            bottomNavigationBar: _buildNext()));
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
  Widget _buildNext() {
    return CustomElevatedButton(
        text: "lbl_next".tr,
        margin: EdgeInsets.only(left: 25.h, right: 25.h, bottom: 42.v),
        onPressed: () {
          onTapNext();
        });
  }

  /// Navigates to the nfcIntroScreen when the action is triggered.
  onTapNext() {
    Get.toNamed(
      AppRoutes.nfcIntroScreen,
    );
  }
}
