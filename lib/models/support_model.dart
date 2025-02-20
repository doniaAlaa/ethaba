import 'dart:convert';

class SupportModel {
  SupportModel({
    
    this.data


  });

  SupportData? data;
  



  factory SupportModel.fromJson(Map<String, dynamic> json) => SupportModel(
    data: SupportData.fromJson(json['data']),
  




  );

// Map<String, dynamic> toJson() => {
//   // "message":message,
//
// };
}



class SupportData {
  SupportData({
    this.id,
    this.phone1,
    this.phone2,
    this.email,
    this.facebook,
    this.instagram,
    this.twitter,
    this.linkedIn,
    this.snapchat,
    this.pinterest,
    this.telegram,
    this.threads,
    this.tiktok,
    this.youtube,
    this.whatsapp,



  });

  int? id;
  String? email;
  String? phone1;
  String? phone2;
  String? facebook;
  String? instagram;
  String? twitter;
  String? linkedIn;
  String? snapchat;
  String? pinterest;
  String? tiktok;
  String? threads;
  String? youtube;
  String? telegram;
  String? whatsapp;



  factory SupportData.fromJson(Map<String, dynamic> json) => SupportData(
    id: json["id"],
    phone1: json["phone1"],
    phone2: json["phone2"],
    pinterest: json["pinterest"],
    tiktok: json["tiktok"],
    threads: json["threads"],
    telegram: json["telegram"],
    twitter: json["twitter"],
    email: json["email"],
    youtube: json["youtube"],
    facebook: json["facebook"],
    linkedIn: json["linkedIn"],
    snapchat: json["snapchat"],
    instagram: json["instagram"],
    whatsapp: json["whatsapp"],




  );

  // Map<String, dynamic> toJson() => {
  //   // "message":message,
  //
  // };
}













