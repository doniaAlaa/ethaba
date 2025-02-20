// import 'dart:developer';

// import 'package:ethabah/controller/categories_controller.dart';
// import 'package:ethabah/core/constants/app_strings.dart';
// import 'package:ethabah/models/categories_model.dart';
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';

// class SubmitReqController extends GetxController {
//   List<CategoryModel> categories = [];

//   final categoriesCntrlr = Get.isRegistered<CategoriesController>()
//       ? Get.find<CategoriesController>()
//       : Get.put(CategoriesController(), permanent: true);

//   // TextEditingControllers
//   final TextEditingController projectNameController = TextEditingController();
//   final TextEditingController purposeOfFundingController =
//       TextEditingController();
//   final TextEditingController totalFundsController = TextEditingController();
//   final TextEditingController shortDescriptionController =
//       TextEditingController();

//   // FocusNodes
//   final FocusNode projectNameFocusNode = FocusNode();
//   final FocusNode purposeOfFundingFocusNode = FocusNode();
//   final FocusNode totalFundsFocusNode = FocusNode();
//   final FocusNode shortDescriptionFocusNode = FocusNode();

//   // Error placeholders
//   final RxString projectNameError = ''.obs;
//   final RxString categoryError = ''.obs;
//   final RxString purposeOfFundingError = ''.obs;
//   final RxString totalFundsError = ''.obs;
//   final RxString shortDescriptionError = ''.obs;

//   // Selected category
//   final Rx<CategoryModel?> selectedCategory = Rx<CategoryModel?>(null);

//   RxBool isLoading = false.obs;

//   @override
//   void onInit() {
//     categories = categoriesCntrlr.categories;
//     log('Categories: $categories');
//     super.onInit();
//   }

//   // Validation functions
//   bool validateProjectName() {
//     if (projectNameController.text.isEmpty) {
//       projectNameError.value = StringConstants.thisFieldIsRequired;
//       return false;
//     }
//     projectNameError.value = '';
//     return true;
//   }

//   bool validateCategory() {
//     if (selectedCategory.value == null) {
//       categoryError.value = StringConstants.thisFieldIsRequired;
//       return false;
//     }
//     categoryError.value = '';
//     return true;
//   }

//   bool validatePurposeOfFunding() {
//     if (purposeOfFundingController.text.isEmpty) {
//       purposeOfFundingError.value = StringConstants.thisFieldIsRequired;
//       return false;
//     }
//     purposeOfFundingError.value = '';
//     return true;
//   }

//   bool validateTotalFunds() {
//     if (totalFundsController.text.isEmpty) {
//       totalFundsError.value = StringConstants.thisFieldIsRequired;
//       return false;
//     }
//     totalFundsError.value = '';
//     return true;
//   }

//   bool validateShortDescription() {
//     if (shortDescriptionController.text.isEmpty) {
//       shortDescriptionError.value = StringConstants.thisFieldIsRequired;
//       return false;
//     }
//     shortDescriptionError.value = '';
//     return true;
//   }

//   bool validateForm() {
//     bool isProjectNameValid = validateProjectName();
//     bool isCategoryValid = validateCategory();
//     bool isPurposeOfFundingValid = validatePurposeOfFunding();
//     bool isTotalFundsValid = validateTotalFunds();
//     bool isShortDescriptionValid = validateShortDescription();

