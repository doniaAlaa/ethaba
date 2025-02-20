import 'dart:async';
import 'dart:developer';
import 'package:ethabah/data/firebase/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpController extends GetxController {
  final List<TextEditingController> otpControllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());
  final AuthFirebaseServices _authService = AuthFirebaseServices();
  RxBool isButtonEnabled = false.obs;
  RxInt timerSeconds = 60.obs;
  RxBool isResendActive = false.obs;
  Timer? _timer;
  String verificationId = '';
  String phoneNumber = '';
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    timerSeconds.value = 60;
    isResendActive.value = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerSeconds.value > 0) {
        timerSeconds.value--;
      } else {
        timer.cancel();
        isResendActive.value = true;
      }
    });
  }

  void onOtpInput(String value, int index) {
    if (value.isNotEmpty) {
      if (index < 5) {
        focusNodes[index + 1].requestFocus();
      } else {
        focusNodes[index].unfocus();
      }
    } else if (index > 0) {
      focusNodes[index - 1].requestFocus();
    }
    checkOtpComplete();
  }

  void checkOtpComplete() {
    final otp = otpControllers.map((controller) => controller.text).join();
    isButtonEnabled.value = otp.length == 6;
  }

  void resetTimer() {
    _timer?.cancel();
    startTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.onClose();
  }

  void verifyOtp() async {
    isLoading.value = true;
    final otp = otpControllers.map((controller) => controller.text).join();

    try {
      await _authService.signInWithCredential(
        verificationId: verificationId,
        smsCode: otp,
      );
      // await isUserAlreadyRegistered();
      isLoading.value = false;
    } catch (error) {
      log('Failed with error code: ${error.toString()}');
      isLoading.value = false;
      Get.snackbar(
        'Error'.tr,
        'Invalid OTP'.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Future isUserAlreadyRegistered() async {
  //   try {
  //     //remove spaces from the phone number
  //     phoneNumber = phoneNumber.replaceAll(RegExp(r'\s+'), '');
  //     // log(phoneNumber, name: "OTPController.isUserAlreadyRegistered");
  //     final response = await UserServiceProvider.isUserRegistereed(phoneNumber);
  //     // log(response.toString(), name: "OTPController.isUserAlreadyRegistered");
  //     if (response['status'] == true &&
  //         response['message'] == 'Login successful!') {
  //       await UserPreferences().saveUserData(response['data']);
  //       final storeResponse =
  //           await StoreServiceProvider.isStoreRegistered(phoneNumber);
  //       if (storeResponse['status'] == true) {
  //         await StorePreferences().saveStoreDataLogin(storeResponse['data']);
  //       }
  //       Get.offAllNamed(RoutesConstants.dashboardView);
  //     } else if (response['status'] == false &&
  //         response['message'] == 'User not found with this phone number.') {
  //       Get.toNamed(RoutesConstants.setupProfileView, arguments: phoneNumber);
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

  Future<void> resendCode() async {
    //resend Code and start timer
    await _authService.resendCode(
      phoneNumber: phoneNumber,
      codeSent: (String verificationId, int? resendToken) {
        this.verificationId = verificationId;
        log('Code sent');
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        this.verificationId = verificationId;
        log('Auto retrieval timeout');
      },
    );
    resetTimer();
  }
}
