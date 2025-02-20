import 'dart:convert';

class InvestmentFundsAndProjectsUpdateResponse {
  final bool success;
  final String message;
  final List<RequestInvestmentFundUpdate> data;
  final List<ProjectUpdate> projects;
  final List<Payment> payments;

  InvestmentFundsAndProjectsUpdateResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.projects,
    required this.payments,
  });

  factory InvestmentFundsAndProjectsUpdateResponse.fromJson(
      Map<String, dynamic> json) {
    // Parse the requests
    List<RequestInvestmentFundUpdate> requests = (json['data'] as List)
        .map((i) => RequestInvestmentFundUpdate.fromJson(i))
        .toList();

    // Parse the projects
    List<ProjectUpdate> projects = (json['projects'] as List)
        .map((i) => ProjectUpdate.fromJson(i))
        .toList();

    // Parse the payments
    List<Payment> payments =
        (json['payments'] as List).map((i) => Payment.fromJson(i)).toList();

    // Create a map to merge requests with the same investment fund
    Map<int, RequestInvestmentFundUpdate> mergedRequests = {};

    for (var request in requests) {
      if (mergedRequests.containsKey(request.investmentFund.id)) {
        // Merge the amount
        mergedRequests[request.investmentFund.id]!.amount =
            (double.parse(mergedRequests[request.investmentFund.id]!.amount) +
                    double.parse(request.amount))
                .toString();
      } else {
        mergedRequests[request.investmentFund.id] = request;
      }
    }

    // Associate projects with their respective investment funds
    for (var project in projects) {
      for (var request in mergedRequests.values) {
        if (request.investmentFund.id == int.parse(project.requestId) &&
            request.investmentFund.companyId == project.companyId) {
          request.investmentFund.projects.add(project);
        }
      }
    }

    // Associate payments with their respective investment funds
    for (var payment in payments) {
      for (var request in mergedRequests.values) {
        if (request.investmentFund.id == payment.investorFundsId) {
          request.investmentFund.payments.add(payment);
        }
      }
    }

    return InvestmentFundsAndProjectsUpdateResponse(
      success: json['success'],
      message: json['message'],
      data: mergedRequests.values.toList(),
      projects: projects,
      payments: payments,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.map((i) => i.toJson()).toList(),
      'projects': projects.map((i) => i.toJson()).toList(),
      'payments': payments.map((i) => i.toJson()).toList(),
    };
  }
}

