import 'dart:developer';
import 'dart:io';
import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/core/constants/app_urls.dart';
import 'package:ethabah/data/shared/user_pref.dart';
import 'package:ethabah/models/investment_company_model.dart';
import 'package:ethabah/models/investment_fund_update_model.dart';
import 'package:ethabah/models/project_doc.dart';
import 'package:ethabah/models/request_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RequestProvider {
  static Future<RequestModel?> getRequests() async {
    try {
      final String? token = await SharedPref.getToken();
      // var token = "5|lFDEyyoUCcfke9NC94cRZn136BcUlSGnAobuyt721925a3f5";

      final response = await http.get(Uri.parse(GET_REQUESTS), headers: {
        'Authorization': 'Bearer $token',
      });
      log(response.body);
      if (response.statusCode == 200) {
        // final resData = json.decode(response.body);
        // final data = resData['data'] as List;
        // return data.map((e) => RequestModel.fromJson(e)).toList();
        return  RequestModel.fromJson(json.decode(response.body));
      }
      if (response.statusCode == 404) {
        return null;
      }
      throw Exception(StringConstants.somethingWentWrong);
    } catch (e) {
      log(e.toString());
      throw Exception(StringConstants.somethingWentWrong);
    }
  }


  static Future<List<InvestmentFundCompany>?> getCompanyFunds() async {
    try {
      final String? token = await SharedPref.getToken();

      final response = await http.get(Uri.parse(GET_COMPANY_BOXES), headers: {
        'Authorization': 'Bearer $token',
      });
      log(response.body);
      if (response.statusCode == 200) {
        final resData = json.decode(response.body);
        final data = resData['data'] as List;
        return data.map((e) => InvestmentFundCompany.fromJson(e)).toList();
      }
      if (response.statusCode == 404) {
        return null;
      }
      throw Exception(StringConstants.somethingWentWrong);
    } catch (e) {
      log(e.toString());
      throw Exception(StringConstants.somethingWentWrong);
    }
  }

  static Future postRequest(
      String name,
      String category,
      String purpose_of_funding,
      String total_funds,
      String description,
      List<File> documents,
      List<String> documentsNames,
      File? requestDocument
  ) async {
    try {
      // log('Posting request');
      log('Name: ${requestDocument?.path.split('/').last}');

      final String? token = await SharedPref.getToken();
      var request = http.MultipartRequest('POST', Uri.parse(SUBMIT_REQUEST));

      request.fields['name'] = name;
      request.fields['category_id'] = category;
      request.fields['purpose_of_funding'] = purpose_of_funding;
      request.fields['total_funds'] = total_funds;
      request.fields['description'] = description;

      // if (requestDocument != null) {
      //   request.files.add(
      //     await http.MultipartFile.fromPath(
      //       'request_document',
      //       requestDocument.path,
      //       filename: requestDocument.path.split('/').last
      //     ),
      //   );
      //   // await http.MultipartFile.fromString(
      //   //     'document_names',
      //   //      requestDocument.path.split('/').last,
      //   //
      //   // );
      // }

      if (documents != null) {

        // documents.forEach((e) async{
        //   request.files.add(
        //       await http.MultipartFile.fromPath(
        //       'request_document[]',
        //       e.path,
        //       filename: e.path.split('/').last
        //   ),
        //   );
        // });
        for (File e in documents) {
          request.files.add(
            await http.MultipartFile.fromPath(
                'request_document[]',
                e.path,
                filename: e.path.split('/').last
            ),
          );
        }
      }

      for (String item in documentsNames) {
        request.files
            .add(http.MultipartFile.fromString('document_names[]', item));
      }

      request.headers['Authorization'] = 'Bearer $token';
      final response = await request.send();
      var responseData = await http.Response.fromStream(response);
      var responseBody = json.decode(responseData.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        print('////${json.decode(responseData.body)}');

        return json.decode(responseData.body);
      }else{
        throw Exception(StringConstants.somethingWentWrong);

      }
    } catch (e) {
      print('rrrrrrrrrrrrr$e');
      throw Exception(StringConstants.somethingWentWrong);
    }
  }

  // static Future<List<ProjectDocument>?> getProjects() async {
  //   try {
  //     final String? token = await SharedPref.getToken();
  //     final response = await http.get(Uri.parse(GET_UPDATE), headers: {
  //       'Authorization': 'Bearer $token',
  //     });
  //     log(response.body);
  //     if (response.statusCode == 200) {
  //       final resData = json.decode(response.body);
  //       final data = resData['data'] as List;
  //       return data.map((e) => ProjectDocument.fromJson(e)).toList();
  //     }
  //     if (response.statusCode == 404) {
  //       return null;
  //     }
  //     throw Exception(StringConstants.somethingWentWrong);
  //   } catch (e) {
  //     log(e.toString());
  //     throw Exception(StringConstants.somethingWentWrong);
  //   }
  // }

  static Future<bool> postProjectUpdate(
      String update_name, int project_id, File document) async {
    try {
      final String? token = await SharedPref.getToken();
      var request = http.MultipartRequest('POST', Uri.parse(UPDATE_DOC));

      request.fields['update_name'] = update_name;
      request.fields['request_id'] = project_id.toString();
      request.files.add(
        await http.MultipartFile.fromPath(
          'document',
          document.path,
        ),
      );
      request.headers['Authorization'] = 'Bearer $token';
      final response = await request.send();
      log(response.statusCode.toString());

      if (response.statusCode == 201) {
        return true;
      }
      throw Exception(StringConstants.somethingWentWrong);
    } catch (e) {
      log(e.toString());
      throw Exception(StringConstants.somethingWentWrong);
    }
  }

  static Future<dynamic> postInvestment(
      String amount, String investmentFund, String timeOfInvestment) async {
    final userId = await SharedPref.getUser();
    final String? token = await SharedPref.getToken();
    final url = Uri.parse(POST_INVESTMENT);
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'user_id': userId!.id,
        "investor_funds_id": investmentFund,
        'amount': amount,
        //'end_of_period': endOfPeriod,
        'time_of_investment': 1,
        //'start_of_period': startOfPeriod,
      }),
    );
    log(response.body);
    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to submit investment');
    }
  }

  static Future<InvestmentFundsAndProjectsUpdateResponse>?
      getInvestorUpdate() async {
    try {
      String? token = await SharedPref.getToken();
      final response = await http.get(Uri.parse(GET_INVESTOR_UPDATE),
          headers: {"Authorization": "Bearer $token"});
      log('response: ${response.body}');
      if (response.statusCode == 200) {
        final resData = json.decode(response.body);
        return InvestmentFundsAndProjectsUpdateResponse.fromJson(resData);
      } else {
        throw Exception("$StringConstants.failedToLoadinvestmentFund");
      }
    } catch (e) {
      log(e.toString());
      throw Exception(StringConstants.somethingWentWrong);
    }
  }
}
