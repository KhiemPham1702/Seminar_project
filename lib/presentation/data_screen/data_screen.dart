import 'controller/data_controller.dart';
import 'package:flutter/material.dart';
import 'package:khim_s_application8/core/app_export.dart';
import 'package:khim_s_application8/widgets/app_bar/appbar_trailing_image.dart';
import 'package:khim_s_application8/widgets/app_bar/custom_app_bar.dart';
import 'package:khim_s_application8/widgets/custom_elevated_button.dart';
import 'package:khim_s_application8/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class DataScreen extends GetWidget<DataController> {
  const DataScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 10.h,
            vertical: 14.v,
          ),
          child: Column(
            children: [
              SizedBox(height: 44.v),
              Container(
                width: 400.h,
                padding: EdgeInsets.symmetric(
                  horizontal: 18.h,
                  vertical: 4.v,
                ),
                decoration: AppDecoration.fillOnPrimaryContainer,
                child: Text(
                  "msg_identity_card_chip".tr,
                  style: theme.textTheme.headlineSmall,
                ),
              ),
              SizedBox(height: 63.v),
              _buildFaceImage(),
              SizedBox(height: 9.v),
              CustomImageView(
                imagePath: ImageConstant.imgRectangle9,
                height: 150.v,
                width: 120.h,
              ),
              SizedBox(height: 9.v),
              _buildValidity(),
              SizedBox(height: 14.v),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 19.h,
                    right: 71.h,
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: 10.v,
                          bottom: 11.v,
                        ),
                        child: Text(
                          "msg_verification_result".tr,
                          style: theme.textTheme.bodyLarge,
                        ),
                      ),
                      Container(
                        width: 133.h,
                        margin: EdgeInsets.only(left: 37.h),
                        child: Text(
                          "msg_authenticity_not".tr,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: CustomTextStyles.bodyLargeOnPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8.v),
              _buildPersonalInformation(),
              SizedBox(height: 8.v),
              _buildFour(),
              SizedBox(height: 23.v),
              SizedBox(
                height: 5.v,
                width: 200.h,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 200.h,
                        child: Divider(),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 200.h,
                        child: Divider(),
                      ),
                    ),
                  ],
                ),
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
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgVector,
          margin: EdgeInsets.symmetric(
            horizontal: 24.h,
            vertical: 25.v,
          ),
        ),
      ],
      styleType: Style.bgOutline_1,
    );
  }

  /// Section Widget
  Widget _buildFaceImage() {
    return CustomTextFormField(
      controller: controller.faceImageController,
      hintText: "lbl_face_image".tr,
    );
  }

  /// Section Widget
  Widget _buildValidity() {
    return CustomTextFormField(
      controller: controller.validityController,
      hintText: "lbl_validity".tr,
    );
  }

  /// Section Widget
  Widget _buildPersonalInformation() {
    return CustomTextFormField(
      controller: controller.personalInformationController,
      hintText: "msg_personal_information".tr,
      textInputAction: TextInputAction.done,
    );
  }

  /// Section Widget
  Widget _buildFinish() {
    return CustomElevatedButton(
      width: 380.h,
      text: "lbl_finish".tr,
      alignment: Alignment.bottomCenter,
    );
  }

  /// Section Widget
  Widget _buildFour() {
    return SizedBox(
      height: 288.v,
      width: 400.h,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTwo(
                  givenNames: "lbl_full_name".tr,
                  pHUNGGIAKHIEM: "msg_pham_phung_gia".tr,
                ),
                SizedBox(height: 1.v),
                _buildTwo(
                  givenNames: "lbl_given_names".tr,
                  pHUNGGIAKHIEM: "lbl_phung_gia_khiem".tr,
                ),
                SizedBox(height: 1.v),
                _buildTwo(
                  givenNames: "lbl_name".tr,
                  pHUNGGIAKHIEM: "lbl_pham".tr,
                ),
                SizedBox(height: 1.v),
                _buildTwo(
                  givenNames: "lbl_gender".tr,
                  pHUNGGIAKHIEM: "lbl_female".tr,
                ),
                SizedBox(height: 1.v),
                _buildTwo(
                  givenNames: "lbl_nationality".tr,
                  pHUNGGIAKHIEM: "lbl_vietnamese".tr,
                ),
              ],
            ),
          ),
          _buildFinish(),
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildTwo({
    required String givenNames,
    required String pHUNGGIAKHIEM,
  }) {
    return Container(
      padding: EdgeInsets.fromLTRB(14.h, 14.v, 14.h, 13.v),
      decoration: AppDecoration.outlineSecondaryContainer,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 3.v),
            child: Text(
              givenNames,
              style: theme.textTheme.bodyLarge!.copyWith(
                color: appTheme.black900,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              right: 26.h,
              bottom: 3.v,
            ),
            child: Text(
              pHUNGGIAKHIEM,
              style: CustomTextStyles.bodyLargeExtraLight.copyWith(
                color: appTheme.black900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
