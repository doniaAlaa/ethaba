import 'dart:io';

import 'package:ethabah/core/constants/app_spacing.dart';
import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/core/constants/app_theme.dart';
import 'package:ethabah/presentation/components/custom_appbar.dart';
import 'package:ethabah/presentation/components/custom_rounded_button.dart';
import 'package:ethabah/presentation/screens/investor_flow/investor_auth/investor_registration/inverstor_reg_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePicScreen extends StatefulWidget {
  final InvestorRegistrationController controller;

  const ProfilePicScreen({super.key,required this.controller});

  @override
  State<ProfilePicScreen> createState() => _ProfilePicScreenState();
}

class _ProfilePicScreenState extends State<ProfilePicScreen> {

  XFile? img;
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

            const CustomAppBar(title: 'إضافة صورة شخصية',),
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
                      'يمكنك رفع صورتك الشخصية قبل إرسال بياناتك أو رفعها لاحقا',
                      style: kTextFieldTitleStyle.copyWith(fontWeight: FontWeight.w500),
                    ),
                    extraLargeHeight(),
                    extraLargeHeight(),

// Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     UploadButton(
                    //       label: StringConstants.upload,
                    //       onTap: () =>
                    //           controller.pickFiles(controller.passportFiles),
                    //     ),
                    //
                    //     // Obx(() {
                    //     //   return Flexible(
                    //     //     child: Column(
                    //     //       crossAxisAlignment: CrossAxisAlignment.start,
                    //     //       children: controller.passportFiles
                    //     //           .map((file) => Text(
                    //     //                 basename(file.path),
                    //     //                 style: kTextFieldTitleStyle.copyWith(
                    //     //                     color: kPrimaryColor,
                    //     //                     fontSize: 12.sp),
                    //     //               ))
                    //     //           .toList(),
                    //     //     ),
                    //     //   );
                    //     // }),
                    //   ],
                    // ),

                    Center(
                      child: InkWell(
                        onTap: () async{
                          final ImagePicker picker = ImagePicker();
                           img = await picker.pickImage(
                            source: ImageSource.gallery, // alternatively, use ImageSource.gallery
                            maxWidth: 400,
                          );
                           setState(() {

                           });
                        },
                        child: Stack(
                          // alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              height: 200,width: 200,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: kPrimaryColor,width: 2),
                                color:kPrimaryColor.withOpacity(0.16),
                              ),
                              child:img != null ?ClipRRect(
                                  borderRadius: BorderRadius.circular(100000),
                                  child: Image.file(File(img!.path),fit: BoxFit.cover,)):
                              Icon(Icons.account_circle_sharp,color: kPrimaryColor,size: 80,)
                              //Image.asset('assets/icons/primary_person.png',scale: 1.5,),
                              // Padding(
                              //   padding: const EdgeInsets.all(30.0),
                              //   child: SvgPicture.asset('assets/icons/person.svg',fit: BoxFit.contain,),
                              // ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:140.0),
                              child: Container(
                                height: 35,width: 35,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: kPrimaryColor,width: 2),
                                  color:kPrimaryColor,
                                ),
                                child: Icon(Icons.add,color: kWhiteColor,),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    SizedBox(height: 40.h),
                    Obx(() {
                      return CustomRoundedButton(
                        backgroundColor: kPrimaryColor,
                        textColor: kWhiteColor,
                        loading: widget.controller.isLoading.value,
                        text: StringConstants.submit,
                        onPressed: () => widget.controller.registerInvestor(),
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

