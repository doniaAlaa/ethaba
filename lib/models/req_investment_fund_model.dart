import 'dart:convert';

import 'package:ethabah/models/all_investment_fund_model.dart';

class RequestInvestmentFundsResponse {
  final bool success;
  final String message;
  final TotalFundData? total;
  final List<RequestInvestmentFund> data;

  RequestInvestmentFundsResponse({
    required this.success,
    required this.message,
    required this.data,
    this.total
  });

  factory RequestInvestmentFundsResponse.fromJson(Map<String, dynamic> json) {
    return RequestInvestmentFundsResponse(
      success: json['success'],
      message: json['message'],
      data: (json['data'] as List)
          .map((i) => RequestInvestmentFund.fromJson(i))
          .toList(),
      total: TotalFundData.fromJson(json['total']),

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.map((i) => i.toJson()).toList(),
      'total':total?.toJson()
    };
  }
}

class RequestInvestmentFund {
  final int id;
  final int userId;
  final int investorFundsId;
  final String amount;
  // final double progressPercentage;

  final int? timeOfInvestment;
  // final DateTime? startOfPeriod;
  // final DateTime? endOfPeriod;
  final String? startOfPeriod;
  final String? endOfPeriod;
  final String? status;
  // final DateTime createdAt;
  // final DateTime updatedAt;

  final String? createdAt;
  final String? updatedAt;
  // final double amountSum;
  // final double amountReceived;
  final InvestmentFund investmentFund;

  RequestInvestmentFund({
    required this.id,
    required this.userId,
    required this.investorFundsId,
    required this.amount,
    // required this.progressPercentage,
    required this.timeOfInvestment,
    this.startOfPeriod,
    this.endOfPeriod,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    // required this.amountSum,
    // required this.amountReceived,
    required this.investmentFund,
  });

  factory RequestInvestmentFund.fromJson(Map<String, dynamic> json) {
    return RequestInvestmentFund(
      id: json['id'],
      userId: json['user_id'],
      investorFundsId: json['investor_funds_id'],
      amount: json['amount'],
      //progressPercentage: json["progress_percentage"].toDouble(),
      timeOfInvestment: json['time_of_investment'],
      // startOfPeriod: json['start_of_period'] != null
      //     ? DateTime.parse(json['start_of_period'])
      //     : null,
      // endOfPeriod: json['end_of_period'] != null
      //     ? DateTime.parse(json['end_of_period'])
      //     : null,
      startOfPeriod: json['start_of_period'],
      endOfPeriod: json['end_of_period'],

      status: json['status'],
      // createdAt: DateTime.parse(json['created_at']),
      // updatedAt: DateTime.parse(json['updated_at']),
      //
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],


      //amountSum: double.tryParse(json['amountSum'].toString()) ?? 0.0,
      //amountReceived:
      //   double.tryParse(json['amount_received'].toString()) ?? 0.0,
      investmentFund: InvestmentFund.fromJson(json['investment_fund']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'investor_funds_id': investorFundsId,
      'amount': amount,
      'time_of_investment': timeOfInvestment,
      // 'start_of_period': startOfPeriod?.toIso8601String(),
      // 'end_of_period': endOfPeriod?.toIso8601String(),
      'start_of_period': startOfPeriod,
      'end_of_period': endOfPeriod,
      'status': status,
      // 'created_at': createdAt.toIso8601String(),
      // 'updated_at': updatedAt.toIso8601String(),
      'created_at': createdAt,
      'updated_at': updatedAt,
      'investment_fund': investmentFund.toJson(),
    };
  }
}


class TotalFundData {
  final num all_paid;
  final num all_recieved;
  final num total_profit;


  TotalFundData({
    required this.all_paid,
    required this.all_recieved,
    required this.total_profit,

  });

  factory TotalFundData.fromJson(Map<String, dynamic> json) {
    return TotalFundData(
      all_paid: json['all_paid'],
      all_recieved: json['all_recieved'],
      total_profit: json['total_profit'],


    );
  }

  Map<String, dynamic> toJson() {
    return {
      'all_paid': all_paid,
      'all_recieved': all_recieved,
      'total_profit': total_profit,


    };
  }
}


