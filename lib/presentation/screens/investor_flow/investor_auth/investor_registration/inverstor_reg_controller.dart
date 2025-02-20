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
import 'package:ethabah/models/countries_model.dart';
import 'package:ethabah/presentation/screens/investor_flow/investor_auth/investor_registration/file_verification/file_verification_screen.dart';
import 'package:ethabah/presentation/screens/investor_flow/investor_auth/investor_registration/otp%20view/otp_view.dart';
import 'package:ethabah/presentation/screens/investor_flow/profile_pic/profile_pic_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class InvestorRegistrationController extends GetxController {
  final AuthFirebaseServices _authService = AuthFirebaseServices();
  final nameController = TextEditingController();
  final nationalIDController = TextEditingController();
  final RxString nationalIDError = "".obs;


  final nameFocusNode = FocusNode();
  final RxString nameError = "".obs;

  final emailController = TextEditingController();
  final emailFocusNode = FocusNode();
  final RxString emailError = "".obs;

  final passwordController = TextEditingController();
  final passwordFocusNode = FocusNode();
  final RxString passwordError = "".obs;

  final passwordConfirmationController = TextEditingController();
  final passwordConfirmationFocusNode = FocusNode();
  final RxString passwordConfirmationError = "".obs;

  final phoneController = TextEditingController();
  final phoneFocusNode = FocusNode();
  final RxString phoneError = "".obs;

  final addressController = TextEditingController();
  final addressFocusNode = FocusNode();
  final RxString addressError = "".obs;

  final RxList<File> passportFiles = <File>[].obs;
  final RxList<File> nationalIdFiles = <File>[].obs;

  final RxString passportError = "".obs;
  final RxString nationalIdError = "".obs;

  final RxBool isLoading = false.obs;
  final RxInt selectedIndex = (-1).obs;
  final RxString selectedCountry = StringConstants.enterAddress.obs;
  XFile? img;
  // Rx<XFile>? img = XFile('').obs;

  Future<void> pickFiles(RxList<File> files) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'],
      allowMultiple: true,
    );

    if (result != null) {
      files.addAll(result.paths.map((path) => File(path!)).toList());
    }
  }

  bool validateName() {

    if (nameController.text.isEmpty) {
      nameError.value = StringConstants.thisFieldIsRequired;
      return false;
    }
    nameError.value = "";
    return true;
  }

  bool validateNationalID() {

    if (nationalIDController.text.isEmpty) {
      nationalIDError.value = StringConstants.thisFieldIsRequired;
      return false;
    }else if (nationalIDController.text.length <10) {
      nationalIDError.value = 'لا ينبغي أن تقل عدد الأرقام عن ١٠ أرقام';
      return false;
    }
    nationalIDError.value = "";
    return true;
  }



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

  bool validatePasswordConfirmation() {
    if (passwordConfirmationController.text.isEmpty) {
      passwordConfirmationError.value = StringConstants.thisFieldIsRequired;
      return false;
    }
    if (passwordConfirmationController.text != passwordController.text) {
      passwordConfirmationError.value = StringConstants.passwordsDoNotMatch;
      return false;
    }
    passwordConfirmationError.value = "";
    return true;
  }

  bool validatePhone() {
    if (phoneController.text.isEmpty) {
      phoneError.value = StringConstants.thisFieldIsRequired;
      return false;
    }
    phoneError.value = "";
    return true;
  }

  bool validateAddress() {
    // if (addressController.text.isEmpty) {
    //   addressError.value = StringConstants.thisFieldIsRequired;
    //   return false;
    // }
    if (selectedIndex.value == -1) {
      addressError.value = StringConstants.thisFieldIsRequired;
      return false;
    }
    addressError.value = "";
    return true;
  }

  bool validatePassport() {
    if (passportFiles.isEmpty) {
      passportError.value = StringConstants.thisFieldIsRequired;
      return false;
    }
    passportError.value = "";
    return true;
  }

  bool validateNationalId() {
    if (nationalIdFiles.isEmpty) {
      nationalIdError.value = StringConstants.thisFieldIsRequired;
      return false;
    }
    nationalIdError.value = "";
    return true;
  }

  void onNameSubmitted() {
    nameFocusNode.unfocus();
    phoneFocusNode.requestFocus();
  }

  void onEmailSubmitted() {
    emailFocusNode.unfocus();
    passwordFocusNode.requestFocus();
  }

  void onPasswordSubmitted() {
    passwordFocusNode.unfocus();
    passwordConfirmationFocusNode.requestFocus();
  }

  void onPasswordConfirmationSubmitted() {
    passwordConfirmationFocusNode.unfocus();
    phoneFocusNode.requestFocus();
  }

  void onPhoneSubmitted() {
    phoneFocusNode.unfocus();
    phoneFocusNode.requestFocus();
  }

  void onAddressSubmitted() {
    addressFocusNode.unfocus();
  }

  final suCode = '+966';

  RxBool isOTPsend = false.obs;
  RxBool isOTPsendLoading = false.obs;
  RxBool isVerifyLoading = false.obs;

  final TextEditingController otpController = TextEditingController();
  final FocusNode otpFocusNode = FocusNode();
  final RxString otpError = "".obs;

  Timer? _otpTimer;
  RxInt _otpTimerSeconds = 0.obs;
  String? verificationIdRecieved;



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

  bool validateOtp() {
    if (otpController.text.isEmpty) {
      otpError.value = StringConstants.thisFieldIsRequired;

      return false;
    }
    otpError.value = "";
    return true;
  }

