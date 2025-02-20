class CategoryModelResponse {
  final bool success;
  final String message;
  final List<CategoryModel> data;

  CategoryModelResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  // Factory constructor to create a CategoryModel from JSON
  factory CategoryModelResponse.fromJson(Map<String, dynamic> json) {
    return CategoryModelResponse(
      success: json['success'],
      message: json['message'],
      data: List<CategoryModel>.from(
          json['data'].map((x) => CategoryModel.fromJson(x))),
    );
  }

  // Method to convert a CategoryModel to JSON
  // Map<String, dynamic> toJson() {
  //   return {
  //     'success': success,
  //     'message': message,
  //     'data': List<dynamic>.from(data.map((x) => x.toJson())),
  //   };
  // }
}

class CategoryModel {
  final int id;
  final int userId;
  final String name;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CategoryModel({
    required this.id,
    required this.userId,
    required this.name,
    this.createdAt,
    this.updatedAt,
  });

  // Factory constructor to create a Category from JSON
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  // Method to convert a Category to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
