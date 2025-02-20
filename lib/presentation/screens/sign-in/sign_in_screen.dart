import 'package:ethabah/core/constants/app_icons.dart';
import 'package:ethabah/core/constants/app_routes.dart';
import 'package:ethabah/core/constants/app_spacing.dart';
import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/core/constants/app_theme.dart';
import 'package:ethabah/core/utils/mobileNo_formatter.dart';
import 'package:ethabah/presentation/components/custom_appbar.dart';
import 'package:ethabah/presentation/components/custom_complete_inputField.dart';
import 'package:ethabah/presentation/components/custom_rounded_button.dart';
import 'package:ethabah/presentation/components/custom_textfield.dart';
import 'package:ethabah/presentation/screens/sign-in/sign_in_contrller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignInScreen extends StatelessWidget {
   SignInScreen({super.key});

  Widget? prefix;
  @override
  Widget build(BuildContext context) {

    final controller = Get.put(SignInController());
    return Scaffold(
      backgroundColor: kBackgroundColor,

      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 0.6.sh,
              // color: kPrimaryColor,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF1D3E37),
                      Color(0xFF178B7B),
                      Color(0xFF178B7B),

                      // kBackgroundColor,


                    ],
                    begin: Alignment.centerRight,
                    end: Alignment.bottomLeft,
                  )
              ),
              child: Column(
                children: [
                  SizedBox(height: 20.h,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CustomAppBar(title: StringConstants.signIn,titleColor: kWhiteColor,iconColor: kWhiteColor,),
                  ),

                  SizedBox(height: 50.h,),
                  Center(
                    child: Image.asset(
                      kSplashLogo,
                      height: 150.h,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 0.51.sh,
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // CustomCompleteInputfield(
                  //   textfiledTitle: Text(
                  //     StringConstants.emailAddress,
                  //     style: kTextFieldTitleStyle,
                  //   ),
                  //   textField: CustomTextField(
                  //     fillColor: kPrimaryColor.withOpacity(0.16),
                  //     // hintStyle: TextStyle(color: kWhiteColor),
                  //     keyboardType: TextInputType.emailAddress,
                  //     controller: controller.emailController,
                  //     focusNode: controller.emailFocusNode,
                  //     onSubmitted: (value) => controller.onEmailSubmitted(),
                  //     onChanged: (value) => controller.validateEmail(),
                  //     hintText: StringConstants.enterEmailAddress,
                  //   ),
                  //   errorText: controller.emailError,
                  // ),
                  // CustomCompleteInputfield(
                  //   textfiledTitle: Text(
                  //     StringConstants.password,
                  //     style: kTextFieldTitleStyle,
                  //   ),
                  //   textField: CustomTextField(
                  //     fillColor: kPrimaryColor.withOpacity(0.16),
                  //     obscureText: true,
                  //     controller: controller.passwordController,
                  //     focusNode: controller.passwordFocusNode,
                  //     onSubmitted: (value) => controller.onPasswordSubmitted(),
                  //     onChanged: (value) => controller.validatePassword(),
                  //     hintText: StringConstants.enterPassword,
                  //   ),
                  //   errorText: controller.passwordError,
                  // ),

                  CustomCompleteInputfield(
                      textfiledTitle: Text(
                        StringConstants.phoneNumber,
                        // style: kTextFieldTitleStyle,
                        style: kTextFieldTitleStyle.copyWith(fontWeight: FontWeight.w600,fontSize: 14),

                      ),
                      textField: Directionality(
                        textDirection: TextDirection.ltr,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 0.065.sh,
                              width: 0.2.sw,
                              decoration: BoxDecoration(
                                color: kPrimaryColor.withOpacity(0.16),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "+966",
                                  style: kTextFieldTitleStyle,
                                ),
                              ),
                            ),
                            smallWidth(),

                            StatefulBuilder(
                              builder: (context,setState) {

                                print('ooooooooo');
                                return Expanded(
                                  child: CustomTextField(
                                    fillColor: kPrimaryColor.withOpacity(0.16),

                                    // inputFormatters: [
                                    //   MobileNumberFormatter(),
                                    // ],
                                    keyboardType: TextInputType.phone,
                                     controller: controller.phoneController,

                                    focusNode: controller.phoneFocusNode,
                                      // prefix: prefix,
                                      // maxLength: 8,
                                      maxLength: 9,
                                    // onSubmitted: (value) => controller.onPhoneSubmitted,
                                    onChanged: (value){
                                      // if(value.length == 1){
                                      //
                                      //
                                      //   setState(() {
                                      //     prefix = Padding(
                                      //       padding: const EdgeInsets.symmetric(horizontal: 1.0),
                                      //       child: Text('5'),
                                      //     );
                                      //
                                      //   });
                                      // }else if(value.length == 0){
                                      //
                                      //   setState(() {
                                      //     prefix = null;
                                      //   });
                                      // }
                                      controller.validatePhone();
                                    } ,
                                    hintText: StringConstants.enterPhoneNumber,
                                  ),
                                );
                              }
                            ),
                          ],
                        ),
                      ),
                      errorText: controller.phoneError),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Obx(() => CustomRoundedButton(
                        backgroundColor: kPrimaryColor,
                        height: 0.065.sh,
                        width: 0.5.sw,

                        textColor: kWhiteColor,
                        shadow: true,
                        loading: controller.isOTPsendLoading.value,
                        text: StringConstants.sendOTP,
                        onPressed: () {
                          controller.getOtpCode();
                          // controller.signIn();
                        })),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  //OTP TextField (6 Digits max - only numbers)
                  CustomCompleteInputfield(
                    textfiledTitle: Text(
                      StringConstants.enterOTP,
                      // style: kTextFieldTitleStyle,
                      style: kTextFieldTitleStyle.copyWith(fontWeight: FontWeight.w600,fontSize: 14),

                    ),
                    textField: CustomTextField(
                      fillColor: kPrimaryColor.withOpacity(0.16),

                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        LengthLimitingTextInputFormatter(6),
                      ],
                      keyboardType: TextInputType.number,
                      controller: controller.otpController,
                      focusNode: controller.otpFocusNode,
                      hintText: StringConstants.enterOTP,
                    ),
                    errorText: controller.otpError,
                  ),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     TextButton(
                  //       onPressed: () {},
                  //       child: Text(
                  //         StringConstants.forgotPassword,
                  //         style: kTextFieldTitleStyle.copyWith(
                  //           color: kPrimaryColor,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Spacer(),
                  Obx(() {
                    return CustomRoundedButton(
                      loading: controller.isLoading.value,
                      text: StringConstants.signIn,
                      onPressed: () {
                        controller.login();
                      },
                      textColor: kWhiteColor,
                      backgroundColor:kPrimaryColor,
                      //Color(0xB6C2CBCC),
                    );
                  }),
                  mediumHeight(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
