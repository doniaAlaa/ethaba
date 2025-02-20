import 'dart:convert';

import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/core/constants/app_theme.dart';
import 'package:ethabah/core/constants/app_urls.dart';
import 'package:ethabah/data/remote/admin_bank_account_provider.dart';
import 'package:ethabah/data/remote/comapny_stats_provider.dart';
import 'package:ethabah/data/remote/request_provider.dart';
import 'package:ethabah/data/remote/wallet_transactions_data_provider.dart';
import 'package:ethabah/data/shared/user_pref.dart';
import 'package:ethabah/models/User_model.dart';
import 'package:ethabah/models/admin_bank_data_model.dart';
import 'package:ethabah/models/company_stats_model.dart';
import 'package:ethabah/models/investor_model.dart';
import 'package:ethabah/models/project_model.dart';
import 'package:ethabah/models/request_model.dart';
import 'package:ethabah/models/wallet_transactions_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class WalletController extends GetxController {

  RxString allInvestAmount = '0'.obs;
  RxString allBackAmount = '0'.obs;
  RxInt appearButton = (-1).obs;
  RxBool isDataLoading = false.obs;
  BankData? myData;


  Future<AdminBankDataModel> getAdminBankData() async {
    final result = await AdminBankAccountProvider.getAdminBankAccount();
    return result;
  }

  Future<WalletTransactionsModel> getWalletTransactionData() async {
    final result = await WalletTransactionsDataProvider.getWalletTransactionData();
    allInvestAmount.value = '${result.total?.first.all_paid}'+' '+'ر.س';
    allBackAmount.value = '${result.total?.first.all_recieved}'+' '+'ر.س';

    return result;
  }

  // Future<AdminBankDataModel> getMyBankData() async {
  //   final result = await WalletTransactionsDataProvider.getWalletTransactionData();
  //   return result;
  // }

  Future<BankData?> loadUserProfile() async {
    isDataLoading.value = true;
    String? token = await SharedPref.getToken();

    try{
      final response =
      await http.get(Uri.parse(GET_INVESTOR_EDIT_DETAILS), headers: {
        "Authorization": "Bearer $token",
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        print(data.toString());
        User userModel = User.fromJson(data['data']);
        // nameController.text = userModel.name ?? "";
        // emailController.text = userModel.email ?? "";
        // nationalIDController.text = userModel.nationalId??'';
        // profile_img = userModel.profile_img??'';
        appearButton.value = userModel.bank_account == null ? 1 :2;
        myData = userModel.bank_account;
        return userModel.bank_account;
        // print(data);
      }
    }catch(e){
      throw e;
    }


    isDataLoading.value = false;
  }

}
