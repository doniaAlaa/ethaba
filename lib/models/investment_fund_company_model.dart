// class InvestmentFundCompany {
//   final int id;
//   final int investorFundsId;
//   final int companyId;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//
//   InvestmentFundCompany({
//     required this.id,
//     required this.investorFundsId,
//     required this.companyId,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory InvestmentFundCompany.fromJson(Map<String, dynamic> json) {
//     return InvestmentFundCompany(
//       id: json['id'],
//       investorFundsId: json['investor_funds_id'],
//       companyId: json['company_id'],
//       createdAt: json['created_at'] != null
//           ? DateTime.parse(json['created_at'])
//           : null,
//       updatedAt: json['updated_at'] != null
//           ? DateTime.parse(json['updated_at'])
//           : null,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'investor_funds_id': investorFundsId,
//       'company_id': companyId,
//       'created_at': createdAt?.toIso8601String(),
//       'updated_at': updatedAt?.toIso8601String(),
//     };
//   }
// }
