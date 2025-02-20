import 'package:ethabah/core/constants/app_spacing.dart';
import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/core/constants/app_theme.dart';
import 'package:ethabah/presentation/components/custom_appbar.dart';
import 'package:ethabah/presentation/components/custom_rounded_button.dart';
import 'package:ethabah/presentation/components/upload_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:ethabah/presentation/screens/investor_flow/investor_auth/investor_registration/inverstor_reg_controller.dart';

class FileVerificationScreen extends StatelessWidget {
  final InvestorRegistrationController controller;
  const FileVerificationScreen({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 10.w),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AppBar(
            //   title: const Text(
            //     StringConstants.fileVerification,
            //     style: TextStyle(color: kNeonColor),
            //   ),
            //   leading: IconButton(
            //       onPressed: () {
            //         Get.back();
            //       },
            //       icon: const Icon(
            //         Icons.arrow_back_ios,
            //         color: kNeonColor,
            //       )),
            //   backgroundColor: kPrimaryColor,
            // ),
            mediumHeight(),
        
            const CustomAppBar(title: StringConstants.fileVerification,),
            // mediumHeight(),
            extraLargeHeight(),
            extraLargeHeight(),
            SizedBox(height: 20.h),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      StringConstants.passportOrIdOfTheOwner,
                      style: kTextFieldTitleStyle,
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        UploadButton(
                          label: StringConstants.upload,
                          onTap: () =>
                              controller.pickFiles(controller.passportFiles),
                        ),

                        // Obx(() {
                        //   return Flexible(
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: controller.passportFiles
                        //           .map((file) => Text(
                        //                 basename(file.path),
                        //                 style: kTextFieldTitleStyle.copyWith(
                        //                     color: kPrimaryColor,
                        //                     fontSize: 12.sp),
                        //               ))
                        //           .toList(),
                        //     ),
                        //   );
                        // }),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top:8.0),
                      child: Obx(() {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: controller.passportFiles
                              .map((file) => Text(
                            basename(file.path),
                            style: kTextFieldTitleStyle.copyWith(
                                color: kPrimaryColor,
                                fontSize: 12.sp),
                          ))
                              .toList(),
                        );
                      }),
                    ),

                    SizedBox(height: 20.h),

                    SizedBox(height: 40.h),
                    Obx(() {
                      return CustomRoundedButton(
                        backgroundColor: kPrimaryColor,
                        textColor: kWhiteColor,
                        loading: controller.isLoading.value,
                        text: StringConstants.submit,
                        onPressed: () => controller.registerInvestor(),
                      );
                    }),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
