import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/data/remote/admin_bank_account_provider.dart';

import 'package:ethabah/data/remote/wallet_transactions_data_provider.dart';
import 'package:ethabah/models/admin_bank_data_model.dart';

import 'package:ethabah/models/wallet_transactions_model.dart';
import 'package:ethabah/presentation/screens/investor_flow/inv_dashboard/inv_dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBankAccountController extends GetxController {
  TextEditingController accountName = TextEditingController();
  TextEditingController accountNum = TextEditingController();
  TextEditingController iban = TextEditingController();
  RxBool isLoading = false.obs;
  RxString error1 = ''.obs;
  RxString error2 = ''.obs;
  RxString error3 = ''.obs;

  Future<AdminBankDataModel> getAdminBankData() async {
    final result = await AdminBankAccountProvider.getAdminBankAccount();
    return result;
  }

  Future<WalletTransactionsModel> getWalletTransactionData() async {
    final result = await WalletTransactionsDataProvider.getWalletTransactionData();
    return result;
  }

  addBankAccount(BuildContext context) async {
    if (validateForm()){
      print(accountNum.text);
      print('SA${iban.text}');
      isLoading.value = true;
      Map<String, dynamic> data = {
        "account_name":accountName.text,
        "account_number":accountNum.text,
        "iban_number":'SA${iban.text}',
      };
      try{
        final status = await WalletTransactionsDataProvider.addBankAccount(data);
        if(status == 200 || status == 201){
          Get.snackbar(
            snackPosition: SnackPosition.TOP,
            StringConstants.done,
            'تم تسجيل البيانات البنكية بنجاح',

            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          // this.dispose();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const InvDashboardScreen()),
          );
          isLoading.value = false;

        }else{
          Get.snackbar(
            snackPosition: SnackPosition.TOP,
            margin: const EdgeInsets.all(10),
            StringConstants.error,
            StringConstants.invalidCredentials,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          isLoading.value = false;

        }
      }catch(e){
        isLoading.value = false;

        print(e);
      }

    }

  }

  bool validateShortDescription() {
    if (accountName.text.isEmpty) {
      error1.value = StringConstants.thisFieldIsRequired;
      return false;
    }
    error1.value = '';
    return true;
  }
  bool validateShortDescription2() {
    if (accountNum.text.isEmpty) {
      error2.value = StringConstants.thisFieldIsRequired;
      return false;
    }if (accountNum.text.length < 10) {
      error2.value = 'لا ينبغي أن تقل عدد الأرقام عن ١٠ أرقام';
      return false;
    }
    error2.value = '';
    return true;
  }
  bool validateShortDescription3() {
    if (iban.text.isEmpty) {
      error3.value = StringConstants.thisFieldIsRequired;
      return false;
    }if (iban.text.length < 22) {
      error3.value = 'لا ينبغي أن تقل عدد الأرقام عن ٢٢ رقم';
      return false;
    }
    error3.value = '';
    return true;
  }

  bool validateForm() {

    bool account1 = validateShortDescription();
    bool account2 = validateShortDescription2();
    bool account3 = validateShortDescription3();


    return account1  && account2 && account3;
  }

}
