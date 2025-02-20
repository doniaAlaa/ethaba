

import 'package:get/get.dart';

class CountriesModel {
  final String message;
  final List<Countries> data;

  CountriesModel({
    required this.message,
    required this.data
  });

  // Factory constructor to create a CategoryModel from JSON
  factory CountriesModel.fromJson(Map<String, dynamic> json) {
    return CountriesModel(
      message: json['message'],

      data: List<Countries>.from(
          json['data'].map((x) => Countries.fromJson(x))),
    );
  }

  // Method to convert a CategoryModel to JSON
  Map<String, dynamic> toJson() {
    return {

      'data': List<dynamic>.from(data.map((x) => x.toJson())),

    };
  }
}

class Countries {
  final int id;
  final String name;


  Countries({
    required this.id,
    required this.name,

  });

  // Factory constructor to create a Category from JSON
  factory Countries.fromJson(Map<String, dynamic> json) {
    return Countries(
      id: json['id'],
      name: json['name'],

    );
  }

  // Method to convert a Category to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,

    };
  }
}

