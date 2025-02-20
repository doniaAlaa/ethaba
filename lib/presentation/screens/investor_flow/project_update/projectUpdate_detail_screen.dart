// import 'dart:developer';
//
// import 'package:ethabah/controller/categories_controller.dart';
// import 'package:ethabah/core/constants/app_strings.dart';
// import 'package:ethabah/core/constants/app_theme.dart';
// import 'package:ethabah/models/investment_fund_update_model.dart';
// import 'package:ethabah/presentation/screens/company_flow/home/home_screen.dart';
// import 'package:ethabah/presentation/screens/investor_flow/home/inv_home_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class ProjectupdateDetailScreen extends StatelessWidget {
//   final RequestInvestmentFundUpdate fund;
//   final List<ProjectUpdate>? projects;
//   const ProjectupdateDetailScreen({
//     Key? key,
//     required this.fund,
//     required this.projects,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final catController = Get.isRegistered<CategoriesController>()
//         ? Get.find<CategoriesController>()
//         : Get.put(CategoriesController());
//
//     double profit = double.parse(fund.amount) *
//         double.parse(fund.investmentFund.profitPercentage) /
//         100;
//     final payments = fund.investmentFund.payments;
//
//     return Scaffold(
//         backgroundColor: kBackgroundColor,
//         appBar: AppBar(
//           title: Text(
//             StringConstants.investmentFundUpdates,
//             style: kHeadingTextStyle.copyWith(
//               color: kNeonColor,
//               fontSize: 14.sp,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//           centerTitle: true,
//           leading: IconButton(
//             icon: const Icon(
//               Icons.arrow_back_ios,
//               color: kNeonColor,
//             ),
//             onPressed: () {
//               Get.back();
//             },
//           ),
//         ),
//         body: SafeArea(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: 20.h,
//                   ),
//                   Text(
//                     fund.investmentFund.name,
//                     style: kSubtitleTextStyle.copyWith(
//                       color: kPrimaryColor,
//                       fontSize: 18.sp,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20.h,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             StringConstants.myInvestment,
//                             style: kSubtitleTextStyle.copyWith(
//                               color: kBlackColor,
//                               fontSize: 12.sp,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                           SizedBox(
//                             height: 5.h,
//                           ),
//                           Text(
//                             "SAR ${formatAmount(double.parse(fund.amount))}",
//                             style: kSubtitleTextStyle.copyWith(
//                               color: kPrimaryColor,
//                               fontSize: 18.sp,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Text(
//                             StringConstants.profit,
//                             style: kSubtitleTextStyle.copyWith(
//                               color: kBlackColor,
//                               fontSize: 12.sp,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                           SizedBox(
//                             height: 5.h,
//                           ),
//                           Text(
//                             "SAR ${formatAmount(profit)}",
//                             style: kSubtitleTextStyle.copyWith(
//                               color: kPrimaryColor,
//                               fontSize: 18.sp,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                   SizedBox(
//                     height: 20.h,
//                   ),
//                   Row(
//                     children: [
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             StringConstants.returnOfInvestment,
//                             style: kSubtitleTextStyle.copyWith(
//                               color: kBlackColor,
//                               fontSize: 12.sp,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                           SizedBox(
//                             height: 5.h,
//                           ),
//                           Text(
//                             "${fund.investmentFund.profitPercentage}%",
//                             style: kSubtitleTextStyle.copyWith(
//                               color: kPrimaryColor,
//                               fontSize: 18.sp,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 20.h,
//                   ),
//                   if (payments.isNotEmpty) ...[
//                     Text(
//                       StringConstants.payments,
//                       style: kHeadingTextStyle.copyWith(
//                         color: kPrimaryColor,
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                     ListView.builder(
//                       padding: EdgeInsets.zero,
//                       physics: const NeverScrollableScrollPhysics(),
//                       shrinkWrap: true,
//                       itemCount: payments.length,
//                       itemBuilder: (context, paymentIndex) {
//                         final payment = payments[paymentIndex];
//                         return Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 5),
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 10, vertical: 15),
//                             decoration: BoxDecoration(
//                               color: kPrimaryColor.withOpacity(1),
//                               borderRadius: BorderRadius.circular(5),
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       "Payment ID: ${payment.id}",
//                                       style: kSubtitleTextStyle.copyWith(
//                                         color: kNeonColor,
//                                         fontSize: 16.sp,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     //date
//                                     Text(
//                                       "${formatDate(payment.createdAt)}",
//                                       style: kSubtitleTextStyle.copyWith(
//                                         color: kWhiteColor,
//                                         fontSize: 16.sp,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   children: [
//                                     Text(
//                                       "Amount",
//                                       style: kSubtitleTextStyle.copyWith(
//                                         color: kNeonColor,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 16.sp,
//                                       ),
//                                     ),
//                                     Text(
//                                       "SAR ${payment.amount}",
//                                       style: kSubtitleTextStyle.copyWith(
//                                         color: kWhiteColor,
//                                         fontSize: 16.sp,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ] else ...[
//                     SizedBox(height: 10.h),
//                     Text(
//                       StringConstants.noPaymentsInitiated,
//                       style: kSubtitleTextStyle.copyWith(
//                         color: kPrimaryColor,
//                         fontSize: 14.sp,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ],
//                   SizedBox(
//                     height: 20.h,
//                   ),
//                   Text(
//                     StringConstants.projectUpdates,
//                     style: kHeadingTextStyle.copyWith(
//                       color: kPrimaryColor,
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                   ListView.builder(
//                       clipBehavior: Clip.none,
//                       padding: EdgeInsets.zero,
//                       physics: const NeverScrollableScrollPhysics(),
//                       shrinkWrap: true,
//                       itemCount: projects!.length,
//                       itemBuilder: (context, index) {
//                         final project = projects![index];
//                         final List<int> companyIds = fund
//                             .investmentFund.investmentFundCompanies
//                             .map((e) => e.companyId)
//                             .toList();
//                         if (project.companyId != null &&
//                             !companyIds.contains(project.companyId)) {
//                           return Container();
//                         }
//                         String companyName = fund
//                             .investmentFund.investmentFundCompanies
//                             .firstWhere((element) =>
//                                 element.companyId == project.companyId)
//                             .company
//                             .name;
//                         return Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 10),
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 10, vertical: 15),
//                             decoration: BoxDecoration(
//                               color: kSecondaryColor,
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Row(
//                               children: [
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       project.updateName,
//                                       style: kSubtitleTextStyle.copyWith(
//                                           fontWeight: FontWeight.bold,
//                                           color: kNeonColor,
//                                           fontSize: 14.sp),
//                                     ),
//                                     SizedBox(
//                                       height: 5.h,
//                                     ),
//                                     Text(
//                                       companyName,
//                                       style: kSubtitleTextStyle.copyWith(
//                                           fontWeight: FontWeight.bold,
//                                           color: kWhiteColor,
//                                           fontSize: 14.sp),
//                                     ),
//                                     SizedBox(
//                                       height: 5.h,
//                                     ),
//
//                                     //updated date
//                                     Text(
//                                       "${StringConstants.lastUpdated} ${formatDate(project.updatedAt)}",
//                                       style: kSubtitleTextStyle.copyWith(
//                                           fontSize: 10.sp, color: Colors.white),
//                                     ),
//                                   ],
//                                 ),
//                                 const Spacer(),
//                                 Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     InkWell(
//                                       onTap: () {
//                                         _launchURL(project.documentUrl);
//                                       },
//                                       child: Container(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 10.w, vertical: 5.h),
//                                         decoration: BoxDecoration(
//                                           color: kPrimaryColor,
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                         ),
//                                         child: Center(
//                                           child: Text(
//                                             StringConstants.download,
//                                             style: TextStyle(
//                                               color: kNeonColor,
//                                               fontSize: 12.sp,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     )
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//                         );
//                       }),
//                 ],
//               ),
//             ),
//           ),
//         ));
//   }
// }
//
// Future<void> _launchURL(String url) async {
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }
//
// Future<void> _downloadAllFiles(List<String> urls) async {
//   for (String url in urls) {
//     await _launchURL(url);
//   }
// }