//     return isProjectNameValid &&
//         isCategoryValid &&
//         isPurposeOfFundingValid &&
//         isTotalFundsValid &&
//         isShortDescriptionValid;
//   }
// }
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:ethabah/controller/categories_controller.dart';
import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/data/remote/request_provider.dart';
import 'package:ethabah/models/categories_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SubmitReqController extends GetxController {
  List<CategoryModel> categories = [];

  final categoriesCntrlr = Get.isRegistered<CategoriesController>()
      ? Get.find<CategoriesController>()
      : Get.put(CategoriesController(), permanent: true);

  // TextEditingControllers
  final TextEditingController projectNameController = TextEditingController();
  final TextEditingController purposeOfFundingController =
      TextEditingController();
  final TextEditingController totalFundsController = TextEditingController();
  final TextEditingController fileController = TextEditingController();

  final TextEditingController shortDescriptionController =
      TextEditingController();

  // FocusNodes
  final FocusNode projectNameFocusNode = FocusNode();
  final FocusNode purposeOfFundingFocusNode = FocusNode();
  final FocusNode totalFundsFocusNode = FocusNode();
  final FocusNode shortDescriptionFocusNode = FocusNode();

  // Error placeholders
  final RxString projectNameError = ''.obs;
  final RxString categoryError = ''.obs;
  final RxString purposeOfFundingError = ''.obs;
  final RxString totalFundsError = ''.obs;
  final RxString shortDescriptionError = ''.obs;
  final RxString fileError = ''.obs;
  final RxString fileNameError = ''.obs;

  // Selected category
  final Rx<CategoryModel?> selectedCategory = Rx<CategoryModel?>(null);

  // Selected file
  final Rx<File?> selectedFile = Rx<File?>(null);
  final RxList<File> documents = <File>[].obs ;
  final List<String> documentsNames = <String>[].obs ;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    categories = categoriesCntrlr.categories;
    //log('Categories: $categories');
    super.onInit();
  }

  // Validation functions
  bool validateProjectName() {
    if (projectNameController.text.isEmpty) {
      projectNameError.value = StringConstants.thisFieldIsRequired;
      return false;
    }
    projectNameError.value = '';
    return true;
  }
  bool validateFileName() {
    if (fileController.text.isEmpty) {
      fileNameError.value = StringConstants.thisFieldIsRequired;
      return false;
    }
    fileNameError.value = '';
    return true;
  }
  bool validateCategory() {
    if (selectedCategory.value == null) {
      categoryError.value = StringConstants.thisFieldIsRequired;
      return false;
    }
    categoryError.value = '';
    return true;
  }

  bool validatePurposeOfFunding() {
    if (purposeOfFundingController.text.isEmpty) {
      purposeOfFundingError.value = StringConstants.thisFieldIsRequired;
      return false;
    }
    purposeOfFundingError.value = '';
    return true;
  }

  bool validateTotalFunds() {
    if (totalFundsController.text.isEmpty) {
      totalFundsError.value = StringConstants.thisFieldIsRequired;
      return false;
    }
    totalFundsError.value = '';
    return true;
  }

  bool validateShortDescription() {
    if (shortDescriptionController.text.isEmpty) {
      shortDescriptionError.value = StringConstants.thisFieldIsRequired;
      return false;
    }
    shortDescriptionError.value = '';
    return true;
  }

  bool validateFile() {
    if (documents.isEmpty) {
      fileError.value = StringConstants.thisFieldIsRequired;
      return false;
    }
    fileError.value = '';
    return true;
  }

  bool validateForm() {
    bool isProjectNameValid = validateProjectName();
    bool isCategoryValid = validateCategory();
    bool isPurposeOfFundingValid = validatePurposeOfFunding();
    bool isTotalFundsValid = validateTotalFunds();
    bool isShortDescriptionValid = validateShortDescription();
    bool isFilesValid = validateFile();
    // bool isFileValid = validateFile();

    return isProjectNameValid &&
        isCategoryValid &&
        isPurposeOfFundingValid &&
        isTotalFundsValid &&
        isShortDescriptionValid &&
        isFilesValid;
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'],
    );

    if (result != null && result.files.single.path != null) {
      selectedFile.value = File(result.files.single.path!);
      documents.add(File(result.files.single.path!));
      documentsNames.add(fileController.text);
    }

  }

  onSubmit(context) async {
    if (validateForm()) {
      isLoading.value = true;
      try {
        final response = await RequestProvider.postRequest(
          projectNameController.text,
          selectedCategory.value!.id.toString(),
          purposeOfFundingController.text,
          totalFundsController.text,
          shortDescriptionController.text,
          documents,
          documentsNames,
          selectedFile.value,
        );
        if (response != null) {
          // log(response.toString());
          Get.snackbar(
            StringConstants.success,
            StringConstants.requestSubmittedSuccessfully,
            snackPosition: SnackPosition.TOP,
            margin: const EdgeInsets.all(10),
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          Navigator.pop(context);
        } else {
          Get.snackbar(
            StringConstants.error,
            StringConstants.failedToSubmitRequest,
            snackPosition: SnackPosition.TOP,
            margin: const EdgeInsets.all(10),
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } catch (e) {
        print('iiiiiiiiiiiiiii$e');
        Get.snackbar(
          StringConstants.error,
          StringConstants.failedToSubmitRequest,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } finally {
        isLoading.value = false;
      }
    }
  }
}
