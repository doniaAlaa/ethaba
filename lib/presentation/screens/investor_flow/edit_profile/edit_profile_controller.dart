import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:ethabah/core/constants/app_routes.dart';
import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/core/constants/app_urls.dart';
import 'package:ethabah/core/routes/generated_routes.dart';
import 'package:ethabah/data/remote/auth_provider.dart';
import 'package:ethabah/data/shared/user_pref.dart';
import 'package:ethabah/models/User_model.dart';
import 'package:ethabah/models/countries_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class EditProfileController extends GetxController {
  final nameController = TextEditingController();
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
  final RxBool isDataLoading = false.obs;

  final RxInt selectedIndex = (-1).obs;
  final RxString selectedCountry = StringConstants.enterAddress.obs;
  XFile? img;
  final nationalIDController = TextEditingController();
  final RxString nationalIDError = "".obs;
   String profile_img = '';

  @override
  void onInit() {
    super.onInit();
    _loadUserProfile();
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

  // filepath: /C:/Projects/ethabah_priv/lib/presentation/screens/investor_flow/edit_profile/edit_profile_controller.dart
  Future<void> _loadUserProfile() async {
    isDataLoading.value = true;
    String? token = await SharedPref.getToken();

    final response =
        await http.get(Uri.parse(GET_INVESTOR_EDIT_DETAILS), headers: {
      "Authorization": "Bearer $token",
    });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      log(data.toString());
      User userModel = User.fromJson(data['data']);
      nameController.text = userModel.name ?? "";
      emailController.text = userModel.email ?? "";
      nationalIDController.text = userModel.nationalId??'';
      profile_img = userModel.profile_img??'';

      String phone = userModel.phone ?? "";
      if (phone.startsWith('966')) {
        phoneController.text = phone.substring(3);
      }
      if (phone.startsWith('+966')) {
        phoneController.text = phone.substring(4);
      } else {
        phoneController.text = phone;
      }
      addressController.text = userModel.address ?? "";
      // print(data);
    } else {
      // print('Failed to load data');
    }
    isDataLoading.value = false;
  }

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
    }else if(phoneController.text.length < 8){
      phoneError.value = 'يجب ألا يقل رقم الهاتف عن ٩ أرقام';
      return false;
    }
    phoneError.value = "";
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

  Future<void> updateProfile(BuildContext context) async {
    if (validateName() &&
        validateEmail() &&
        validatePhone() &&
        validateAddress() &&
        (passwordController.text.isNotEmpty
            ? validatePassword() && validatePasswordConfirmation()
            : true)) {
      isLoading.value = true;
      try {
        String phoneNum = phoneController.text.length == 9?phoneController.text :"${phoneController.text}";

        final result = await AuthProvider.updateInvestor(
          nameController.text,
          emailController.text,
          passwordController.text.isEmpty ? null : passwordController.text,
          passwordConfirmationController.text.isEmpty
              ? null
              : passwordConfirmationController.text,
          // passportFiles,
          // nationalIdFiles,
          nationalIDController.text,
          addressController.text,
          // "5${phoneController.text}",
          phoneNum,
          img != null? File(img!.path):null,

        );
        log(result.toString());
        if (result.keys.first) {
          Get.snackbar(
            StringConstants.success,
            result.values.first,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
           // Navigator.pop(context);
          Get.toNamed(RoutesConstants.investorDashboard);
          Get.delete<EditProfileController>(force: true);

        } else {
          Get.snackbar(
            StringConstants.error,
            result.values.first,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } catch (e) {
        Get.snackbar(
          StringConstants.error,
          e.toString(),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } finally {
        isLoading.value = false;
      }
    }
  }
}
