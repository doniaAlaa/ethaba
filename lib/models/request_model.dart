import 'dart:convert';

import 'package:ethabah/models/company_model.dart';

class RequestModel {
  final TotalFundData? total;


  final List<Request> data;


  RequestModel({
    required this.total,
    required this.data,

  });

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      total:  TotalFundData.fromJson(json['total']),
      // data: Request.fromJson(json['user_id']) ,
      data: List<Request>.from(
          json['data'].map((x) => Request.fromJson(x))),


    );
  }


}


class TotalFundData {
  final num? approved_requests;
  final num? pending_requests;
  final num? rejected_requests;
  final num? requests_with_funds;

  TotalFundData({
    required this.approved_requests,
    required this.pending_requests,
    required this.rejected_requests,
    required this.requests_with_funds,

  });

  factory TotalFundData.fromJson(Map<String, dynamic> json) {
    return TotalFundData(
      approved_requests: json['approved_requests'],
      pending_requests: json['pending_requests'],
      rejected_requests: json['rejected_requests'],
      requests_with_funds: json['requests_with_funds'],

    );
  }


}


class Request {
  final int id;
  final int? userId;
  final String? name;
  final String? category;
  final String? purposeOfFunding;
  final String? totalFunds;
  final String? description;
  final String? status;
  // final DateTime? createdAt;
  final String? createdAt;

  final DateTime? updatedAt;
  final CompanyModel? user;
  final List<String>? url;
  final List<String>? documents;
  final List<String>? document_names;

  Request({
    required this.id,
    required this.userId,
    required this.name,
    required this.category,
    required this.purposeOfFunding,
    required this.totalFunds,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.url,
    this.documents,
    this.document_names,
  });

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
        id: json['id'],
        userId: json['user_id'],
        name: json['name'],
        // category: json['category'],
        category: json['category_name'],

        purposeOfFunding: json['purpose_of_funding'],
        totalFunds: json['total_funds'],
        description: json['description'],
        status: json['status'],
        // createdAt: DateTime.parse(json['created_at']),
        createdAt: json['created_at'],

        updatedAt: DateTime.parse(json['updated_at']),
        user: json['user'] != null ? CompanyModel.fromJson(json['user']):null,
        url: json['request_document'] != null
            ? List<String>.from(jsonDecode(json['request_document']))
            : null,
        documents : json['documents'] != null ?json['documents'].cast<String>():null,
        document_names : json['document_names'] != null ?json['document_names'].cast<String>():null
    );
  }

  List<String> get imageUrls {
    const baseUrl = 'https://admin.ethabah.com/request_document/';
    return url?.map((file) => '$baseUrl$file').toList() ?? [];
  }
}

