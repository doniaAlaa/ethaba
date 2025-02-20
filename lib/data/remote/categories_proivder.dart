import 'package:ethabah/core/constants/app_urls.dart';
import 'package:ethabah/data/shared/user_pref.dart';
import 'package:ethabah/models/categories_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoriesProivder {
  static Future<List<CategoryModel>> loadCategories() async {
    try {
      String? token = await SharedPref.getToken();
      if (token == null) {
        throw Exception('Unauthorized');
      }
      final response = await http.get(Uri.parse(GET_CATEGORIES), headers: {});
      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        return CategoryModelResponse.fromJson(responseData).data;
      } else {
        throw Exception(responseData['message']);
      }
    } catch (error) {
      throw Exception('Something went wrong');
    }
  }
}
