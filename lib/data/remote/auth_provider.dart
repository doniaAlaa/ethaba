// ignore_for_file: non_constant_identifier_names

import 'dart:developer';
import 'dart:io';

import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/core/constants/app_urls.dart';
import 'package:ethabah/data/shared/user_pref.dart';
import 'package:ethabah/models/User_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthProvider {
  static Future<Map<bool, String>> registerInvestor(
      String name,
      String national_id,

      String email,
      // String password,
      // String passwordConfirmation,
      // List<File> passport,
      // List<File> national_id,
      String phone,
      String address,
      File? profileImg,
      ) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(REGISTER_API));
      request.fields['name'] = name;
      request.fields['email'] = email;
      // request.fields['password'] = password;
      // request.fields['password_confirmation'] = passwordConfirmation;
      request.fields['address'] = address;
      request.fields['phone'] = phone;
      request.fields['national_id'] = national_id;
      if(profileImg != null){
        request.files.add(http.MultipartFile.fromBytes(
            'profile_img', profileImg.readAsBytesSync(),
            filename: profileImg.path.split('/').last));
      }


      // for (var i = 0; i < passport.length; i++) {
      //   request.files.add(http.MultipartFile.fromBytes(
      //       'passport', passport[i].readAsBytesSync(),
      //       filename: passport[i].path.split('/').last));
      // }
      // for (var i = 0; i < national_id.length; i++) {
      //   request.files.add(http.MultipartFile.fromBytes(
      //       'national_id', national_id[i].readAsBytesSync(),
      //       filename: national_id[i].path.split('/').last));
      // }

      var response = await request.send();
      var responseData = await http.Response.fromStream(response);
      var responseBody = json.decode(responseData.body);
      print('eeeeee${responseData.body}');

      if (responseData.statusCode == 201) {
        return {true: responseBody['message']};
      } else if (responseData.statusCode == 422) {
        String errorMessage = responseBody['message'];
        responseBody['errors'].forEach((key, value) {
          errorMessage += "\n${value[0]}";
        });
        return {false: errorMessage};
      } else {
        return {false: responseBody['message']};
      }
    } catch (error) {
      return {false: StringConstants.somethingWentWrong};
    }
  }

  static Future<Map<String, dynamic>> login(
      // String email, String password,
      String phone) async {
    try {
      final response = await http.post(Uri.parse(
          LOGGED_IN_USER_TOKEN
      ), body: {
        // "email": email,
        // "password": password,
        "phone":phone
      });
      print(response.body);
      final responseData = json.decode(response.body);
      //log(responseData.toString(), name: 'login');
      if (response.statusCode == 200) {
        User user = User.fromJson(responseData['user']);
        String token = responseData['token'];
        //save token and user info if user approved
        if(responseData['user']['status'] != '0' ){
          SharedPref.saveUser(user, token);

        }

        return {
          "success": true,
          "role": user.role,
          "user":user
        };
      } else {
        return {
          "success": false,
          "message": responseData['message'],
        };
      }
    } catch (error) {
      print(error);
      throw Exception(StringConstants.somethingWentWrong);
    }
  }


  static Future<Map<String, dynamic>> loginWithPhone(
      String phone) async {
    // try {
      final response = await http.post(Uri.parse(
          LOGIN_PHONE_API,

      ), body: {
        "phone": '${phone.replaceAll(' ', '')}',
      });
      final responseData = json.decode(response.body);
      //log(responseData.toString(), name: 'login');
      print(response.body);
      if (response.statusCode == 200) {
        // User user = User.fromJson(responseData['user']);
        // String token = responseData['token'];
        // //save token and user info
        // SharedPref.saveUser(user, token);
        // return {
        //   "success": true,
        //   "role": user.role,
        // };
        return responseData;
      } else {
        // return {
        //   "success": false,
        //   "message": responseData['message'],
        // };
        return responseData;

      }
    // } catch (error) {
    //   print(error);
    //   throw Exception(StringConstants.somethingWentWrong);
    // }
  }

  static Future<Map<bool, String>> companyRegister(
      String name,
      String email,
      String phone,
      String password,
      String registerNum,
      List<File> registerCertificate,
      // List<File> commercialCertificate,
      List<File>? licenses,
      String address) async {
    try {
      var request =
          http.MultipartRequest('POST', Uri.parse(COMPANY_REGISTER_API));
      request.fields['name'] = name;
      request.fields['email'] = email;
      request.fields['phone'] = phone;
      request.fields['address'] = address;
      request.fields['password'] = password;
      request.fields['register_num'] = registerNum;

      for (var i = 0; i < registerCertificate.length; i++) {
        request.files.add(http.MultipartFile.fromBytes(
            'commercial_certificate', registerCertificate[i].readAsBytesSync(),
            filename: registerCertificate[i].path.split('/').last));
      }
      // for (var i = 0; i < commercialCertificate.length; i++) {
      //   request.files.add(http.MultipartFile.fromBytes('commercial_certificate',
      //       commercialCertificate[i].readAsBytesSync(),
      //       filename: commercialCertificate[i].path.split('/').last));
      // }
      if (licenses != null) {
        for (var i = 0; i < licenses.length; i++) {
          request.files.add(http.MultipartFile.fromBytes(
              'licenses', licenses[i].readAsBytesSync(),
              filename: licenses[i].path.split('/').last));
        }
      }

      var response = await request.send();
      var responseData = await http.Response.fromStream(response);
      var responseBody = json.decode(responseData.body);
      log(responseData.body, name: 'companyRegister');
      print(responseData.body);
      if (responseData.statusCode == 201) {
        log('201', name: 'companyRegister');
        return {true: responseBody['message']};
      } else if (responseData.statusCode == 422) {
        log('422', name: 'companyRegister');
        String errorMessage = responseBody['message'];
        responseBody['errors'].forEach((key, value) {
          errorMessage += "\n${value[0]}";
        });
        return {false: errorMessage};
      } else {
        return {false: responseBody['message']};
      }
    } catch (error) {
      log('error', name: 'companyRegister');
      return {false: StringConstants.somethingWentWrong};
    }
  }

  //update Investor
  static Future<Map<bool, String>> updateInvestor(
      String name,
      String email,
      String? password,
      String? passwordConfirmation,
      // List<File>? passport,
      // List<File>? national_id,
      String national_id,
      String address,
      String phone,
      File? profileImg

      ) async {
    String? token = await SharedPref.getToken();
    try {
      var request =
          http.MultipartRequest('POST', Uri.parse(POST_INVESTOR_EDIT_DETAILS));
      request.fields['name'] = name;
      request.fields['email'] = email;
      if (password != null) {
        request.fields['password'] = password;
        request.fields['password_confirmation'] = passwordConfirmation!;
      }
      request.fields['national_id'] = national_id;

      request.fields['address'] = address;
      request.fields['phone'] = phone;
      if(profileImg != null){
        request.files.add(http.MultipartFile.fromBytes(
            'profile_img', profileImg.readAsBytesSync(),
            filename: profileImg.path.split('/').last));
      }
      // if (passport != null) {
      //   for (var i = 0; i < passport.length; i++) {
      //     request.files.add(http.MultipartFile.fromBytes(
      //         'passport', passport[i].readAsBytesSync(),
      //         filename: passport[i].path.split('/').last));
      //   }
      // }
      //
      // if (national_id != null) {
      //   for (var i = 0; i < national_id.length; i++) {
      //     request.files.add(http.MultipartFile.fromBytes(
      //         'national_id', national_id[i].readAsBytesSync(),
      //         filename: national_id[i].path.split('/').last));
      //   }
      // }
      request.headers['Authorization'] = 'Bearer $token';

      var response = await request.send();
      var responseData = await http.Response.fromStream(response);
      var responseBody = json.decode(responseData.body);
      log(responseData.body, name: 'updateInvestor');
      log(response.statusCode.toString(), name: 'updateInvestor');
      if (response.statusCode == 200 || response.statusCode == 201) {
        User user = User.fromJson(responseBody['user']);
        print('mmmmmmmmm${user.name}');

        String? token = await SharedPref.getToken();
        //save token and user info if user approved
          SharedPref.saveUser(user, token!);
        return {
          // true: responseBody['message']
             true: "تم تعديل البيانات بنجاح"
        };

      } else if (responseData.statusCode == 422) {
        String errorMessage = responseBody['message'];
        responseBody['errors'].forEach((key, value) {
          errorMessage += "\n${value[0]}";
        });
        return {false: errorMessage};
      } else {
        return {false: responseBody['message']};
      }
    } catch (error) {
      return {false: StringConstants.somethingWentWrong};
    }
  }

  static Future<Map<bool, String>> updateCompanyDetails(
    String name,
    String phone,
    String email,
    String address,
    String register_num,
    // List<File>? registerCertificate,
    List<File>? commercialCertificate,
    List<File>? licenses,
    String? password,
  ) async {
    try {


      String? token = await SharedPref.getToken();

      var request =
          http.MultipartRequest('POST', Uri.parse(POST_COMPANY_EDIT_DETAILS));
      request.fields['name'] = name;
      request.fields['email'] = email;
      request.fields['phone'] = phone;
      request.fields['address'] = address;
      request.fields['register_num'] = register_num;
      if (password != null) {
        request.fields['password'] = password;
      }
      // if (registerCertificate != null) {
      //   for (var i = 0; i < registerCertificate.length; i++) {
      //     request.files.add(http.MultipartFile.fromBytes(
      //         'register_certificate', registerCertificate[i].readAsBytesSync(),
      //         filename: registerCertificate[i].path.split('/').last));
      //   }
      // }

      if (commercialCertificate != null) {
        for (var i = 0; i < commercialCertificate.length; i++) {
          request.files.add(http.MultipartFile.fromBytes(
              'commercial_certificate',
              commercialCertificate[i].readAsBytesSync(),
              filename: commercialCertificate[i].path.split('/').last));
        }
      }
      if (licenses != null) {
        for (var i = 0; i < licenses.length; i++) {
          request.files.add(http.MultipartFile.fromBytes(
              'licenses', licenses[i].readAsBytesSync(),
              filename: licenses[i].path.split('/').last));
        }
      }
      request.headers['Authorization'] = 'Bearer $token';
      var response = await request.send();
      var responseData = await http.Response.fromStream(response);
      var responseBody = json.decode(responseData.body);
      log(response.statusCode.toString(), name: 'updateCompanyDetails');
      log(responseData.body, name: 'updateCompanyDetails');
      if (response.statusCode == 200) {
        String? token = await SharedPref.getToken();
        User? temp = await SharedPref.getUser();
        int role = temp!.role;
        if (token != null) {
          final User user = User(
              id: responseBody['company']['id'],
              name: responseBody['company']['name'],
              email: responseBody['company']['email'],
              createdAt: temp.createdAt,
              updatedAt: temp.updatedAt,
              role: role,
              status: responseBody['company']['status']);
          SharedPref.saveUser(user, token);
        }
        return {true: responseBody['message']};
      } else if (responseData.statusCode == 422) {
        String errorMessage = responseBody['message'];
        responseBody['errors'].forEach((key, value) {
          errorMessage += "\n${value[0]}";
        });
        return {false: errorMessage};
      } else {
        return {false: responseBody['message']};
      }
    } catch (error) {
      log(error.toString(), name: 'updateCompanyDetails');
      return {false: StringConstants.somethingWentWrong};
    }
  }
}