////////////
//   getVerifyCode() async{
//     isOTPsendLoading.value = true;
//     if (_otpTimer != null && _otpTimer!.isActive) {
//       Get.snackbar(
//         StringConstants.error,
//         '${StringConstants.pleaseWaitFor} ${_otpTimerSeconds
//             .value} ${StringConstants.secondsBeforeRequestingNewOtp}.',
//         snackPosition: SnackPosition.TOP,
//         margin: const EdgeInsets.all(10),
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//       return;
//      }
//     try {
//       Map<String, dynamic> result = await authProvider.AuthProvider.loginWithPhone(
//         phoneController.text,
//       );
//       if(result['message'] == 'User found'){
//         Get.snackbar(
//           StringConstants.error,
//           'هذا الرقم مسجل مسبقا',
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//         );
//         isOTPsendLoading.value = false;
//       }else{
//         _authService.registerPhoneNumber(
//           // phoneNumber: phoneNumber,
//           phoneNumber: '+201061366831',
//
//           verificationCompleted: (PhoneAuthCredential credential) async {
//             verificationIdRecieved = credential.verificationId;
//             isOTPsendLoading.value = false;
//
//             //TODO:AUTO VALIDATE
//             // await _authService.signInWithCredential(
//             //   verificationId: '',
//             //   smsCode: credential.smsCode!,
//             // );
//             // isOTPsendLoading.value = false;
//           },
//           verificationFailed: (FirebaseAuthException e) {
//             // log("phone no : $phoneNumber");
//             verificationIdRecieved = null;
//             log('Failed with error code: ${e.code}');
//             log('Message: ${e.message}');
//             Get.snackbar(
//               snackPosition: SnackPosition.TOP,
//               margin: const EdgeInsets.all(10),
//               StringConstants.error,
//               StringConstants.verificationFailed,
//               backgroundColor: Colors.red,
//               colorText: Colors.white,
//             );
//             isOTPsendLoading.value = false;
//           },
//           codeSent: (String verificationId, int? resendToken) {
//             print('333333333333333333');
//             isOTPsendLoading.value = false;
//             isOTPsend.value = true;
//             verificationIdRecieved = verificationId;
//             Get.snackbar(
//               snackPosition: SnackPosition.TOP,
//               margin: const EdgeInsets.all(10),
//               StringConstants.otpSentSuccessfully,
//               StringConstants.weHaveSentYouVerificationCodeOnYourPhoneNumber,
//               backgroundColor: Colors.green,
//               colorText: Colors.white,
//             );
//             _startOTPTimer();
//           },
//           codeAutoRetrievalTimeout: (String verificationId) {
//             verificationIdRecieved = null;
//             isOTPsendLoading.value = false;
//           },
//         );
//         // isOTPsendLoading.value = false;
//       }
//
//     } catch (e) {
//       Get.snackbar(
//         StringConstants.error,
//         // e.toString(),
//         StringConstants.somethingWentWrong,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//       isOTPsendLoading.value = false;
//
//     }
//   }
//
//
//   verifyPhone(String otpCode,) async{
//     print(otpCode);
//     isVerifyLoading.value = true;
//     await _authService.signInWithCredential(
//       verificationId: verificationIdRecieved??'',
//       // smsCode:otpCode,
//       smsCode: otpCode
//     ).then((onValue){
//       isVerifyLoading.value = false;
//       Get.snackbar(
//         snackPosition: SnackPosition.TOP,
//         margin: const EdgeInsets.all(10),
//         StringConstants.success,
//         StringConstants.phoneVerifiedSuccessfully,
//         backgroundColor: Colors.green,
//         colorText: Colors.white,
//       );
//       Get.toNamed(RoutesConstants.investorRegister);
//     }).catchError((onError){
//       isVerifyLoading.value = false;
//       Get.snackbar(
//         StringConstants.error,
//         StringConstants.invalidOtp,
//         snackPosition: SnackPosition.TOP,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//       otpCode = '';
//
//     });
//   }
  void registerSubmit(BuildContext context) async {

     isLoading.value = true;
    if (validateName() &&
        validateNationalID() &&
         validateEmail() &&
        // validatePassword() &&
        // validateOtp() &&
        validatePhone()
        &&
        validateAddress()

    ) {
      registerInvestor();


    }else{
      Get.snackbar(
        StringConstants.error,
        'يرجى إدخال البيانات المطلوبة',
        backgroundColor:kStarColor,
        colorText: Colors.white,
      );
      isLoading.value = false;

    }
  }

  Future<void> registerInvestor() async {
    print('jjjjjjjjj${phoneController.text}');
    try {
      final result = await authProvider.AuthProvider.registerInvestor(
          nameController.text,
          nationalIDController.text,

          emailController.text,
          // passwordController.text,
          // passwordConfirmationController.text,

          // '1234567890',
        "${phoneController.text.replaceAll(' ', '')}",
          selectedCountry.value,

          img != null? File(img!.path):null,
          // '+9666666660'

      );
      if (result.keys.first) {
        // Get.offAllNamed(RoutesConstants.authOnboard);
        Get.offNamed(RoutesConstants.underReview);

        Get.snackbar(
          StringConstants.success,
          StringConstants.userRegisteredSuccessfully,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        isLoading.value = false;
        Get.delete<InvestorRegistrationController>(force: true);


      } else {

        Get.snackbar(
          StringConstants.error,
          result.values.first,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('eeeeeeeeee$e');
      Get.snackbar(
        StringConstants.error,
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,

      );
      isLoading.value = false;

    } finally {
      isLoading.value = false;
    }

  }





  ////1/////
  // void registerPhoneNumber() async {
  //   if (_otpTimer != null && _otpTimer!.isActive) {
  //     Get.snackbar(
  //       StringConstants.error,
  //       '${StringConstants.pleaseWaitFor} ${_otpTimerSeconds.value} ${StringConstants.secondsBeforeRequestingNewOtp}.',
  //       snackPosition: SnackPosition.TOP,
  //       margin: const EdgeInsets.all(10),
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //     );
  //     return;
  //   }
  //   if (validatePhone()) {
  //     isOTPsendLoading.value = true;
  //     // final phoneNumber = "$suCode ${phoneController.text}";
  //     print('iiiiiiiiiiiiiiiiiiiiii');
  //     _authService.registerPhoneNumber(
  //       // phoneNumber: phoneNumber,
  //       phoneNumber: '+201061366831',
  //
  //       verificationCompleted: (PhoneAuthCredential credential) async {
  //         verificationIdRecieved = credential.verificationId;
  //         //TODO:AUTO VALIDATE
  //         // await _authService.signInWithCredential(
  //         //   verificationId: '',
  //         //   smsCode: credential.smsCode!,
  //         // );
  //         // isOTPsendLoading.value = false;
  //       },
  //       verificationFailed: (FirebaseAuthException e) {
  //         // log("phone no : $phoneNumber");
  //         verificationIdRecieved = null;
  //         log('Failed with error code: ${e.code}');
  //         log('Message: ${e.message}');
  //         Get.snackbar(
  //           snackPosition: SnackPosition.TOP,
  //           margin: const EdgeInsets.all(10),
  //           StringConstants.error,
  //           StringConstants.verificationFailed,
  //           backgroundColor: Colors.red,
  //           colorText: Colors.white,
  //         );
  //         isOTPsendLoading.value = false;
  //       },
  //       codeSent: (String verificationId, int? resendToken) {
  //         print('333333333333333333');
  //         isOTPsendLoading.value = false;
  //         isOTPsend.value = true;
  //         verificationIdRecieved = verificationId;
  //         Get.snackbar(
  //           snackPosition: SnackPosition.TOP,
  //           margin: const EdgeInsets.all(10),
  //           StringConstants.otpSentSuccessfully,
  //           StringConstants.weHaveSentYouVerificationCodeOnYourPhoneNumber,
  //           backgroundColor: Colors.green,
  //           colorText: Colors.white,
  //         );
  //         _startOTPTimer();
  //       },
  //       codeAutoRetrievalTimeout: (String verificationId) {
  //         verificationIdRecieved = null;
  //         print('5555555555555555');
  //         isOTPsendLoading.value = false;
  //       },
  //     );
  //   }
  //
  // }
  // ////2/////
  // void validateAndSubmit(BuildContext context) async {
  //
  //
  //
  //     if (validateName() &&
  //         validateNationalID() &&
  //           // validateEmail() &&
  //           validatePassword() &&
  //           validateOtp() &&
  //           validatePhone()
  //             &&
  //            validateAddress()
  //       // &&
  //       // validatePassport() &&
  //       // validateNationalId()
  //       ) {
  //       if (verificationIdRecieved == null) {
  //         Get.snackbar(
  //           StringConstants.error,
  //           StringConstants.pleaseVerifyYourPhoneNumberFirst,
  //           snackPosition: SnackPosition.TOP,
  //           margin: const EdgeInsets.all(10),
  //           backgroundColor: Colors.red,
  //           colorText: Colors.white,
  //         );
  //       } else{
  //         verifyOtp(verificationIdRecieved, otpController.text,
  //             context);
  //       }
  //
  //   }else{
  //       Get.snackbar(
  //         StringConstants.error,
  //         'يرجى إدخال البيانات المطلوبة',
  //         backgroundColor:kStarColor,
  //         colorText: Colors.white,
  //       );
  //     }
  // }
  //
  // Future<void> verifyOtp(verificationId, otp, BuildContext context) async {
  //   isLoading.value = true;
  //   try {
  //     await _authService.signInWithCredential(
  //       verificationId: verificationIdRecieved??'',
  //       smsCode: otp,
  //     ).then((onValue){
  //       registerInvestor();
  //       isLoading.value = false;
  //     });
  //
  //   } catch (error) {
  //     log('Failed with error code: ${error.toString()}');
  //     isLoading.value = false;
  //     Get.snackbar(
  //       StringConstants.error,
  //       StringConstants.invalidOtp,
  //       snackPosition: SnackPosition.TOP,
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //     );
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }


}
