class ProjectDocument {
  final int id;
  final int userId;
  final int companyId;
  final String updateName;
  final String requestId;
  final String document;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProjectDocument({
    required this.id,
    required this.userId,
    required this.companyId,
    required this.updateName,
    required this.requestId,
    required this.document,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProjectDocument.fromJson(Map<String, dynamic> json) {
    return ProjectDocument(
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

  //base https://admin.ethabah.com/request_document/
  String get documentUrl => 'https://admin.ethabah.com/document/$document';

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
