import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/core/constants/app_urls.dart';
import 'package:ethabah/data/shared/user_pref.dart';
import 'package:ethabah/models/admin_bank_data_model.dart';
import 'package:ethabah/models/all_investment_fund_model.dart';
import 'package:ethabah/models/investment_dropdown_model.dart';
import 'package:ethabah/models/req_investment_fund_model.dart';
import 'package:ethabah/models/wallet_transactions_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WalletTransactionsDataProvider {
  static Future<WalletTransactionsModel>
  getWalletTransactionData() async {

    String? token = await SharedPref.getToken();

    final response = await http.get(Uri.parse(GET_PREVIOU_TRANSACTIONS),
        headers: {"Authorization": "Bearer $token"});
    final responseData = json.decode(response.body);

    if (response.statusCode == 200) {
        WalletTransactionsModel u = WalletTransactionsModel.fromJson(responseData);
        print(responseData);



      return WalletTransactionsModel.fromJson(jsonDecode(response.body));
    } else {

      throw Exception("${StringConstants.failedToLoadData}");
    }


  }


  static addBankAccount(data) async {

    String? token = await SharedPref.getToken();

    final response = await http.post(Uri.parse(ADD_BANK_ACCOUNT),

        body: data
        ,
        headers: {"Authorization": "Bearer $token"});
    Dio dio = new Dio();

    // final formData = FormData.fromMap(data);
    // final response = await dio.post('https://admin.ethabah.com/api/investor/bank_account/update', data: formData,
    // options: Options(
    //   headers: {"Authorization": "Bearer $token", 'Accept': 'application/json',
    //     'Content-Type': 'application/json',},
    //
    //  )
    // );
       print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
        return response.statusCode;
    } else {

      throw Exception("${StringConstants.failedToLoadData}");
    }


  }


}
