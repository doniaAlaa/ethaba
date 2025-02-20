class CompanyStatsModel {
  final int approvedRequests;
  final int pendingRequests;
  final int requestsWithFunds;
  final bool status;

  CompanyStatsModel({
    required this.approvedRequests,
    required this.pendingRequests,
    required this.requestsWithFunds,
    required this.status,
  });

  factory CompanyStatsModel.fromJson(Map<String, dynamic> json) {
    return CompanyStatsModel(
      approvedRequests: json['approved_requests'],
      pendingRequests: json['pending_requests'],
      requestsWithFunds: json['requests_with_funds'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'approved_requests': approvedRequests,
      'pending_requests': pendingRequests,
      'requests_with_funds': requestsWithFunds,
      'status': status,
    };
  }
}
