import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:ethabah/core/constants/app_routes.dart';
import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/core/constants/app_theme.dart';
import 'package:ethabah/core/constants/app_urls.dart';
import 'package:ethabah/data/firebase/firebase_auth_service.dart';
import 'package:ethabah/data/remote/auth_provider.dart' as authProvider;
import 'package:ethabah/data/shared/user_pref.dart';
import 'package:ethabah/models/admin_bank_data_model.dart';
import 'package:ethabah/models/countries_model.dart';
import 'package:ethabah/presentation/screens/company_flow/company_registration/company_registration_controller.dart';
import 'package:ethabah/presentation/screens/investor_flow/investor_auth/investor_registration/file_verification/file_verification_screen.dart';
import 'package:ethabah/presentation/screens/investor_flow/investor_auth/investor_registration/inverstor_reg_controller.dart';
import 'package:ethabah/presentation/screens/investor_flow/investor_auth/investor_registration/otp%20view/otp_view.dart';
import 'package:ethabah/presentation/screens/investor_flow/profile_pic/profile_pic_screen.dart';
import 'package:ethabah/presentation/screens/wallet/add_bank_account_screen.dart';
import 'package:ethabah/presentation/screens/wallet/my_bank_account_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class VerifyCodeController extends GetxController {
  final AuthFirebaseServices _authService = AuthFirebaseServices();
  final phoneController = TextEditingController();
  final phoneFocusNode = FocusNode();
  final RxString phoneError = "".obs;

  RxBool isOTPsend = false.obs;
  RxBool isOTPsendLoading = false.obs;
  RxBool isVerifyLoading = false.obs;

  final TextEditingController otpController = TextEditingController();
  final FocusNode otpFocusNode = FocusNode();
  final RxString otpError = "".obs;

  Timer? _otpTimer;
  RxInt _otpTimerSeconds = 0.obs;
  String? verificationIdRecieved;

  void onPhoneSubmitted() {
    phoneFocusNode.unfocus();
    phoneFocusNode.requestFocus();
  }

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

  RxBool isOtpVerifyLoading = false.obs;



