import 'dart:convert';

import 'package:ethabah/models/admin_bank_data_model.dart';

class User {
  final int id;
  final int? companyId;
  final String name;
  final String? email;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? emailVerifiedAt;
  final int role;
  final String? whatsappNumber;
  final String? phone;
  final String? address;
  // final List<String>? passport;
  // final List<String>? nationalId;
  final String? profile_img;
  final String? nationalId;
  final String? status;
  final BankData? bank_account;

  User({
    required this.id,
    this.companyId,
    required this.name,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    this.emailVerifiedAt,
    required this.role,
    this.whatsappNumber,
    this.phone,
    this.address,
    // this.passport,
     this.nationalId,
    required this.status,
    this.profile_img,
    this.bank_account
  });

  // Factory constructor to create a User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      companyId: json['company_id'],
      name: json['name'],
      email: json['email'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      emailVerifiedAt: json['email_verified_at'],
      role: json['role'],
      whatsappNumber: json['whatsapp_number'],
      phone: json['phone'],
      address: json['address'],
      profile_img:json['profile_img'],
      // passport: json['passport'] != null
      //     ? List<String>.from(jsonDecode(json['passport']))
      //     : null,
      // nationalId: json['national_id'] != null
      //     ? List<String>.from(jsonDecode(json['national_id']))
      //     : null,
      nationalId :json['national_id'] ,
      status: json['status'],
      bank_account:json['bank_account'] != null ? BankData.fromJson(json['bank_account']):null ,
    );
  }

  // Method to convert a User to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company_id': companyId,
      'name': name,
      'email': email,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'email_verified_at': emailVerifiedAt,
      'role': role,
      'whatsapp_number': whatsappNumber,
      'phone': phone,
      'address': address,
      // 'passport': passport != null ? jsonEncode(passport) : null,
      // 'national_id': nationalId != null ? jsonEncode(nationalId) : null,
      'national_id': nationalId,
      'status': status,
      'profile_img':profile_img,
      'bank_account':bank_account?.toJson()
    };
  }
}
