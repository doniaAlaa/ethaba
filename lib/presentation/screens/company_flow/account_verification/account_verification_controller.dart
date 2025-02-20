import 'package:ethabah/core/constants/app_routes.dart';
import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/data/remote/auth_provider.dart';
import 'package:ethabah/presentation/screens/company_flow/company_registration/company_registration_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

import 'package:file_picker/file_picker.dart';

class AccountVerificationController extends GetxController {
  final TextEditingController fullCompanyNameController =
      TextEditingController();
  final TextEditingController companyRegistrationController =
      TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final RxBool agreeToTerms = false.obs;
  final RxList<File> companyRegistrationCertificates = <File>[].obs;
  final RxList<File> commercialRegistrationCertificates = <File>[].obs;
  final RxList<File> otherLicenses = <File>[].obs;

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

  bool validateFields() {
    if (!agreeToTerms.value) {
      Get.snackbar(StringConstants.error,
          StringConstants.youMustAgreeToTheTermsAndConditions,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.all(10));
      return false;
    }
    if (companyRegistrationCertificates.isEmpty) {
      Get.snackbar(StringConstants.error,
          StringConstants.companyRegistrationCertificateMustBeUploaded,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.all(10));
      return false;
    }
    // if (commercialRegistrationCertificates.isEmpty) {
    //   Get.snackbar(StringConstants.error,
    //       StringConstants.commercialRegistrationCertificateMustBeUploaded,
    //       backgroundColor: Colors.red,
    //       colorText: Colors.white,
    //       snackPosition: SnackPosition.TOP,
    //       margin: const EdgeInsets.all(10));
    //   return false;
    // }
    return true;
  }

  final RxBool isLoading = false.obs;

  void onSubmit() async {
    if (validateFields()) {
      isLoading.value = true;
      try {
        final result = await AuthProvider.companyRegister(
          fullCompanyNameController.text,
          emailController.text,
          // "${966}${phoneNumberController.text}",
          phoneNumberController.text,
          passwordController.text,
          companyRegistrationController.text,
           companyRegistrationCertificates.value,
          // commercialRegistrationCertificates,
          otherLicenses,
          addressController.text,
        );
        if (result.keys.first) {
          Get.snackbar(
            StringConstants.success,
            result.values.first,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          Get.delete<AccountVerificationController>(force: true);
          Get.delete<CompanyRegistrationController>(force: true);

          Get.offNamed(RoutesConstants.underReview);
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
