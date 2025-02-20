class CompanyModel {
  final int id;
  final String name;
  final String email;
  final int role;
  final DateTime? emailVerifiedAt;
  final String? phone;
  final String? register_num;
  final String? address;
  final String? registerCertificate;
  final String? commercialCertificate;
  final String? licenses;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  CompanyModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.emailVerifiedAt,
    this.phone,
    this.registerCertificate,
    this.address,
    this.register_num,
    this.commercialCertificate,
    this.licenses,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      register_num: json['register_num'],
      emailVerifiedAt: json['email_verified_at'] != null
          ? DateTime.parse(json['email_verified_at'])
          : null,
      phone: json['phone'],
      address: json['address'],
      registerCertificate: json['register_certificate'],
      commercialCertificate: json['commercial_certificate'],
      licenses: json['licenses'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'email_verified_at': emailVerifiedAt?.toIso8601String(),
      'phone': phone,
      'register_certificate': registerCertificate,
      'commercial_certificate': commercialCertificate,
      'licenses': licenses,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
