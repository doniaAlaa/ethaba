
import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/core/constants/app_urls.dart';
import 'package:ethabah/data/shared/user_pref.dart';
import 'package:ethabah/models/admin_bank_data_model.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class AdminBankAccountProvider {
   static
   Future<AdminBankDataModel>
   getAdminBankAccount() async {

      String? token = await SharedPref.getToken();
      final response = await http.get(Uri.parse(GET_ADMIN_BANK_ACCOUNT),
          headers: {"Authorization": "Bearer $token"});
      if (response.statusCode == 200) {
         print('${response.body}');
        return AdminBankDataModel.fromJson(jsonDecode(response.body));
      } else {

        throw Exception("${StringConstants.failedToLoadData}");
      }


  }


}
