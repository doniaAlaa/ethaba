

import 'package:get/get.dart';

class WalletTransactionsModel {
  final String message;
  final List<TotalAmount>? total;
  final List<TransactionData> data;

  WalletTransactionsModel({
    required this.message,
    required this.total,
    required this.data
  });

  // Factory constructor to create a CategoryModel from JSON
  factory WalletTransactionsModel.fromJson(Map<String, dynamic> json) {
    return WalletTransactionsModel(
      message: json['message'],
      total: List<TotalAmount>.from(
          json['total'].map((x) => TotalAmount.fromJson(x))),

      data: List<TransactionData>.from(
          json['data'].map((x) => TransactionData.fromJson(x))),
    );
  }

  // Method to convert a CategoryModel to JSON
  Map<String, dynamic> toJson() {
    return {

      'total': List<dynamic>.from(total!.map((x) => x.toJson())),
      'data': List<dynamic>.from(data.map((x) => x.toJson())),

    };
  }
}

class TotalAmount {
  final int all_paid;
  final int all_recieved;


  TotalAmount({
    required this.all_paid,
    required this.all_recieved,

  });

  // Factory constructor to create a Category from JSON
  factory TotalAmount.fromJson(Map<String, dynamic> json) {
    return TotalAmount(
      all_paid: json['all_paid'],
      all_recieved: json['all_recieved'],

    );
  }

  // Method to convert a Category to JSON
  Map<String, dynamic> toJson() {
    return {
      'all_paid': all_paid,
      'all_recieved': all_recieved,

    };
  }
}

class TransactionData {

  final int? id ;
  final String? name ;
  final String? category;
  final String? date;
  final String? profit_percentage;
  final String? amount_paid;
  final num? recieved;


  TransactionData({
     this.id,
     this.name,
     this.category,
     this.date,
     this.profit_percentage,
     this.amount_paid,
     this.recieved,


  });

  factory TransactionData.fromJson(Map<String, dynamic> json) {
    return TransactionData(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      date: json['data'],
      profit_percentage: json['profit_percentage'],
      amount_paid: json['amount_paid'],
      recieved: json['recieved'],

    );
  }

  // Method to convert a Category to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'date': date,
      'profit_percentage': profit_percentage,
      'amount_paid': amount_paid,
      'recieved': recieved,

    };
  }
}