////////////
  getVerifyCode() async {
    if (validatePhone()){
      isOTPsendLoading.value = true;
    if (_otpTimer != null && _otpTimer!.isActive) {
      Get.snackbar(
        StringConstants.error,
        '${StringConstants.pleaseWaitFor} ${_otpTimerSeconds
            .value} ${StringConstants.secondsBeforeRequestingNewOtp}.',
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(10),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      isOTPsendLoading.value = false;

      return;
    }

    try {
      print('${phoneController.text}');

      Map<String, dynamic> result = await authProvider.AuthProvider
          .loginWithPhone(
        '${phoneController.text}',
      );
      if (result['message'] == 'User found') {
        Get.snackbar(
          StringConstants.error,
          'هذا الرقم مسجل مسبقا',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        isOTPsendLoading.value = false;
      } else {
        _authService.registerPhoneNumber(
          phoneNumber: '+966${phoneController.text}',
          //phoneNumber: '+201061366831',

          verificationCompleted: (PhoneAuthCredential credential) async {
            verificationIdRecieved = credential.verificationId;
            isOTPsendLoading.value = false;

            //TODO:AUTO VALIDATE
            // await _authService.signInWithCredential(
            //   verificationId: '',
            //   smsCode: credential.smsCode!,
            // );
            // isOTPsendLoading.value = false;
          },
          verificationFailed: (FirebaseAuthException e) {
            // log("phone no : $phoneNumber");
            verificationIdRecieved = null;
            log('Failed with error code: ${e.code}');
            log('Message: ${e.message}');
            Get.snackbar(
              snackPosition: SnackPosition.TOP,
              margin: const EdgeInsets.all(10),
              StringConstants.error,
              StringConstants.verificationFailed,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
            isOTPsendLoading.value = false;
          },
          codeSent: (String verificationId, int? resendToken) {
            print('333333333333333333');
            isOTPsendLoading.value = false;
            // isOTPsend.value = true;
            verificationIdRecieved = verificationId;
            Get.snackbar(
              snackPosition: SnackPosition.TOP,
              margin: const EdgeInsets.all(10),
              StringConstants.otpSentSuccessfully,
              StringConstants.weHaveSentYouVerificationCodeOnYourPhoneNumber,
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
            _startOTPTimer();
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            verificationIdRecieved = null;
            isOTPsendLoading.value = false;
          },
        );
        // isOTPsendLoading.value = false;
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
   }
  }

  verifyPhone(String otpCode,String type, {bool? isEditing,BankData? bankData,BuildContext? context}) async{
    print('otpCode$otpCode');
    isVerifyLoading.value = true;
    await _authService.signInWithCredential(
        verificationId: verificationIdRecieved??'',
         smsCode:otpCode,
    ).then((onValue){
      isVerifyLoading.value = false;
      Get.snackbar(
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(10),
        StringConstants.success,
        StringConstants.phoneVerifiedSuccessfully,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      if (type == 'investor'){
        InvestorRegistrationController controller = Get.put(InvestorRegistrationController());
        controller.phoneController.text = '${phoneController.text}'.replaceAll(' ', '');
        Get.toNamed(RoutesConstants.investorRegister);
      }else if(type == 'company'){
        CompanyRegistrationController controller = Get.put(CompanyRegistrationController());
        controller.phoneNumberController.text = '${phoneController.text}'.replaceAll(' ', '');
        Get.toNamed(RoutesConstants.companyRegister);
      }else if(type == 'verifyMyBankAccount'){
        print('kllllllllllll');
        Navigator.push(
          context!,
          MaterialPageRoute(builder: (context) =>  AddBankAccountScreen(editing: isEditing??false,data: bankData,)),
        );
        // Get.toNamed(RoutesConstants.addBankAccountScreen,arguments: [isEditing,bankData]);
      }

    }).catchError((onError){
      print('onError$onError');
      isVerifyLoading.value = false;
      Get.snackbar(
        StringConstants.error,
        StringConstants.invalidOtp,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      otpCode = '';

    });
  }

  // VERIFY MY BANK ACCOUNT//
  getVerifyCodeForMyBankAccount() async {
    if (validatePhone()){
      isOTPsendLoading.value = true;
      if (_otpTimer != null && _otpTimer!.isActive) {
        Get.snackbar(
          StringConstants.error,
          '${StringConstants.pleaseWaitFor} ${_otpTimerSeconds
              .value} ${StringConstants.secondsBeforeRequestingNewOtp}.',
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.all(10),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        isOTPsendLoading.value = false;

        return;
      }

      try {
        _authService.registerPhoneNumber(
          phoneNumber: '+966${phoneController.text}',
          //phoneNumber: '+201061366831',

          verificationCompleted: (PhoneAuthCredential credential) async {
            verificationIdRecieved = credential.verificationId;
            isOTPsendLoading.value = false;

            //TODO:AUTO VALIDATE
            // await _authService.signInWithCredential(
            //   verificationId: '',
            //   smsCode: credential.smsCode!,
            // );
            // isOTPsendLoading.value = false;
          },
          verificationFailed: (FirebaseAuthException e) {
            // log("phone no : $phoneNumber");
            verificationIdRecieved = null;
            log('Failed with error code: ${e.code}');
            log('Message: ${e.message}');
            Get.snackbar(
              snackPosition: SnackPosition.TOP,
              margin: const EdgeInsets.all(10),
              StringConstants.error,
              StringConstants.verificationFailed,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
            isOTPsendLoading.value = false;
          },
          codeSent: (String verificationId, int? resendToken) {
            print('333333333333333333');
            isOTPsendLoading.value = false;
            // isOTPsend.value = true;
            verificationIdRecieved = verificationId;
            Get.snackbar(
              snackPosition: SnackPosition.TOP,
              margin: const EdgeInsets.all(10),
              StringConstants.otpSentSuccessfully,
              StringConstants.weHaveSentYouVerificationCodeOnYourPhoneNumber,
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
            _startOTPTimer();
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            verificationIdRecieved = null;
            isOTPsendLoading.value = false;
          },
        );
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
    }
  }


}
