import 'dart:convert';

// filepath: /c:/Projects/ethabah_priv/lib/models/all_investment_fund_model.dart
class InvestmentFund {
  final int? id;
  final int? userId;
  final int? categoryId;
  final int? companyId;
  final double? progressPercentage;
  final String? name;
  final String? profit;
  final String? amount;
  final String? month;
  final String? totalFunds;
  final String? status;
  final String? image;
  final String? profitPercentage;
  final String? durationOfInvestment;
  final int? customMonths;
  final String? category_name;
  final String? startOfPeriod;

  final int? viewer;
  // final DateTime? endOfPeriod;\
  final String? endOfPeriod;

  // final DateTime createdAt;
  final String? createdAt;

  final DateTime updatedAt;
  final double? amountSum;
  // final double? amountReceived;
  // final List<InvestmentFundCompany2>? investmentFundCompanies;
  final String? min_invest_amount;
  final List<String>? documents;
  final List<String>? document_names;
  final String? amountReceived;
  final bool? invest_before;



  InvestmentFund({
    required this.id,
    required this.userId,
     this.documents,
     this.document_names,
    // this.amount_received,
    required this.categoryId,
    this.companyId,
    required this.name,
    required this.profit,
    required this.progressPercentage,
    required this.amount,
    required this.status,
    this.viewer,
    required this.month,
    this.image,
    required this.totalFunds,
    required this.profitPercentage,
    required this.durationOfInvestment,
    this.customMonths,
    this.startOfPeriod,
    this.endOfPeriod,
    required this.createdAt,
    required this.updatedAt,
    // required this.investmentFundCounts,
    required this.amountSum,
    required this.amountReceived,
    // required this.investorCounts,
    // required this.investmentFundCompanies,
    this.category_name,
    this.min_invest_amount,
    this.invest_before
  });

  factory InvestmentFund.fromJson(Map<String, dynamic> json) {
    return InvestmentFund(
      id: json['id'],
      userId: json['user_id'],
      category_name: json['category_name'],
      min_invest_amount: json['min_invest_amount'],
      // amount_received: json['amount_received'],

      categoryId: json['category_id'],
      companyId: json['company_id'],
      name: json['name'],
      progressPercentage:json["progress_percentage"] != null? json["progress_percentage"].toDouble():null,
      status: json['status'],
      profit: json['profit'],
      amount: json['amount'],
      image: json['image'],
      month: json['month'],
      viewer: json['viewer'],
      totalFunds: json['total_funds'],
      profitPercentage: json['profit_percentage'],
      durationOfInvestment: json['duration_of_investment'],
      customMonths: json['custom_months'] != null
          ? int.tryParse(json['custom_months'])
          : null,
      // startOfPeriod: json['start_of_period'] != null
      //     ? DateTime.parse(json['start_of_period'])
      //     : null,
      // endOfPeriod: json['end_of_period'] != null
      //     ? DateTime.parse(json['end_of_period'])
      //     : null,
      startOfPeriod: json['start_of_period'],
      endOfPeriod: json['end_of_period'],

      createdAt: json['created_at'],
        // createdAt: DateTime.parse(json['created_at']),

        updatedAt: DateTime.parse(json['updated_at']),
      // investmentFundCounts: json['investmentFundCounts'],
      amountSum: double.tryParse(json['amountSum'].toString()) ?? 0.0,
      // amountReceived:
      //     double.tryParse(json['amount_received'].toString()) ?? 0.0,
        amountReceived : json['amount_received'],

      // investorCounts: json['investorCounts'],
      // investmentFundCompanies: (json['investment_fund_companies'] as List)
      //     .map((i) => InvestmentFundCompany2.fromJson(i))
      //     .toList(),
      // documents: json['documents'] != null
      //     ? List<String>.from(jsonDecode(json['documents']))
      //     : null,
      // document_names: json['document_names'] != null
      //     ? List<String>.from(jsonDecode(json['document_names']))
      //     : null,
        documents : json['documents'] != null ?json['documents'].cast<String>():null,
        document_names : json['document_names'] != null ?json['document_names'].cast<String>():null,
      invest_before: json['invest_before'],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'category_id': categoryId,
      // 'amount_received': amount_received,

      'company_id': companyId,
      'name': name,
      'profit': profit,
      'amount': amount,
      'month': month,
      'total_funds': totalFunds,
      'profit_percentage': profitPercentage,
      'duration_of_investment': durationOfInvestment,
      'custom_months': customMonths,
      // 'start_of_period': startOfPeriod?.toIso8601String(),
      // 'end_of_period': endOfPeriod?.toIso8601String(),
      'created_at': createdAt,
      // 'created_at': createdAt.toIso8601String(),

      'updated_at': updatedAt.toIso8601String(),
      // 'investmentFundCounts': investmentFundCounts,
      // 'amount_received': amountReceived,
      // 'investorCounts': investorCounts,
      // 'investment_fund_companies':
      //     investmentFundCompanies?.map((i) => i.toJson()).toList(),

      'documents': documents != null ? jsonEncode(documents) : null,
      'document_names': document_names != null ? jsonEncode(document_names) : null,

    };
  }

