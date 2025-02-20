import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:ethabah/core/constants/app_routes.dart';
import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/core/constants/app_theme.dart';
import 'package:ethabah/core/constants/app_urls.dart';
import 'package:ethabah/data/firebase/firebase_auth_service.dart';
import 'package:ethabah/data/shared/user_pref.dart';
import 'package:ethabah/models/countries_model.dart';
import 'package:ethabah/presentation/screens/company_flow/account_verification/account_verification_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CompanyRegistrationController extends GetxController {
  final fullCompanyNameController = TextEditingController();
  final fcnFocusNode = FocusNode();
  final RxString fullCompanyNameError = "".obs;

  final companyRegistrationController = TextEditingController();
  final crFocusNode = FocusNode();
  final RxString companyRegistrationError = "".obs;

  final addressController = TextEditingController();
  final addressFocusNode = FocusNode();

  final RxString addressError = "".obs;

  final RxString countryCode = "+966".obs;
  final phoneNumberController = TextEditingController();
  final phoneNumberFocusNode = FocusNode();
  final RxString phoneNumberError = "".obs;

  final emailController = TextEditingController();
  final emailFocusNode = FocusNode();
  final RxString emailError = "".obs;

  final passwordController = TextEditingController();
  final passwordFocusNode = FocusNode();
  final RxString passwordError = "".obs;

  final suCode = '+966';

  RxBool isOTPsend = false.obs;
  RxBool isOTPsendLoading = false.obs;

  final TextEditingController otpController = TextEditingController();
  final FocusNode otpFocusNode = FocusNode();
  final RxString otpError = "".obs;

  Timer? _otpTimer;
  RxInt _otpTimerSeconds = 0.obs;
  String? verificationIdRecieved;

  final RxInt selectedIndex = (-1).obs;
  final RxString selectedCountry = StringConstants.enterAddress.obs;

  final AuthFirebaseServices _authService = AuthFirebaseServices();

  Future<CountriesModel?> getCountries() async {
    try {
      final String? token = await SharedPref.getToken();
      // var token = "5|lFDEyyoUCcfke9NC94cRZn136BcUlSGnAobuyt721925a3f5";

      final response = await http.get(Uri.parse(GET_COUNTRIES), headers: {
        'Authorization': 'Bearer $token',
      });
      log(response.body);
      if (response.statusCode == 200) {
        // final resData = json.decode(response.body);
        // final data = resData['data'] as List;
        // return data.map((e) => RequestModel.fromJson(e)).toList();
        return  CountriesModel.fromJson(json.decode(response.body));
      }
      if (response.statusCode == 404) {
        return null;
      }
      throw Exception(StringConstants.somethingWentWrong);
    } catch (e) {
      log(e.toString());
      throw Exception(StringConstants.somethingWentWrong);
    }
  }

  next(){
    if (validateFullCompanyName() &&
        validateCompanyRegistration() &&
        validateAddress() &&
        validateOtp() &&
        validatePhoneNumber() &&
        validateEmail() &&
        validatePassword()){

      Get.toNamed(RoutesConstants.accountVerification, arguments: {
        'fullCompanyName': fullCompanyNameController.text,
        'companyRegistration': companyRegistrationController.text,
        'phoneNumber': phoneNumberController.text.replaceAll(' ', ''),
        'address': selectedCountry.value,
        'email': emailController.text,
        'password': passwordController.text,
      });

    }else{
      Get.snackbar(
        StringConstants.error,
        'يرجى إدخال البيانات المطلوبة',
        backgroundColor:kStarColor,
        colorText: Colors.white,
      );
    }
  }


  void registerPhoneNumber() async {
    if (_otpTimer != null && _otpTimer!.isActive) {
      Get.snackbar(
        StringConstants.error,
        '${StringConstants.pleaseWaitFor} ${_otpTimerSeconds.value} ${StringConstants.secondsBeforeRequestingNewOtp}.',
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(10),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    if (validatePhoneNumber()) {
      isOTPsendLoading.value = true;
      final phoneNumber = "$suCode ${phoneNumberController.text}";
      _authService.registerPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _authService.signInWithCredential(
            verificationId: '',
            smsCode: credential.smsCode!,
          );
          isOTPsendLoading.value = false;
          // Get.toNamed(RoutesConstants.dashboardView);
        },
        verificationFailed: (FirebaseAuthException e) {
          log("phone no : $phoneNumber");
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
          isOTPsendLoading.value = false;
          isOTPsend.value = true;
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
          isOTPsendLoading.value = false;
        },
      );
    }
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
  Future<void> verifyOtp(verificationId, otp, BuildContext context) async {
    isOtpVerifyLoading.value = true;
    try {
      await _authService.signInWithCredential(
        verificationId: verificationId,
        smsCode: otp,
      );
      Get.toNamed(RoutesConstants.accountVerification, arguments: {
        'fullCompanyName': fullCompanyNameController.text,
        'companyRegistration': companyRegistrationController.text,
        'phoneNumber': phoneNumberController.text,
        'address': addressController.text,
        'email': emailController.text,
        // 'password': passwordController.text,
      });
      // await registerInvestor();

      isOtpVerifyLoading.value = false;
    } catch (error) {
      log('Failed with error code: ${error.toString()}');
      isOtpVerifyLoading.value = false;
      Get.snackbar(
        StringConstants.error,
        StringConstants.invalidOtp,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isOtpVerifyLoading.value = false;
    }
  }

  bool validateOtp() {
    if (otpController.text.isEmpty) {
      otpError.value = StringConstants.thisFieldIsRequired;

      return false;
    }
    otpError.value = "";
    return true;
  }

  bool validateFullCompanyName() {
    if (fullCompanyNameController.text.isEmpty) {
      fullCompanyNameError.value = StringConstants.thisFieldIsRequired;
      return false;
    }
    fullCompanyNameError.value = "";
    return true;
  }

  bool validateCompanyRegistration() {
    if (companyRegistrationController.text.isEmpty) {
      companyRegistrationError.value = StringConstants.thisFieldIsRequired;
      return false;
    }else if (companyRegistrationController.text.length < 10) {
      companyRegistrationError.value = 'لا ينبغي أن تقل عدد الأرقام عن ١٠ أرقام';
      return false;
    }

    companyRegistrationError.value = "";
    return true;
  }

  bool validateAddress() {
    if (addressController.text.isEmpty) {
      addressError.value = StringConstants.thisFieldIsRequired;
      return false;
    }
    addressError.value = "";
    return true;
  }

  bool validatePhoneNumber() {
    if (phoneNumberController.text.isEmpty) {
      phoneNumberError.value = StringConstants.thisFieldIsRequired;
      return false;
    }
    String phoneNo = countryCode.value + phoneNumberController.text;
    if (phoneNo.length < 10) {
      phoneNumberError.value = StringConstants.invalidPhoneNumber;
      return false;
    }
    phoneNumberError.value = "";
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
    if (passwordController.text.length < 8) {
      passwordError.value = StringConstants.passwordMustBeAtleast8Characters;
      return false;
    }
    passwordError.value = "";
    return true;
  }

  void onFCNSubmitted() {
    fcnFocusNode.unfocus();
    crFocusNode.requestFocus();
  }

  void onCRSubmitted() {
    crFocusNode.unfocus();
    addressFocusNode.requestFocus();
  }

  void onAddressSubmitted() {
    addressFocusNode.unfocus();
    phoneNumberFocusNode.requestFocus();
  }

  void onPhoneNumberSubmitted() {
    phoneNumberFocusNode.unfocus();
    emailFocusNode.requestFocus();
  }

  void onEmailSubmitted() {
    emailFocusNode.unfocus();
    passwordFocusNode.requestFocus();
  }

  void onPasswordSubmitted() {
    passwordFocusNode.unfocus();
    // validateAndSubmit();
  }

  void validateAndSubmit(context) {
    if (verificationIdRecieved == null) {
      Get.snackbar(
        StringConstants.error,
        StringConstants.pleaseVerifyYourPhoneNumberFirst,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(10),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else if (validateFullCompanyName() &&
        validateCompanyRegistration() &&
        validateAddress() &&
        validateOtp() &&
        validatePhoneNumber() &&
        validateEmail() //&&
        // validatePassword()
    ) {

      verifyOtp(verificationIdRecieved, otpController.text, context);

    }
  }
}