class ProjectUpdate {
  final int id;
  final int userId;
  final int? companyId;
  final String updateName;
  final String requestId;
  final String document;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProjectUpdate({
    required this.id,
    required this.userId,
    this.companyId,
    required this.updateName,
    required this.requestId,
    required this.document,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProjectUpdate.fromJson(Map<String, dynamic> json) {
    return ProjectUpdate(
      id: json['id'],
      userId: json['user_id'],
      companyId: json['company_id'],
      updateName: json['update_name'],
      requestId: json['request_id'],
      document: json['document'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  get documentUrl => 'https://admin.ethabah.com/document/$document';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'company_id': companyId,
      'update_name': updateName,
      'request_id': requestId,
      'document': document,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class RequestInvestmentFundUpdate {
  final int id;
  final int userId;
  final int investorFundsId;
  String amount;
  final int timeOfInvestment;
  final DateTime? startOfPeriod;
  final DateTime? endOfPeriod;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final InvestmentFundUpdate investmentFund;

  RequestInvestmentFundUpdate({
    required this.id,
    required this.userId,
    required this.investorFundsId,
    required this.amount,
    required this.timeOfInvestment,
    this.startOfPeriod,
    this.endOfPeriod,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.investmentFund,
  });

  factory RequestInvestmentFundUpdate.fromJson(Map<String, dynamic> json) {
    return RequestInvestmentFundUpdate(
      id: json['id'],
      userId: json['user_id'],
      investorFundsId: json['investor_funds_id'],
      amount: json['amount'],
      timeOfInvestment: json['time_of_investment'],
      startOfPeriod: json['start_of_period'] != null
          ? DateTime.parse(json['start_of_period'])
          : null,
      endOfPeriod: json['end_of_period'] != null
          ? DateTime.parse(json['end_of_period'])
          : null,
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      investmentFund: InvestmentFundUpdate.fromJson(json['investment_fund']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'investor_funds_id': investorFundsId,
      'amount': amount,
      'time_of_investment': timeOfInvestment,
      'start_of_period': startOfPeriod?.toIso8601String(),
      'end_of_period': endOfPeriod?.toIso8601String(),
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'investment_fund': investmentFund.toJson(),
    };
  }
}

class InvestmentFundUpdate {
  final int id;
  final int userId;
  final int categoryId;
  final int? companyId;
  final String name;
  final String profit;
  final String amount;
  final String month;
  final String totalFunds;
  final String profitPercentage;
  final String durationOfInvestment;
  final DateTime? startOfPeriod;
  final DateTime? endOfPeriod;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<InvestmentFundCompanyUpdate> investmentFundCompanies;
  final List<ProjectUpdate> projects;
  final List<Payment> payments;

  InvestmentFundUpdate({
    required this.id,
    required this.userId,
    required this.categoryId,
    this.companyId,
    required this.name,
    required this.profit,
    required this.amount,
    required this.month,
    required this.totalFunds,
    required this.profitPercentage,
    required this.durationOfInvestment,
    this.startOfPeriod,
    this.endOfPeriod,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.investmentFundCompanies,
    required this.projects,
    required this.payments,
  });

  factory InvestmentFundUpdate.fromJson(Map<String, dynamic> json) {
    return InvestmentFundUpdate(
      id: json['id'],
      userId: json['user_id'],
      categoryId: json['category_id'],
      companyId: json['company_id'],
      name: json['name'],
      profit: json['profit'],
      amount: json['amount'],
      month: json['month'],
      totalFunds: json['total_funds'],
      profitPercentage: json['profit_percentage'],
      durationOfInvestment: json['duration_of_investment'],
      startOfPeriod: json['start_of_period'] != null
          ? DateTime.parse(json['start_of_period'])
          : null,
      endOfPeriod: json['end_of_period'] != null
          ? DateTime.parse(json['end_of_period'])
          : null,
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      investmentFundCompanies: (json['investment_fund_companies'] as List)
          .map((i) => InvestmentFundCompanyUpdate.fromJson(i))
          .toList(),
      projects: [],
      payments: [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'category_id': categoryId,
      'company_id': companyId,
      'name': name,
      'profit': profit,
      'amount': amount,
      'month': month,
      'total_funds': totalFunds,
      'profit_percentage': profitPercentage,
      'duration_of_investment': durationOfInvestment,
      'start_of_period': startOfPeriod?.toIso8601String(),
      'end_of_period': endOfPeriod?.toIso8601String(),
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'investment_fund_companies':
          investmentFundCompanies.map((i) => i.toJson()).toList(),
      'projects': projects.map((i) => i.toJson()).toList(),
      'payments': payments.map((i) => i.toJson()).toList(),
    };
  }
}

class InvestmentFundCompanyUpdate {
  final int id;
  final int investorFundsId;
  final int companyId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final CompanyUpdate company;

  InvestmentFundCompanyUpdate({
    required this.id,
    required this.investorFundsId,
    required this.companyId,
    this.createdAt,
    this.updatedAt,
    required this.company,
  });

  factory InvestmentFundCompanyUpdate.fromJson(Map<String, dynamic> json) {
    return InvestmentFundCompanyUpdate(
      id: json['id'],
      investorFundsId: json['investor_funds_id'],
      companyId: json['company_id'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      company: CompanyUpdate.fromJson(json['company']),
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

class CompanyUpdate {
  final int id;
  final String name;

  CompanyUpdate({
    required this.id,
    required this.name,
  });

  factory CompanyUpdate.fromJson(Map<String, dynamic> json) {
    return CompanyUpdate(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class Payment {
  final int id;
  final int userId;
  final int investorFundsId;
  final String amount;
  final int createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  Payment({
    required this.id,
    required this.userId,
    required this.investorFundsId,
    required this.amount,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'],
      userId: json['user_id'],
      investorFundsId: json['investor_funds_id'],
      amount: json['amount'],
      createdBy: json['created_by'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'investor_funds_id': investorFundsId,
      'amount': amount,
      'created_by': createdBy,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