  get imageString => "https://admin.ethabah.com/investorFund/$image";
}

class AllInvestmentFundsResponse {
  final bool success;
  final String message;
  final List<InvestmentFund> data;

  AllInvestmentFundsResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AllInvestmentFundsResponse.fromJson(Map<String, dynamic> json) {
    return AllInvestmentFundsResponse(
      success: json['success'],
      message: json['message'],
      data: (json['data'] as List)
          .map((i) => InvestmentFund.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.map((i) => i.toJson()).toList(),
    };
  }
}

class Company2 {
  final int id;
  final int userId;
  final String name;
  final String registerNum;
  final String phone;
  final String email;
  final String? address;
  final String password;
  final List<String> registerCertificate;
  final List<String> commercialCertificate;
  final List<String> licenses;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Company2({
    required this.id,
    required this.userId,
    required this.name,
    required this.registerNum,
    required this.phone,
    required this.email,
    this.address,
    required this.password,
    required this.registerCertificate,
    required this.commercialCertificate,
    required this.licenses,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Company2.fromJson(Map<String, dynamic> json) {
    return Company2(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      registerNum: json['register_num'],
      phone: json['phone'],
      email: json['email'],
      address: json['address'],
      password: json['password'],
      registerCertificate:
          List<String>.from(jsonDecode(json['register_certificate'])),
      commercialCertificate:
          List<String>.from(jsonDecode(json['commercial_certificate'])),
      licenses: List<String>.from(jsonDecode(json['licenses'])),
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  List<String> get registerCertificateUrls => registerCertificate
      .map((file) => "https://admin.ethabah.com/register_certificate/$file")
      .toList();

  List<String> get commercialCertificateUrls => commercialCertificate
      .map((file) => "https://admin.ethabah.com/commercial_certificate/$file")
      .toList();

  List<String> get licensesUrls => licenses
      .map((file) => "https://admin.ethabah.com/licenses/$file")
      .toList();

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

class InvestmentFundCompany2 {
  final int id;
  final int investorFundsId;
  final int company2Id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Company2 company2;

  InvestmentFundCompany2({
    required this.id,
    required this.investorFundsId,
    required this.company2Id,
    this.createdAt,
    this.updatedAt,
    required this.company2,
  });

  factory InvestmentFundCompany2.fromJson(Map<String, dynamic> json) {
    return InvestmentFundCompany2(
      id: json['id'],
      investorFundsId: json['investor_funds_id'],
      company2Id: json['company_id'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      company2: Company2.fromJson(json['companies']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'investor_funds_id': investorFundsId,
      'company2_id': company2Id,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'company2': company2.toJson(),
    };
  }
}
// import 'dart:convert';
// import 'dart:developer';

// // filepath: /c:/Projects/ethabah_priv/lib/models/all_investment_fund_model.dart

// class AllInvestmentFundsResponse {
//   final bool success;
//   final String message;
//   final List<InvestmentFund> data;

//   AllInvestmentFundsResponse({
//     required this.success,
//     required this.message,
//     required this.data,
//   });

//   factory AllInvestmentFundsResponse.fromJson(Map<String, dynamic> json) {
//     return AllInvestmentFundsResponse(
//       success: json['success'],
//       message: json['message'],
//       data: (json['data'] as List)
//           .map((i) => InvestmentFund.fromJson(i))
//           .toList(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'success': success,
//       'message': message,
//       'data': data.map((i) => i.toJson()).toList(),
//     };
//   }
// }

// class InvestmentFund {
//   final int id;
//   final String name;
//   final String category;
//   final String totalFunds;
//   final String amountReceived;
//   final double progressPercentage;
//   final int investorCounts;
//   final int investmentFundCounts;
//   final InvestorFund? investorFund;

//   InvestmentFund({
//     required this.id,
//     required this.name,
//     required this.category,
//     required this.totalFunds,
//     required this.amountReceived,
//     required this.progressPercentage,
//     required this.investorCounts,
//     required this.investmentFundCounts,
//     this.investorFund,
//   });

//   factory InvestmentFund.fromJson(Map<String, dynamic> json) {
//     log('json: ${json['name']}');
//     return InvestmentFund(
//       id: json['id'],
//       name: json['name'],
//       category: json['category'],
//       totalFunds: json['total_funds'].toString(),
//       amountReceived: json['amount_received'].toString(),
//       progressPercentage: json['progress_percentage'].toDouble(),
//       investorCounts: json['investor_counts'],
//       investmentFundCounts: json['investment_fund_counts'],
//       investorFund: json['investor_fund'] != null
//           ? InvestorFund.fromJson(json['investor_fund'])
//           : null,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'category': category,
//       'total_funds': totalFunds,
//       'amount_received': amountReceived,
//       'progress_percentage': progressPercentage,
//       'investor_counts': investorCounts,
//       'investment_fund_counts': investmentFundCounts,
//       'investor_fund': investorFund?.toJson(),
//     };
//   }
// }

// class InvestorFund {
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
//   final String durationOfInvestment;
//   final String? customMonths;
//   final DateTime? startOfPeriod;
//   final DateTime? endOfPeriod;
//   final String? image;
//   final int? viewer;
//   final String status;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final int investmentFundCounts;
//   final double amountSum;
//   final double amountReceived;
//   final double progressPercentage;
//   final int investorCounts;
//   final Category category;

//   InvestorFund({
//     required this.id,
//     required this.userId,
//     required this.categoryId,
//     this.companyId,
//     required this.name,
//     required this.profit,
//     required this.amount,
//     required this.month,
//     required this.totalFunds,
//     required this.profitPercentage,
//     required this.durationOfInvestment,
//     this.customMonths,
//     this.startOfPeriod,
//     this.endOfPeriod,
//     this.image,
//     this.viewer,
//     required this.status,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.investmentFundCounts,
//     required this.amountSum,
//     required this.amountReceived,
//     required this.progressPercentage,
//     required this.investorCounts,
//     required this.category,
//   });

//   factory InvestorFund.fromJson(Map<String, dynamic> json) {
//     return InvestorFund(
//       id: json['id'],
//       userId: json['user_id'],
//       categoryId: json['category_id'],
//       companyId: json['company_id'],
//       name: json['name'],
//       profit: json['profit'],
//       amount: json['amount'],
//       month: json['month'],
//       totalFunds: json['total_funds'],
//       profitPercentage: json['profit_percentage'],
//       durationOfInvestment: json['duration_of_investment'],
//       customMonths: json['custom_months'],
//       startOfPeriod: json['start_of_period'] != null
//           ? DateTime.parse(json['start_of_period'])
//           : null,
//       endOfPeriod: json['end_of_period'] != null
//           ? DateTime.parse(json['end_of_period'])
//           : null,
//       image: json['image'],
//       viewer: json['viewer'],
//       status: json['status'],
//       createdAt: DateTime.parse(json['created_at']),
//       updatedAt: DateTime.parse(json['updated_at']),
//       investmentFundCounts: json['investmentFundCounts'],
//       amountSum: double.tryParse(json['amountSum'].toString()) ?? 0.0,
//       amountReceived:
//           double.tryParse(json['amount_received'].toString()) ?? 0.0,
//       progressPercentage: json['progress_percentage'].toDouble(),
//       investorCounts: json['investorCounts'],
//       category: Category.fromJson(json['category']),
//     );
//   }

//   get imageString => "https://admin.ethabah.com/investorFund/$image";

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
//       'total_funds': totalFunds,
//       'profit_percentage': profitPercentage,
//       'duration_of_investment': durationOfInvestment,
//       'custom_months': customMonths,
//       'start_of_period': startOfPeriod?.toIso8601String(),
//       'end_of_period': endOfPeriod?.toIso8601String(),
//       'image': image,
//       'viewer': viewer,
//       'status': status,
//       'created_at': createdAt.toIso8601String(),
//       'updated_at': updatedAt.toIso8601String(),
//       'investmentFundCounts': investmentFundCounts,
//       'amountSum': amountSum,
//       'amount_received': amountReceived,
//       'progress_percentage': progressPercentage,
//       'investorCounts': investorCounts,
//       'category': category.toJson(),
//     };
//   }
// }

// class Category {
//   final int id;
//   final int userId;
//   final String name;
//   final DateTime createdAt;
//   final DateTime updatedAt;

//   Category({
//     required this.id,
//     required this.userId,
//     required this.name,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory Category.fromJson(Map<String, dynamic> json) {
//     return Category(
//       id: json['id'],
//       userId: json['user_id'],
//       name: json['name'],
//       createdAt: DateTime.parse(json['created_at']),
//       updatedAt: DateTime.parse(json['updated_at']),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'user_id': userId,
//       'name': name,
//       'created_at': createdAt.toIso8601String(),
//       'updated_at': updatedAt.toIso8601String(),
//     };
//   }
// }
