import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:khim_s_application8/core/app_export.dart';
import 'package:khim_s_application8/widgets/app_bar/custom_app_bar.dart';
import 'package:khim_s_application8/widgets/custom_elevated_button.dart';
import 'package:khim_s_application8/widgets/custom_text_form_field.dart';

import 'controller/data_controller.dart';

// ignore_for_file: must_be_immutable
class DataScreen extends GetWidget<DataController> {
  const DataScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    controller.reNFC = Get.arguments;
    print("DATA NFC---------------------------");
    print(controller.reNFC);
    Uint8List? bytes = controller.reNFC?['photo'];
    if (bytes != null) {
      controller.image = Image.memory(bytes);
    } else {
      controller.image = null;
    }
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(),
        body: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10.h,
              vertical: 10.v,
            ),
            child: ListView(
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
                controller.image == null
                    ? Image.asset(
                        ImageConstant.imgRectangle9,
                        height: 150,
                        width: 200,
                      )
                    : Container(
                        height: 150,
                        width: 200,
                        child: controller.image,
                      ),
                SizedBox(height: 9.v),
                _buildValidity(),
                SizedBox(height: 14.v),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 10.h,
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
                _buildTwo(
                  type: "ID".tr,
                  value: controller.reNFC?['nfcResult']['Số CCCD'],
                ),
                SizedBox(height: 1.v),
                _buildTwo(
                  type: "lbl_full_name".tr,
                  value: controller.reNFC?['nfcResult']['Họ tên'],
                ),
                SizedBox(height: 1.v),
                _buildTwo(
                  type: "Birthday".tr,
                  value: controller.reNFC?['nfcResult']['Ngày sinh'],
                ),
                SizedBox(height: 1.v),
                _buildTwo(
                  type: "lbl_gender".tr,
                  value: controller.reNFC?['nfcResult']['Giới tính'],
                ),
                SizedBox(height: 1.v),
                _buildTwo(
                  type: "Issue Date".tr,
                  value: controller.reNFC?['nfcResult']['Ngày cấp'],
                ),
                SizedBox(height: 1.v),
                _buildTwo(
                  type: "Expiry Date".tr,
                  value: controller.convertDateFormat(
                      controller.reNFC?['nfcResult']['Ngày hết hạn']),
                ),
                SizedBox(height: 1.v),
                _buildTwo(
                  type: "Ethnic".tr,
                  value: controller.reNFC?['nfcResult']['Dân tộc'],
                ),
                SizedBox(height: 1.v),
                _buildTwo(
                  type: "Nationality".tr,
                  value: controller.reNFC?['nfcResult']['Quốc tịch'],
                ),
                SizedBox(height: 1.v),
                _buildTwo(
                  type: "Religion".tr,
                  value: controller.reNFC?['nfcResult']['Tôn giáo'],
                ),
                SizedBox(height: 1.v),
                _buildThree(
                  type: "HomeTown".tr,
                  value: controller.reNFC?['nfcResult']['Quê quán'],
                ),
                SizedBox(height: 1.v),
                _buildThree(
                  type: "Address".tr,
                  value: controller.reNFC?['nfcResult']['Địa chỉ'],
                ),
                SizedBox(height: 1.v),
                _buildThree(
                  type: "Identify Characteristics".tr,
                  value: controller.reNFC?['nfcResult']['Đặc điểm nhận dạng'],
                ),
                SizedBox(height: 1.v),
                _buildTwo(
                  type: "Father Name".tr,
                  value: controller.reNFC?['nfcResult']['Tên Cha'],
                ),
                SizedBox(height: 1.v),
                _buildTwo(
                  type: "Mother Name".tr,
                  value: controller.reNFC?['nfcResult']['Tên mẹ'],
                ),
                SizedBox(height: 23.v),
                _buildFinish(),
              ],
            )),
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
      styleType: Style.bgOutline_1,
    );
  }

  /// Section Widget
  Widget _buildFaceImage() {
    return CustomTextFormField(
      controller: controller.faceImageController,
      hintText: "lbl_face_image".tr,
      autofocus: false,
    );
  }

  /// Section Widget
  Widget _buildValidity() {
    return CustomTextFormField(
      controller: controller.validityController,
      hintText: "lbl_validity".tr,
      autofocus: false,
    );
  }

  /// Section Widget
  Widget _buildPersonalInformation() {
    return CustomTextFormField(
      controller: controller.personalInformationController,
      hintText: "msg_personal_information".tr,
      textInputAction: TextInputAction.done,
      autofocus: false,
    );
  }

  /// Section Widget
  Widget _buildFinish() {
    return CustomElevatedButton(
      width: 380.h,
      text: "lbl_finish".tr,
      alignment: Alignment.bottomCenter,
      onPressed: () => Get.toNamed(AppRoutes.startScreen),
    );
  }

  /// Common widget
  Widget _buildTwo({
    required String type,
    required String value,
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
              type,
              style: theme.textTheme.bodyLarge!.copyWith(
                color: appTheme.black900,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              right: 26.h,
              bottom: 3.v,
            ),
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              style: CustomTextStyles.bodyLargeExtraLight.copyWith(
                color: appTheme.black900,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThree({
    required String type,
    required String value,
  }) {
    return Container(
      padding: EdgeInsets.fromLTRB(14.h, 14.v, 14.h, 13.v),
      decoration: AppDecoration.outlineSecondaryContainer,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 3.v),
            child: Text(
              type,
              style: theme.textTheme.bodyLarge!.copyWith(
                color: appTheme.black900,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: 3.v,
            ),
            child: Text(
              value,
              maxLines: 3,
              overflow: TextOverflow.visible,
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
