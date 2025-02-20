import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/core/constants/app_urls.dart';
import 'package:ethabah/data/remote/auth_provider.dart';
import 'package:ethabah/data/shared/user_pref.dart';
import 'package:ethabah/models/countries_model.dart';
import 'package:ethabah/models/req_investment_fund_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

class EditCompanyProfileController extends GetxController {
  final nameController = TextEditingController();
  final nameFocusNode = FocusNode();
  final RxString nameError = "".obs;

  final emailController = TextEditingController();
  final emailFocusNode = FocusNode();
  final RxString emailError = "".obs;

  final phoneController = TextEditingController();
  final phoneFocusNode = FocusNode();
  final RxString phoneError = "".obs;

  final addressController = TextEditingController();
  final addressFocusNode = FocusNode();
  final RxString addressError = "".obs;

  final registerNumController = TextEditingController();
  final registerNumFocusNode = FocusNode();
  final RxString registerNumError = "".obs;

  final passwordController = TextEditingController();
  final passwordFocusNode = FocusNode();
  final RxString passwordError = "".obs;

  final RxList<File> registerCertificateFiles = <File>[].obs;
  final RxList<File> commercialCertificateFiles = <File>[].obs;
  final RxList<File> licensesFiles = <File>[].obs;

  final RxString registerCertificateError = "".obs;
  final RxString commercialCertificateError = "".obs;
  final RxString licensesError = "".obs;

  final RxBool isDataLoading = false.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadCompanyProfile();
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

  final RxInt selectedIndex = (-1).obs;
  final RxString selectedCountry = StringConstants.enterAddress.obs;


  bool validateAddress() {
    if (addressController.text.isEmpty) {
      addressError.value = StringConstants.thisFieldIsRequired;
      return false;
    }
    // if (selectedIndex.value == -1) {
    //   addressError.value = StringConstants.thisFieldIsRequired;
    //   return false;
    // }
    addressError.value = "";
    return true;
  }


  Future<void> _loadCompanyProfile() async {
    isDataLoading.value = true;
    String? token = await SharedPref.getToken();
    final response =
        await http.get(Uri.parse(GET_COMPANY_EDIT_DETAILS), headers: {
      "Authorization": "Bearer $token",
    });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      log(data.toString());
      Company companyModel = Company.fromJson(data['data']);
      nameController.text = companyModel.name ?? "";
      emailController.text = companyModel.email ?? "";
      String phone = companyModel.phone ?? "";
      addressController.text = companyModel.address??'';

      if (phone.startsWith('+966')) {
        phoneController.text = phone.replaceAll('+966', '');
      } else {
        phoneController.text = phone;
      }
      // if (phone.startsWith('966')) {
      //   phoneController.text = phone.substring(3);
      // } else {
      //   phoneController.text = phone;
      // }
      addressController.text = companyModel.address ?? "";
      registerNumController.text = companyModel.register_num ?? "";
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

  // bool validateAddress() {
  //   if (addressController.text.isEmpty) {
  //     addressError.value = StringConstants.thisFieldIsRequired;
  //     return false;
  //   }
  //   addressError.value = "";
  //   return true;
  // }

  bool validateRegisterNum() {
    if (registerNumController.text.isEmpty) {
      registerNumError.value = StringConstants.thisFieldIsRequired;
      return false;
    }
    registerNumError.value = "";
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

  bool validateRegisterCertificate() {
    if (registerCertificateFiles.isEmpty) {
      registerCertificateError.value = StringConstants.thisFieldIsRequired;
      return false;
    }
    registerCertificateError.value = "";
    return true;
  }

  bool validateCommercialCertificate() {
    if (commercialCertificateFiles.isEmpty) {
      commercialCertificateError.value = StringConstants.thisFieldIsRequired;
      return false;
    }
    commercialCertificateError.value = "";
    return true;
  }

  bool validateLicenses() {
    if (licensesFiles.isEmpty) {
      licensesError.value = StringConstants.thisFieldIsRequired;
      return false;
    }
    licensesError.value = "";
    return true;
  }

  Future<bool> updateProfile() async {
    if (validateName() &&
        validateEmail() &&
        validatePhone() &&
        validateAddress() &&
        validateRegisterNum()) {
      isLoading.value = true;
      try {
        String phoneNum = phoneController.text.length == 9?phoneController.text :"${phoneController.text}";
        final result = await AuthProvider.updateCompanyDetails(
          nameController.text,
          // "966${phoneController.text}",
          phoneNum,

          emailController.text,
          addressController.text,
          registerNumController.text,
          // registerCertificateFiles,
          commercialCertificateFiles,
          licensesFiles,
          passwordController.text.isNotEmpty ? passwordController.text : null,
        );
        log(result.toString());
        //g(result.key.first ==  true)
        if (result.keys.first == true) {
          log(result.keys.first.toString(), name: 'result');
          // Get.snackbar(
          //   StringConstants.success,
          //   result.values.first,
          //   backgroundColor: Colors.green,
          //   colorText: Colors.white,
          // );
          // Get.back();
          return true;
        } else {
          Get.snackbar(
            StringConstants.error,
            result.values.first,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return false;
        }
      } catch (e) {
        Get.snackbar(
          StringConstants.error,
          e.toString(),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      } finally {
        isLoading.value = false;
      }
    }
    return false;
  }
}
