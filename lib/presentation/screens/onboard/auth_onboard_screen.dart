import 'package:ethabah/core/constants/app_icons.dart';
import 'package:ethabah/core/constants/app_routes.dart';
import 'package:ethabah/core/constants/app_spacing.dart';
import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/core/constants/app_theme.dart';
import 'package:ethabah/presentation/components/custom_rounded_button.dart';
import 'package:ethabah/presentation/others/privacy_policy_screen.dart';
import 'package:ethabah/presentation/others/terms_condition_screen.dart';
import 'package:ethabah/presentation/screens/investor_flow/investor_auth/investor_registration/otp%20view/verify_code_controller.dart';
import 'package:ethabah/presentation/screens/investor_flow/investor_auth/investor_registration/otp%20view/verify_code_screen.dart';
import 'package:ethabah/presentation/screens/sign-in/sign_in_contrller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AuthOnboardScreen extends StatelessWidget {
  const AuthOnboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              StringConstants.investWithConfindence,
              style: kHeadingTextStyle,
            ),
            Text(
              StringConstants.growWithCertainty,
              style: kHeadingTextStyle,
            ),
            Image.asset(
              kOnboard,
              height: 0.4.sh,
              width: 1.sw,
              filterQuality: FilterQuality.high,
            ),

            CustomRoundedButton(
                loading: false,
                borderColor: kBlackColor,
                text: StringConstants.signIn,
                onPressed: () {
                  Get.delete<SignInController>(force: true);
                  Get.toNamed(RoutesConstants.signIn);
                }),
            mediumHeight(),
            CustomRoundedButton(
                loading: false,
                backgroundColor: kNeonColor,
                text: StringConstants.createAccountAsACompany,
                onPressed: () {
                   // Get.toNamed(RoutesConstants.companyRegister);
                  Get.delete<VerifyCodeController>(force: true);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  EnterOTP(type: 'company',)),
                  );
                }),
            mediumHeight(),
            CustomRoundedButton(
                loading: false,
                backgroundColor: kPrimaryColor,
                text: StringConstants.createAccountAsAnInvestor,
                onPressed: () {
                  Get.delete<VerifyCodeController>(force: true);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  EnterOTP(type: 'investor')),
                  );
                  // Get.toNamed(RoutesConstants.investorRegister);
                }),

            extraLargeHeight(),
            //help , privacy and term underlined button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(StringConstants.help,
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: kBlackColor,
                        fontFamily: kFontFamily,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline)),
                smallWidth(),
                GestureDetector(
                  onTap: () {
                    Get.to(
                      () => const PrivacyPolicyScreen(),
                    );
                  },
                  child: Text(StringConstants.privacy,
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: kBlackColor,
                          fontFamily: kFontFamily,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline)),
                ),
                smallWidth(),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const TermsConditionScreen());
                  },
                  child: Text(StringConstants.terms,
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: kBlackColor,
                          fontFamily: kFontFamily,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
