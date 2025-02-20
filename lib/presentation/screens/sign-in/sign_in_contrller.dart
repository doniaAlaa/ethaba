import 'dart:async';
import 'dart:developer';

import 'package:ethabah/core/constants/app_routes.dart';
import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/data/firebase/firebase_auth_service.dart';
import 'package:ethabah/data/remote/auth_provider.dart' as _auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ethabah/models/User_model.dart' as user;

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
    }else if(phoneController.text.length < 9){
      phoneError.value = 'يجب ألا يقل رقم الهاتف عن ٩ أرقام';
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
    print('${phoneController.text}');
    if (validatePhone()) {
      isOTPsendLoading.value = true;
      try {
        Map<String, dynamic> result = await _auth.AuthProvider.loginWithPhone(
          '${phoneController.text}',
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
          isOTPsendLoading.value = false;

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

      }
      // finally {
      //   isOTPsendLoading.value = false;
      // }
    }


  }

  void verifyOtp() async {
    print('+966${phoneController.text}');
    try {

      await _authService.resendCode(
        // phoneNumber: '+201061366831',
        // phoneNumber: '+9665${phoneController.text}',
        phoneNumber: '+966${phoneController.text}',
        codeSent: (String verificationId, int? resendToken) {
          this.verificationIdRecieved = verificationId;
          log('Code sent sent');
          Get.snackbar(
            snackPosition: SnackPosition.TOP,
            margin: const EdgeInsets.all(10),
            StringConstants.otpSentSuccessfully,
            StringConstants.weHaveSentYouVerificationCodeOnYourPhoneNumber,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          isOTPsendLoading.value = false;

        },
        codeAutoRetrievalTimeout: (String verificationId) {
          this.verificationIdRecieved = verificationId;
          log('Auto retrieval timeout');
          isOTPsendLoading.value = false;

        },
      );

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
  login() async{
    print('${phoneController.text}');
    if(verificationIdRecieved == null){
      Get.snackbar(
        StringConstants.error,
        StringConstants.pleaseVerifyYourPhoneNumberFirst,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(10),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }else{
      isLoading.value = true;
      await _authService.signInWithCredential(
          verificationId: verificationIdRecieved??'',
          // smsCode: otpController.text,
          smsCode: otpController.text
      ).then((val) async{

        try {
          Map<String, dynamic> result = await _auth.AuthProvider.login(
            // phoneController.text.replaceAll(' ', ''),
            '${phoneController.text}',
          );
          if (result['success']) {
            user.User userData = result['user'];
            if(userData.status == '0'){
              Get.offNamed(RoutesConstants.underReview);
            }else{

              if (result['role'] == 2) {
                Get.offAllNamed(RoutesConstants.dashboard);
              } else if (result['role'] == 0) {
                Get.offAllNamed(RoutesConstants.investorDashboard);
              } else {
                Get.snackbar(
                  snackPosition: SnackPosition.TOP,
                  margin: const EdgeInsets.all(10),
                  StringConstants.error,
                  StringConstants.somethingWentWrong,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
              }
             }
              isLoading.value = false;
            }else{
            isLoading.value = false;

          }

        } catch (error) {
          log('666666 with error code: ${error.toString()}');
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
      }).catchError((onError){
        Get.snackbar(
          'Error'.tr,
          'كود التحقق غير صالح أو منتهى الصلاحية ، يرجى إعادة المحاولة',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        isLoading.value = false;
      });

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






