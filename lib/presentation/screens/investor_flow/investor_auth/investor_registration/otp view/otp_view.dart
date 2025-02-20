import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/core/constants/app_theme.dart';
import 'package:ethabah/presentation/components/custom_rounded_button.dart';
import 'package:ethabah/presentation/screens/investor_flow/investor_auth/investor_registration/inverstor_reg_controller.dart';
import 'package:ethabah/presentation/screens/investor_flow/investor_auth/investor_registration/otp%20view/otp_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OtpView extends StatelessWidget {
  final String verificationId;
  final String phoneNumber;
  final InvestorRegistrationController controller;

  const OtpView({
    Key? key,
    required this.verificationId,
    required this.phoneNumber,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OtpController otpController = Get.put(OtpController());
    otpController.verificationId = verificationId;
    otpController.phoneNumber = phoneNumber;

    return Scaffold(
      body: Container(
        height: 1.sh,
        width: 1.sw,
        decoration: const BoxDecoration(
          color: kBackgroundColor,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60.h),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 24.sp,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                StringConstants.EnterVerificationCode,
              ),
              SizedBox(height: 10.h),
              Text(
                "${StringConstants.weHaveSentYouVerificationCodeOnYourPhoneNumber} + $phoneNumber",
              ),
              SizedBox(height: 40.h),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (index) {
                    return SizedBox(
                      width: 45.w, // Adjust width as needed for a better fit
                      child: TextField(
                        controller: otpController.otpControllers[index],
                        focusNode: otpController.focusNodes[index],
                        maxLength: 1,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        // style: GoogleFonts.notoKufiArabic(
                        //   fontSize: 22.sp,
                        //   fontWeight: FontWeight.w600,
                        // ),
                        onChanged: (value) =>
                            otpController.onOtpInput(value, index),
                        decoration: InputDecoration(
                          counterText: '',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          hintText: "${index + 1}",
                          // hintStyle: GoogleFonts.notoKufiArabic(
                          //   fontSize: 22.sp,
                          //   fontWeight: FontWeight.w600,
                          //   color: Colors.grey,
                          // ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(height: 20.h),
              Center(
                child: Obx(() {
                  return GestureDetector(
                    onTap: otpController.isResendActive.value
                        ? otpController.resendCode
                        : null,
                    child: Text(
                      otpController.isResendActive.value
                          ? StringConstants.resendCode
                          : '${StringConstants.resendCodeIn} 00:${otpController.timerSeconds.value.toString().padLeft(2, '0')}',
                      // style: GoogleFonts.notoKufiArabic(
                      //   fontSize: 14.sp,
                      //   fontWeight: FontWeight.w400,
                      //   color: otpController.isResendActive.value
                      //       ? primaryColor
                      //       : Colors.black54,
                      //   decoration: otpController.isResendActive.value
                      //       ? TextDecoration.underline
                      //       : TextDecoration.none,
                      //   decorationColor: primaryColor,
                      // ),
                    ),
                  );
                }),
              ),
              const Spacer(),
              Obx(() {
                return CustomRoundedButton(
                  text: "Continue",
                  onPressed: () {
                    // Handle OTP verification
                    otpController.verifyOtp();
                  },
                  loading: otpController.isLoading.value,
                  backgroundColor: otpController.isButtonEnabled.value
                      ? kPrimaryColor
                      : kPrimaryColor.withOpacity(0.5),
                );
              }),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
