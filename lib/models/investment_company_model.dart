class InvestmentFundCompany {
  final int id;
  final String name;
  final String? category;
  final String? total_funds;
  final String? amount_received;
  final num? progress_percentage;
  final num? investorCounts;


  final String? created_at;
  final String? duration_of_investment;
  final String? profit_percentage;
  final String? status;
  final List<String>? documents;
  final List<String>? document_names;


  InvestmentFundCompany({
    required this.id,
    required this.name,
    this.category,
    this.total_funds,
    this.amount_received,
    this.investorCounts,
    this.progress_percentage,
    this.profit_percentage,
    this.status,
    this.created_at,
    this.duration_of_investment,
    this.documents,
    this.document_names,
  });

  factory InvestmentFundCompany.fromJson(Map<String, dynamic> json) {
    return InvestmentFundCompany(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      total_funds: json['total_funds'],
      amount_received: json['amount_received'],
      investorCounts: json['investorCounts'],
      progress_percentage: json['progress_percentage'],
      profit_percentage: json['profit_percentage'],
      status: json['status'],
      created_at: json['created_at'],
      duration_of_investment: json['duration_of_investment'],
        documents : json['documents'] != null ?json['documents'].cast<String>():null,
        document_names : json['document_names'] != null ?json['document_names'].cast<String>():null

    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'investor_funds_id': investorFundsId,
  //     'company_id': companyId,
  //     'created_at': createdAt?.toIso8601String(),
  //     'updated_at': updatedAt?.toIso8601String(),
  //   };
  // }
}