// class InvestmentFund {
//   final int id;
//   final int userId;
//   final int categoryId;
//   final int? companyId;
//   final String name;
//   final String profit;
//   final String amount;
//   final String month;
//   final String totalFunds;
//   final String profitPercentage;
//   final String? image;
//   final String durationOfInvestment;
//   final DateTime? startOfPeriod;
//   final String? customMonths;
//   final DateTime? endOfPeriod;
//   final String status;
//   final int viewer;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final List<InvestmentFundCompany> investmentFundCompanies;
//
//   InvestmentFund({
//     required this.id,
//     required this.userId,
//     required this.categoryId,
//     this.companyId,
//     required this.name,
//     required this.profit,
//     required this.amount,
//     required this.month,
//     this.image,
//     required this.totalFunds,
//     required this.profitPercentage,
//     required this.durationOfInvestment,
//     this.startOfPeriod,
//     this.customMonths,
//     this.endOfPeriod,
//     required this.status,
//     required this.viewer,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.investmentFundCompanies,
//   });
//
//   factory InvestmentFund.fromJson(Map<String, dynamic> json) {
//     return InvestmentFund(
//       id: json['id'],
//       userId: json['user_id'],
//       categoryId: json['category_id'],
//       companyId: json['company_id'],
//       name: json['name'],
//       profit: json['profit'],
//       amount: json['amount'],
//       month: json['month'],
//       image: json['image'],
//       totalFunds: json['total_funds'],
//       customMonths: json['custom_months'],
//       profitPercentage: json['profit_percentage'],
//       durationOfInvestment: json['duration_of_investment'],
//       startOfPeriod: json['start_of_period'] != null
//           ? DateTime.parse(json['start_of_period'])
//           : null,
//       endOfPeriod: json['end_of_period'] != null
//           ? DateTime.parse(json['end_of_period'])
//           : null,
//       status: json['status'],
//       viewer: json['viewer'],
//       createdAt: DateTime.parse(json['created_at']),
//       updatedAt: DateTime.parse(json['updated_at']),
//       investmentFundCompanies: (json['investment_fund_companies'] as List)
//           .map((i) => InvestmentFundCompany.fromJson(i))
//           .toList(),
//     );
//   }
//
//   String get imageString => "https://admin.ethabah.com/investorFund/$image";
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'user_id': userId,
//       'category_id': categoryId,
//       'company_id': companyId,
//       'name': name,
//       'profit': profit,
//       'amount': amount,
//       'month': month,
//       'image': image,
//       'total_funds': totalFunds,
//       'profit_percentage': profitPercentage,
//       'duration_of_investment': durationOfInvestment,
//       'start_of_period': startOfPeriod?.toIso8601String(),
//       'custom_months': customMonths,
//       'end_of_period': endOfPeriod?.toIso8601String(),
//       'status': status,
//       'viewer': viewer,
//       'created_at': createdAt.toIso8601String(),
//       'updated_at': updatedAt.toIso8601String(),
//       'investment_fund_companies':
//           investmentFundCompanies.map((i) => i.toJson()).toList(),
//     };
//   }
// }

class InvestmentFundCompany {
  final int id;
  final int investorFundsId;
  final int companyId;
  final int requestId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Company company;

  InvestmentFundCompany({
    required this.id,
    required this.investorFundsId,
    required this.companyId,
    required this.requestId,
    this.createdAt,
    this.updatedAt,
    required this.company,
  });

  factory InvestmentFundCompany.fromJson(Map<String, dynamic> json) {
    return InvestmentFundCompany(
      id: json['id'],
      investorFundsId: json['investor_funds_id'],
      companyId: json['company_id'],
      requestId: json['request_id'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      company: Company.fromJson(json['company']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'investor_funds_id': investorFundsId,
      'company_id': companyId,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'company': company.toJson(),
    };
  }
}

class Company {
  final int id;
  final int userId;
  final String name;
  final String registerNum;
  final String phone;
  final String email;
  final String? register_num;
  final String? address;
  final String? password;
  final List<String>? registerCertificate;
  final List<String> commercialCertificate;
  final List<String>? licenses;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Company({
    required this.id,
    required this.userId,
    required this.name,
    required this.registerNum,
    required this.phone,
    required this.email,
    this.register_num,
    this.address,
    required this.password,
    required this.registerCertificate,
    required this.commercialCertificate,
    this.licenses,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  String registerCertificateBaseUrl =
      "https://admin.ethabah.com/register_certificate/";
  String commercialCertificateBaseUrl =
      "https://admin.ethabah.com/commercial_certificate/";
  String licensesBaseUrl = "https://admin.ethabah.com/licenses/";

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      registerNum: json['register_num'],
      phone: json['phone'],
      email: json['email'],
      register_num: json['register_num'],
      address: json['address'],
      password: json['password'],
      registerCertificate: json['register_certificate'] != null?
          List<String>.from(jsonDecode(json['register_certificate'])):null,
      commercialCertificate:
          List<String>.from(jsonDecode(json['commercial_certificate'])),
      licenses: json['licenses'] != null
          ? List<String>.from(jsonDecode(json['licenses']))
          : null,
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  List<String> get registerCertificateUrls =>
      registerCertificate?.map((e) => "$registerCertificateBaseUrl$e").toList() ??[];
  List<String> get commercialCertificateUrls => commercialCertificate
      .map((e) => "$commercialCertificateBaseUrl$e")
      .toList();
  List<String> get licensesUrls =>
      licenses?.map((e) => "$licensesBaseUrl$e").toList() ?? [];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'register_num': registerNum,
      'phone': phone,
      'email': email,
      'address': address,
      'password': password,
      'register_certificate': jsonEncode(registerCertificate),
      'commercial_certificate': jsonEncode(commercialCertificate),
      'licenses': jsonEncode(licenses),
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
