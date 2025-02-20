class TermsPrivacyModel {

  final TermsModel data;


  TermsPrivacyModel({

    required this.data,

  });

  factory TermsPrivacyModel.fromJson(Map<String, dynamic> json) {
    return TermsPrivacyModel(
      data: TermsModel.fromJson(json['data']),

    );
  }

//base https://admin.ethabah.com/request_document/

}


class TermsModel {

  final String privacy;
  final String terms;


  TermsModel({

    required this.privacy,
    required this.terms,

  });

  factory TermsModel.fromJson(Map<String, dynamic> json) {
    return TermsModel(
      privacy: json['privacy'],
      terms: json['terms'],

    );
  }

//base https://admin.ethabah.com/request_document/

}
