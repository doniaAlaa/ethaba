import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/core/constants/app_urls.dart';
import 'package:ethabah/data/shared/user_pref.dart';
import 'package:ethabah/models/all_investment_fund_model.dart';
import 'package:ethabah/models/investment_dropdown_model.dart';
import 'package:ethabah/models/req_investment_fund_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';


class InvestmentFundProvider {
  static Future<InvestmentDropdownResponse> getInvestmentFundDropdown() async {
    String? token = await SharedPref.getToken();
    final response = await http.get(Uri.parse(GET_INVESTMENT_FUND_NAME),
        headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      return InvestmentDropdownResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("$StringConstants.failedToLoadinvestmentFund");
    }
  }

  static Future<RequestInvestmentFundsResponse>
      getRequestedInvestmentFund() async {
    try {
      String? token = await SharedPref.getToken();
      final response = await http.get(Uri.parse(GET_REQ_INVESTMENTS_FUND),
          headers: {"Authorization": "Bearer $token"});
      // log('response: ${response.body}');
      if (response.statusCode == 200) {
        return RequestInvestmentFundsResponse.fromJson(
            jsonDecode(response.body));
      } else {
        throw Exception("$StringConstants.failedToLoadinvestmentFund");
      }
    } catch (e) {
      log('error: $e');
      throw Exception("$StringConstants.failedToLoadinvestmentFund");
    }
  }

  static Future<AllInvestmentFundsResponse> getAllInvestmentFunds() async {
    try {
      String? token = await SharedPref.getToken();
      final response = await http.get(Uri.parse(GET_ALL_INVESTMENTS_FUND),
      //     final response = await http.get(Uri.parse('https://admin.ethabah.com/api/investor/invest/data/get'),


          headers: {"Authorization": "Bearer $token"});
      log('response: ${response.body}');
      if (response.statusCode == 200) {
        // print(jsonDecode(response.body)['data'][0]['investment_fund']['amount_received'].runtimeType);
        AllInvestmentFundsResponse uu = AllInvestmentFundsResponse.fromJson(jsonDecode(response.body));
        return AllInvestmentFundsResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("$StringConstants.failedToLoadinvestmentFund");
      }
    } catch (e) {
      log('error: $e');
      throw Exception("$StringConstants.failedToLoadinvestmentFund");
    }
  }

  static Future<Map> dashboardIInvestmentStats() async {
    try {
      String? token = await SharedPref.getToken();
      final response = await http.get(Uri.parse(GET_DASHBOARD_INVESTMENT_STATS),
          headers: {"Authorization": "Bearer $token"});
      log('response: ${response.body}');
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception("$StringConstants.failedToLoadinvestmentFund");
      }
    } catch (e) {
      log('error: $e');
      throw Exception("$StringConstants.failedToLoadinvestmentFund");
    }
  }

  static  sendInvestReq(
      String amount,
      String investor_funds_id,
      XFile? requestDocument) async {
    // try {




      final String? token = await SharedPref.getToken();
       Dio dio = Dio();

      var formData = FormData.fromMap({

         "amount": amount,
        "investor_funds_id": investor_funds_id,
        'payment_img': requestDocument != null?
          await MultipartFile.fromFile(requestDocument.path, filename: requestDocument.path.split('/').last,
            // contentType: new MediaType("image", "jpeg","png"),
          ):null,

      });
      // try{
        var response = await dio.post(INVESTOR_REQUEST, data: formData,
            options: Options(
              headers: {"Authorization": "Bearer $token",
                // 'Accept': 'multipart/form-data',
                'Content-Type':'application/json'
              },

            )
        );
        return response.data;
      // }catch(e){
      //   print('eeeeeeee${}');
      // }




  }

  static  ss(
      String amount,
      String investor_funds_id,
      File? requestDocument) async {
    // try {
    // log('Posting request');
    // log('Name: $name');
    // log('Category: $category');
    // log('Purpose of funding: $purpose_of_funding');
    // log('Total funds: $total_funds');
    // log('Description: $description');
    // log('Request document: $requestDocument');

    print('----------${requestDocument?.path}');

    final String? token = await SharedPref.getToken();
    Dio dio = Dio();

    var formData = FormData.fromMap({

      "amount": "200",
      "investor_funds_id": "1",
      'payment_img': requestDocument != null?
      await MultipartFile.fromFile(requestDocument.path, filename: requestDocument.path.split('/').last,
        contentType: new MediaType("image", "jpeg"),
      ):null,

    });
    try{
      var response = await dio.post(INVESTOR_REQUEST, data: formData,
          options: Options(
            headers: {"Authorization": "Bearer $token",
              // 'Accept': 'multipart/form-data',
              'Content-Type':'application/json'
            },

          )
      );
      print(response.statusCode);

      if (response.statusCode == 201) {

      }
    }catch(e){
      print(e);
    }




  }
}
