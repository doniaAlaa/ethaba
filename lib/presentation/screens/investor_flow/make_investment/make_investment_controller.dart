import 'dart:io';

import 'package:ethabah/controller/categories_controller.dart';
import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/core/constants/app_theme.dart';
import 'package:ethabah/data/remote/invesment_fund.dart';
import 'package:ethabah/data/remote/request_provider.dart';
import 'package:ethabah/models/investment_dropdown_model.dart';
import 'package:ethabah/presentation/screens/investor_flow/inv_dashboard/inv_dashboard_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class MakeInvestmentController extends GetxController {
  // TextEditingControllers
  final TextEditingController amountController = TextEditingController();
  final Rx<InvestmentDropdownItem?> investmentFundController =
      Rx<InvestmentDropdownItem?>(null);
  final TextEditingController timeOfInvestmentController =
      TextEditingController();
  final TextEditingController startOfPeriodController = TextEditingController();
  final TextEditingController endOfPeriodController = TextEditingController();

  // FocusNodes
  final FocusNode amountFocusNode = FocusNode();
  final FocusNode investmentFundFocusNode = FocusNode();
  final FocusNode timeOfInvestmentFocusNode = FocusNode();
  final FocusNode startOfPeriodFocusNode = FocusNode();
  final FocusNode endOfPeriodFocusNode = FocusNode();

  // Error placeholders
  final RxString amountError = ''.obs;
  final RxString investmentFundError = ''.obs;
  final RxString timeOfInvestmentError = ''.obs;
  final RxString startOfPeriodError = ''.obs;
  final RxString endOfPeriodError = ''.obs;
  double? remainingAmount;
  final RxString fileError = ''.obs;
  final RxBool fileValidated = false.obs;


  // Selected file
  final Rx<XFile?> selectedFile = Rx<XFile?>(null);

  RxBool isLoading = false.obs;
  List<InvestmentDropdownItem> categories = [];

  final catCntlr = Get.isRegistered<CategoriesController>()
      ? Get.find<CategoriesController>()
      : Get.put(CategoriesController());

  @override
  void onInit() {
    categories = catCntlr.investmentNames;
    super.onInit();
  }

  //assign the investment fund by name on start if given
  void assignInvesmentFundToDropDown(String investmentFund) {
    InvestmentDropdownItem? item = categories.firstWhere(
        (element) => element.name == investmentFund,
        orElse: () => InvestmentDropdownItem(id: 0, name: ''));
    investmentFundController.value = item;
  }

  // Validation functions
  bool validateAmount(int minAmount) {
    if (amountController.text.isEmpty) {
      amountError.value = StringConstants.thisFieldIsRequired;
      return false;
    }
    // if (remainingAmount != null &&
    //     double.parse(amountController.text) > remainingAmount!) {
    //   amountError.value =
    //       StringConstants.investmentCannotBeGreaterThanRemainingAmount;
    //   return false;
    // }
    if (
        double.parse(amountController.text) < minAmount) {
      amountError.value ='لا يمكن أن يكون المبلغ المدفوع أقل من الحد الأدنى من مبلغ الإستثمار';
      return false;
    }
    amountError.value = '';
    return true;
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'],
    );

    if (result != null && result.files.single.path != null) {
      selectedFile.value = XFile(result.files.single.path!);
    }
  }

  bool validateInvestmentFund() {
    if (investmentFundController.value != null &&
        investmentFundController.value!.id == 0) {
      investmentFundError.value = StringConstants.thisFieldIsRequired;
      return false;
    }
    investmentFundError.value = '';
    return true;
  }

  bool validateTimeOfInvestment() {
    if (timeOfInvestmentController.text.isEmpty) {
      timeOfInvestmentError.value = StringConstants.thisFieldIsRequired;
      return false;
    }
    timeOfInvestmentError.value = '';
    return true;
  }

  bool validateStartOfPeriod() {
    if (startOfPeriodController.text.isEmpty) {
      startOfPeriodError.value = StringConstants.thisFieldIsRequired;
      return false;
    }

    DateTime startOfPeriod = DateTime.parse(startOfPeriodController.text);
    DateTime today = DateTime.now();
    DateTime? endOfPeriod;

    if (endOfPeriodController.text.isNotEmpty) {
      endOfPeriod = DateTime.parse(endOfPeriodController.text);
    }

    // if (startOfPeriod.isBefore(today)) {
    //   startOfPeriodError.value = StringConstants.startDateCannotBeBeforeToday;
    //   return false;
    // }

    if (endOfPeriod != null && startOfPeriod.isAfter(endOfPeriod)) {
      startOfPeriodError.value = StringConstants.startDateCannotBeAfterEndDate;
      return false;
    }

    startOfPeriodError.value = '';
    return true;
  }

  bool validateEndOfPeriod() {
    if (endOfPeriodController.text.isEmpty) {
      endOfPeriodError.value = StringConstants.thisFieldIsRequired;
      return false;
    }

    DateTime endOfPeriod = DateTime.parse(endOfPeriodController.text);
    DateTime today = DateTime.now();
    DateTime? startOfPeriod;

    if (startOfPeriodController.text.isNotEmpty) {
      startOfPeriod = DateTime.parse(startOfPeriodController.text);
    }

    if (endOfPeriod.isBefore(today)) {
      endOfPeriodError.value = StringConstants.endDateCannotBeBeforeToday;
      return false;
    }

    if (startOfPeriod != null && endOfPeriod.isBefore(startOfPeriod)) {
      endOfPeriodError.value = StringConstants.endDateCannotBeBeforeStartDate;
      return false;
    }

    endOfPeriodError.value = '';
    return true;
  }

  // bool validateForm(int min) {
  //   bool isAmountValid = validateAmount(min);
  //   bool isInvestmentFundValid = validateInvestmentFund();
  //
  //   return isAmountValid && isInvestmentFundValid;
  //
  // }

  bool validateForm(int min) {
    bool isAmountValid = validateAmount(min);
    bool isFileValid = validateFile();
    isFileValid?
    fileValidated.value = false:fileValidated.value = true;
    // bool isInvestmentFundValid = validateInvestmentFund();
    // return isAmountValid && isInvestmentFundValid;
    return isAmountValid && isFileValid;
  }

  bool validateFile(){
    if(selectedFile.value == null){

      return false;
    }else{
      return true;
    }
  }


  onSubmit(context,int fundId,int min) async {
    //assign now time to time of investment
    if (validateForm(min)) {
      isLoading.value = true;

      try {
        var result = await InvestmentFundProvider.sendInvestReq(amountController.text, fundId.toString(), selectedFile.value);
         // print(result[])
         isLoading.value = false;
          Get.snackbar(
            StringConstants.success,
            StringConstants.investmentSubmittedSuccessfully,
            snackPosition: SnackPosition.TOP,
            margin: const EdgeInsets.all(10),
            backgroundColor: Colors.green,
            colorText: kWhiteColor,
          );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const InvDashboardScreen()),
        );
      } catch (e) {
        print(e);

        isLoading.value = false;
        Get.snackbar(
          StringConstants.error,
          StringConstants.failedToSubmitInvestment,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } finally {
        isLoading.value = false;
      }
    }else{

    }
  }

  String formatDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('HH:mm:ss');
    return formatter.format(dateTime);
  }

  void selectDate(
      BuildContext context, TextEditingController startOfPeriodController) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    ).then((value) {
      if (value != null) {
        startOfPeriodController.text = value.toString();
      }
    });
  }
}
