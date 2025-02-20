import 'dart:developer';

import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/core/constants/app_urls.dart';
import 'package:ethabah/data/shared/user_pref.dart';
import 'package:ethabah/models/admin_bank_data_model.dart';
import 'package:ethabah/models/all_investment_fund_model.dart';
import 'package:ethabah/models/investment_dropdown_model.dart';
import 'package:ethabah/models/project_doc.dart';
import 'package:ethabah/models/req_investment_fund_model.dart';
import 'package:ethabah/models/terms_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TermsConditionProvider {
   static Future<TermsPrivacyModel> getTerms() async {

      String? token = await SharedPref.getToken();
      final response = await http.get(Uri.parse(TERM),
          headers: {"Authorization": "Bearer $token"});
      if (response.statusCode == 200) {
         print('${response.body}');
         return TermsPrivacyModel.fromJson(jsonDecode(response.body));
      } else {

     throw Exception("${StringConstants.failedToLoadData}");
      }


  }


}
