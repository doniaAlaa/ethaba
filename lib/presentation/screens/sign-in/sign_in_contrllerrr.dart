import 'dart:async';
import 'dart:developer';

import 'package:ethabah/core/constants/app_routes.dart';
import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/data/firebase/firebase_auth_service.dart';
import 'package:ethabah/data/remote/auth_provider.dart' as _auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final phoneFocusNode = FocusNode();

  final emailFocusNode = FocusNode();
  final RxString emailError = "".obs;
  final AuthFirebaseServices _authService = AuthFirebaseServices();
  final passwordController = TextEditingController();
  final passwordFocusNode = FocusNode();
  final RxString passwordError = "".obs;
  final RxString phoneError = "".obs;

  final RxBool isLoading = false.obs;
 //////////OTP
  final TextEditingController otpController = TextEditingController();
  final FocusNode otpFocusNode = FocusNode();
  final RxString otpError = "".obs;
  RxBool isOTPsend = false.obs;
  RxBool isOTPsendLoading = false.obs;
  Timer? _otpTimer;
  RxInt _otpTimerSeconds = 0.obs;
  String? verificationIdRecieved;


  bool validatePhone() {
    if (phoneController.text.isEmpty) {
      phoneError.value = StringConstants.thisFieldIsRequired;
      return false;
    }
    phoneError.value = "";
    return true;
  }

  bool validateEmail() {
    if (emailController.text.isEmpty) {
      emailError.value = StringConstants.thisFieldIsRequired;
      return false;
    }
    if (!GetUtils.isEmail(emailController.text)) {
      emailError.value = StringConstants.invalidEmail;
      return false;
    }
    emailError.value = "";
    return true;
  }

  bool validatePassword() {
    if (passwordController.text.isEmpty) {
      passwordError.value = StringConstants.thisFieldIsRequired;
      return false;
    }
    passwordError.value = "";
    return true;
  }

  void onEmailSubmitted() {
    emailFocusNode.unfocus();
    passwordFocusNode.requestFocus();
  }

  void onPasswordSubmitted() {
    passwordFocusNode.unfocus();
  }


  void _startOTPTimer() {
    _otpTimerSeconds.value = 60;
    _otpTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_otpTimerSeconds.value > 0) {
        _otpTimerSeconds.value--;
      } else {
        timer.cancel();
      }
    });
  }

  // void resetTimer() {
  //   _otpTimer?.cancel();
  //   startTimer();
  // }
  //
  // @override
  // void onClose() {
  //   _otpTimer?.cancel();
  //   for (var controller in otpControllers) {
  //     controller.dispose();
  //   }
  //   for (var node in focusNodes) {
  //     node.dispose();
  //   }
  //   super.onClose();
  // }
  // Future<void> signIn() async {
  //   if (validateEmail() && validatePassword()) {
  //     isLoading.value = true;
  //     try {
  //       Map<String, dynamic> result = await AuthProvider.login(
  //         emailController.text,
  //         passwordController.text,
  //       );
  //       if (result['success']) {
  //         if (result['role'] == 2) {
  //           Get.offAllNamed(RoutesConstants.dashboard);
  //         } else if (result['role'] == 0) {
  //           Get.offAllNamed(RoutesConstants.investorDashboard);
  //         } else {
  //           // Get.snackbar(
  //           //   snackPosition: SnackPosition.TOP,
  //           //   margin: const EdgeInsets.all(10),
  //           //   StringConstants.error,
  //           //   StringConstants.somethingWentWrong,
  //           //   backgroundColor: Colors.red,
  //           //   colorText: Colors.white,
  //           // );
  //         }
  //       } else {
  //         Get.snackbar(
  //           snackPosition: SnackPosition.TOP,
  //           margin: const EdgeInsets.all(10),
  //           StringConstants.error,
  //           StringConstants.invalidCredentials,
  //           backgroundColor: Colors.red,
  //           colorText: Colors.white,
  //         );
  //       }
  //     } catch (e) {
  //       Get.snackbar(
  //         StringConstants.error,
  //         e.toString(),
  //         backgroundColor: Colors.red,
  //         colorText: Colors.white,
  //       );
  //     } finally {
  //       isLoading.value = false;
  //     }
  //   }
  // }

  Future<void> getOtpCode() async {

      if (validatePhone()) {
        isOTPsendLoading.value = true;
        try {
          Map<String, dynamic> result = await _auth.AuthProvider.loginWithPhone(
            phoneController.text,
          );
          if(result['message'] == 'User found'){
              verifyOtp();
          }else{
            Get.snackbar(
              StringConstants.error,
              result['message'],
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          }

        } catch (e) {
          Get.snackbar(
            StringConstants.error,
            // e.toString(),
            StringConstants.somethingWentWrong,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          isOTPsendLoading.value = false;

        } finally {
          isOTPsendLoading.value = false;
        }
      }


  }

  void verifyOtp() async {
 //   isLoading.value = true;

    try {
      await _authService.signInWithCredential(
        verificationId: verificationIdRecieved??'',
        // smsCode: otpController.text,
        smsCode: '123456'
      ).then((val){
        Get.snackbar(
          StringConstants.error,
          // e.toString(),
          'waiting for otp code',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      });
    //  isLoading.value = false;
      isOTPsendLoading.value = false;

    } catch (error) {
      log('Failed with error code: ${error.toString()}');
    //  isLoading.value = false;
      Get.snackbar(
        'Error'.tr,
        'Invalid OTP'.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      isOTPsendLoading.value = false;

    }
  }
    getUserToken() async{
      try {
        Map<String, dynamic> result = await _auth.AuthProvider.loginWithPhone(
          phoneController.text,
        );
          isLoading.value = false;

      } catch (error) {
        log('Failed with error code: ${error.toString()}');
        //  isLoading.value = false;
        Get.snackbar(
          'Error'.tr,
          'Invalid OTP'.tr,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        isLoading.value = false;

      }
    }


// void resetTimer() {
//   _otpTimer?.cancel();
//   startTimer();
// }
//
// @override
// void onClose() {
//   _otpTimer?.cancel();
//   for (var controller in otpControllers) {
//     controller.dispose();
//   }
//   for (var node in focusNodes) {
//     node.dispose();
//   }
//   super.onClose();
// }
// Future<void> signIn() async {
//   if (validateEmail() && validatePassword()) {
//     isLoading.value = true;
//     try {
//       Map<String, dynamic> result = await AuthProvider.login(
//         emailController.text,
//         passwordController.text,
//       );
//       if (result['success']) {
//         if (result['role'] == 2) {
//           Get.offAllNamed(RoutesConstants.dashboard);
//         } else if (result['role'] == 0) {
//           Get.offAllNamed(RoutesConstants.investorDashboard);
//         } else {
//           // Get.snackbar(
//           //   snackPosition: SnackPosition.TOP,
//           //   margin: const EdgeInsets.all(10),
//           //   StringConstants.error,
//           //   StringConstants.somethingWentWrong,
//           //   backgroundColor: Colors.red,
//           //   colorText: Colors.white,
//           // );
//         }
//       } else {
//         Get.snackbar(
//           snackPosition: SnackPosition.TOP,
//           margin: const EdgeInsets.all(10),
//           StringConstants.error,
//           StringConstants.invalidCredentials,
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//         );
//       }
//     } catch (e) {
//       Get.snackbar(
//         StringConstants.error,
//         e.toString(),
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }


}






