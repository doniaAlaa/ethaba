import 'dart:convert';

import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/core/constants/app_urls.dart';
import 'package:ethabah/data/remote/invesment_fund.dart';
import 'package:ethabah/data/shared/user_pref.dart';
import 'package:ethabah/models/all_investment_fund_model.dart';
import 'package:ethabah/models/req_investment_fund_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as httpp;

class InvHomeScreenController extends GetxController {

  final RxString allReceived = '0'.obs;
  final RxString allPaid = '0'.obs;
  final RxString totalProfit = '0'.obs;
  final RxString numOfBoxes = '0'.obs;


  //  Future<AllInvestmentFundsResponse> getRequestedInvestmentFund() async {
  //   try {
  //     String? token = await SharedPref.getToken();
  //     final response = await httpp.get(Uri.parse(MY_INVESTS),
  //         headers: {"Authorization": "Bearer $token"});
  //     // log('response: ${response.body}');
  //     if (response.statusCode == 200) {
  //       print('222${response.body}');
  //
  //       RequestInvestmentFundsResponse hh = RequestInvestmentFundsResponse.fromJson(jsonDecode(response.body));
  //       print('77777777777777777777${hh.data.first.amount}');
  //
  //       return AllInvestmentFundsResponse.fromJson(jsonDecode(response.body));
  //     } else {
  //       throw Exception("$StringConstants.failedToLoadinvestmentFund");
  //     }
  //   } catch (e) {
  //     print(e);
  //     throw Exception("$StringConstants.failedToLoadinvestmentFund");
  //   }
  // }
  //

  Future<RequestInvestmentFundsResponse> getRequestedInvestmentFund() async {
    try {
      String? token = await SharedPref.getToken();
      final response = await httpp.get(Uri.parse(MY_INVESTS),
          headers: {"Authorization": "Bearer $token"});
      // log('response: ${response.body}');
      if (response.statusCode == 200) {

        RequestInvestmentFundsResponse data = RequestInvestmentFundsResponse.fromJson(jsonDecode(response.body));
        allReceived.value = data.total!.all_recieved.toDouble().toStringAsFixed(2).toString();
        allPaid.value = data.total!.all_paid.toDouble().toStringAsFixed(2).toString();
        totalProfit.value = data.total!.total_profit.toDouble().toStringAsFixed(2).toString();
        numOfBoxes.value = data.data.length.toString();
        // print('boxhh${numOfBoxes.value}');
        // print('box${data.data.length.toString()}');
        return RequestInvestmentFundsResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("$StringConstants.failedToLoadinvestmentFund");
      }
    } catch (e) {
      print(e);
      throw Exception("$StringConstants.failedToLoadinvestmentFund");
    }
  }

}
