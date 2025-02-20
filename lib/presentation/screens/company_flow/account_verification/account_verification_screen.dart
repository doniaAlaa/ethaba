import 'package:ethabah/core/constants/app_spacing.dart';
import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/core/constants/app_theme.dart';
import 'package:ethabah/presentation/components/check_box.dart';
import 'package:ethabah/presentation/components/custom_appbar.dart';
import 'package:ethabah/presentation/components/custom_rounded_button.dart';
import 'package:ethabah/presentation/screens/company_flow/account_verification/account_verification_controller.dart';
import 'package:ethabah/presentation/components/upload_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

class AccountVerificationScreen extends StatelessWidget {
  final String fullCompanyName;
  final String companyRegistration;
  final String phoneNumber;
  final String address;
  final String email;
  final String password;
  const AccountVerificationScreen({
    super.key,
    required this.fullCompanyName,
    required this.companyRegistration,
    required this.phoneNumber,
    required this.address,
    required this.password,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AccountVerificationController());
    controller.fullCompanyNameController.text = fullCompanyName;
    controller.companyRegistrationController.text = companyRegistration;
    controller.phoneNumberController.text = phoneNumber;
    controller.addressController.text = address;
    controller.emailController.text = email;
    controller.passwordController.text = password;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            mediumHeight(),

            const CustomAppBar(title: StringConstants.accountVerification,),
            // mediumHeight(),
            extraLargeHeight(),
            extraLargeHeight(),

            Text(
              StringConstants.companyRegistrationCertificate,
              style: kTextFieldTitleStyle,
            ),
            smallHeight(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() {
                  return Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: controller.companyRegistrationCertificates
                          .map((file) => Text(
                                basename(file.path),
                                style: kTextFieldTitleStyle.copyWith(
                                    color: kPrimaryColor, fontSize: 10.sp,),
                              ))
                          .toList(),
                    ),
                  );
                }),
                UploadButton(
                  label: StringConstants.upload,
                  onTap: () => controller
                      .pickFiles(controller.companyRegistrationCertificates),
                ),
              ],
            ),
            // mediumHeight(),
            // Text(
            //   StringConstants.commericalRegistrationCertificate,
            //   style: kTextFieldTitleStyle,
            // ),
            // smallHeight(),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Obx(() {
            //       return Flexible(
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: controller.commercialRegistrationCertificates
            //               .map((file) => Text(
            //                     basename(file.path),
            //                     style: kTextFieldTitleStyle.copyWith(
            //                         color: kPrimaryColor, fontSize: 10.sp),
            //                   ))
            //               .toList(),
            //         ),
            //       );
            //     }),
            //     UploadButton(
            //       label: StringConstants.upload,
            //       onTap: () => controller
            //           .pickFiles(controller.commercialRegistrationCertificates),
            //     ),
            //   ],
            // ),
            largeHeight(),
            Text(
              StringConstants.anyOtherLicense,
              style: kTextFieldTitleStyle,
            ),
            smallHeight(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() {
                  return Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: controller.otherLicenses
                          .map((file) => Text(
                                basename(file.path),
                                style: kTextFieldTitleStyle.copyWith(
                                    color: kPrimaryColor, fontSize: 10.sp),
                              ))
                          .toList(),
                    ),
                  );
                }),
                UploadButton(
                  label: StringConstants.upload,
                  onTap: () => controller.pickFiles(controller.otherLicenses),
                ),
              ],
            ),
            extraLargeHeight(),
            TermsCheckbox(agreeToTerms: controller.agreeToTerms),
            largeHeight(),
            Obx(() {
              return CustomRoundedButton(
                backgroundColor: kPrimaryColor,
                textColor: kWhiteColor,
                loading: controller.isLoading.value,
                text: StringConstants.submit,
                onPressed: () => controller.onSubmit(),
              );
            }),
          ],
        ),
      ),
    );
  }
}
