import 'dart:convert';



class AdminBankDataModel {
  AdminBankDataModel({
    this.message,
    this.data,

  });

  String? message;
  BankData? data;


  factory AdminBankDataModel.fromJson(Map<String, dynamic> json) => AdminBankDataModel(
    message: json["message"],
    data: BankData.fromJson(json['data']),


  );

  Map<String, dynamic> toJson() => {
    "message":message,
    "data":data,

  };
}

class BankData {
  BankData({
    this.iban_number,
    this.account_number,
    this.account_name,

  });

  String? iban_number;
  String? account_number;
  String? account_name;


  factory BankData.fromJson(Map<String, dynamic> json) => BankData(
    iban_number: json["iban_number"],
    account_number: json["account_number"],
    account_name: json["account_name"],



  );

  Map<String, dynamic> toJson() => {
    "iban_number":iban_number,
    "account_number": account_number,
    "account_name":account_name,

  };
}

