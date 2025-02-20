// import 'package:ethabah/models/investor_model.dart';

// class ProjectModel {
//   final String projectName;
//   final String companyName;
//   final String projectDescription;
//   final String projectCategory;
//   final String purposeOfFunding;
//   final List<Investor>? investors;
//   final double fundRequired;
//   final double fundsReceived;
//   final String aboutProject;
//   final List<String> investorComments;

//   ProjectModel({
//     required this.projectName,
//     required this.companyName,
//     required this.projectDescription,
//     required this.projectCategory,
//     required this.purposeOfFunding,
//     required this.investors,
//     required this.fundRequired,
//     required this.fundsReceived,
//     required this.aboutProject,
//     required this.investorComments,
//   });

//   factory ProjectModel.fromJson(Map<String, dynamic> json) {
//     return ProjectModel(
//       projectName: json['project_name'],
//       companyName: json['company_name'],
//       projectDescription: json['project_description'],
//       projectCategory: json['project_category'],
//       purposeOfFunding: json['purpose_of_funding'],
//       investors: (json['investors'] != null || json['investors'] != [])
//           ? List<Investor>.from(
//               json['investors'].map((x) => Investor.fromJson(x)))
//           : [],
//       fundRequired: json['fund_required'].toDouble(),
//       fundsReceived: json['funds_received'].toDouble(),
//       aboutProject: json['about_project'],
//       investorComments:
//           (json['investor_comments'] != null || json['investor_comments'] != [])
//               ? List<String>.from(json['investor_comments'])
//               : [],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'project_name': projectName,
//       'company_name': companyName,
//       'project_description': projectDescription,
//       'project_category': projectCategory,
//       'purpose_of_funding': purposeOfFunding,
//       'investors': investors != null
//           ? List<dynamic>.from(investors!.map((x) => x.toJson()))
//           : [],
//       'fund_required': fundRequired,
//       'funds_received': fundsReceived,
//       'about_project': aboutProject,
//       'investor_comments': List<dynamic>.from(investorComments),
//     };
//   }
// }
