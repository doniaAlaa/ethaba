// import 'package:ethabah/core/constants/app_icons.dart';
// import 'package:ethabah/core/constants/app_routes.dart';
// import 'package:ethabah/core/constants/app_spacing.dart';
// import 'package:ethabah/core/constants/app_strings.dart';
// import 'package:ethabah/core/constants/app_theme.dart';
// import 'package:ethabah/presentation/components/custom_appbar.dart';
// import 'package:ethabah/presentation/components/custom_complete_inputField.dart';
// import 'package:ethabah/presentation/components/custom_rounded_button.dart';
// import 'package:ethabah/presentation/components/custom_textfield.dart';
// import 'package:ethabah/presentation/screens/sign-in/sign_in_contrller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
//
// class SignInScreen extends StatelessWidget {
//   const SignInScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(SignInController());
//     return Scaffold(
//       backgroundColor: kBackgroundColor,
//
//       body: Stack(
//         children: [
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             child: Container(
//               height: 0.6.sh,
//               // color: kPrimaryColor,
//               decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       Color(0xFF1D3E37),
//                       Color(0xFF178B7B),
//                       Color(0xFF178B7B),
//
//                       // kBackgroundColor,
//
//
//                     ],
//                     begin: Alignment.centerRight,
//                     end: Alignment.bottomLeft,
//                   )
//               ),
//               child: Column(
//                 children: [
//                   SizedBox(height: 20.h,),
//
//                   CustomAppBar(title: StringConstants.signIn,titleColor: kWhiteColor,iconColor: kWhiteColor,),
//                   SizedBox(height: 50.h,),
//                   Center(
//                     child: Image.asset(
//                       kSplashLogo,
//                       height: 150.h,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             left: 0,
//             right: 0,
//             bottom: 0,
//             child: Container(
//               height: 0.5.sh,
//               padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(30.r),
//                   topRight: Radius.circular(30.r),
//                 ),
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   CustomCompleteInputfield(
//                     textfiledTitle: Text(
//                       StringConstants.emailAddress,
//                       style: kTextFieldTitleStyle,
//                     ),
//                     textField: CustomTextField(
//                       fillColor: kPrimaryColor.withOpacity(0.16),
//                       // hintStyle: TextStyle(color: kWhiteColor),
//                       keyboardType: TextInputType.emailAddress,
//                       controller: controller.emailController,
//                       focusNode: controller.emailFocusNode,
//                       onSubmitted: (value) => controller.onEmailSubmitted(),
//                       onChanged: (value) => controller.validateEmail(),
//                       hintText: StringConstants.enterEmailAddress,
//                     ),
//                     errorText: controller.emailError,
//                   ),
//                   CustomCompleteInputfield(
//                     textfiledTitle: Text(
//                       StringConstants.password,
//                       style: kTextFieldTitleStyle,
//                     ),
//                     textField: CustomTextField(
//                       fillColor: kPrimaryColor.withOpacity(0.16),
//                       obscureText: true,
//                       controller: controller.passwordController,
//                       focusNode: controller.passwordFocusNode,
//                       onSubmitted: (value) => controller.onPasswordSubmitted(),
//                       onChanged: (value) => controller.validatePassword(),
//                       hintText: StringConstants.enterPassword,
//                     ),
//                     errorText: controller.passwordError,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       TextButton(
//                         onPressed: () {},
//                         child: Text(
//                           StringConstants.forgotPassword,
//                           style: kTextFieldTitleStyle.copyWith(
//                             color: kPrimaryColor,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Spacer(),
//                   Obx(() {
//                     return CustomRoundedButton(
//                       loading: controller.isLoading.value,
//                       text: StringConstants.signIn,
//                       onPressed: () {
//                         controller.signIn();
//                       },
//                       textColor: kWhiteColor,
//                       backgroundColor: kPrimaryColor,
//                     );
//                   }),
//                   mediumHeight(),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
