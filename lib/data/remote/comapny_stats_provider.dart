import 'package:ethabah/core/constants/app_urls.dart';
import 'package:ethabah/data/shared/user_pref.dart';
import 'package:ethabah/models/company_stats_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CompanyStatsProvider {
  static Future<CompanyStatsModel> getCompanyStats() async {
    String? token = await SharedPref.getToken();

    final response = await http.get(
        Uri.parse(
          COMPANY_STATS,
        ),
        headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      return CompanyStatsModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load company stats');
    }
  }
}
