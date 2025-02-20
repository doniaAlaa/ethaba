// import 'dart:developer';
//
// import 'package:ethabah/controller/categories_controller.dart';
// import 'package:ethabah/core/constants/app_routes.dart';
// import 'package:ethabah/core/utils/date_helper.dart';
// import 'package:ethabah/core/utils/status_helper.dart';
// import 'package:ethabah/data/shared/user_pref.dart';
// import 'package:ethabah/models/User_model.dart';
// import 'package:ethabah/models/req_investment_fund_model.dart';
// import 'package:ethabah/presentation/components/custom_rounded_button.dart';
// import 'package:ethabah/presentation/components/funding_rec_widget.dart';
// import 'package:ethabah/presentation/components/funding_req_widget.dart';
// import 'package:ethabah/presentation/screens/investor_flow/company_details/company_details_screen.dart';
// import 'package:ethabah/presentation/screens/investor_flow/company_details/company_details_screen2.dart';
// import 'package:ethabah/presentation/screens/investor_flow/make_investment/make_investment_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:ethabah/core/constants/app_strings.dart';
// import 'package:ethabah/core/constants/app_theme.dart';
// import 'package:get/get.dart';
//
// class InvestmentFundDetailScreen extends StatelessWidget {
//   final RequestInvestmentFund fund;
//   const InvestmentFundDetailScreen({required this.fund,super.key});
//
//
//   @override
//   Widget build(BuildContext context) {
//     final catController = Get.isRegistered<CategoriesController>()
//         ? Get.find<CategoriesController>()
//         : Get.put(CategoriesController());
//
//     String categoryName =
//         catController.getCategoryName(fund.investmentFund.categoryId) ?? "N/A";
//     String startDate = formatDate(fund.investmentFund.startOfPeriod.toString());
//     String endDate = formatDate(fund.investmentFund.endOfPeriod.toString());
//     String durationOfInvestment =
//         '${fund.investmentFund.durationOfInvestment} ${fund.investmentFund.month}';
//     String profitPercentage = '${fund.investmentFund.profitPercentage}%';
//     String profitType = fund.investmentFund.profit;
//     String status = getStatusText(fund.investmentFund.status);
//     Color statusColor = getStatusColor(fund.investmentFund.status);
//     double totalFundReq = double.parse(fund.investmentFund.totalFunds);
//     // double totalFundRec = double.parse(fund.amountSum.toString());
//     // double progress = totalFundRec / totalFundReq;
//     double profit = double.parse(fund.amount) *
//         double.parse(fund.investmentFund.profitPercentage) /
//         100;
//     log("${fund.investmentFund.imageString}");
//     return Scaffold(
//       backgroundColor: kBackgroundColor,
//       appBar: AppBar(
//         clipBehavior: Clip.none,
//         title: Text(
//           StringConstants.details,
//           style:
//               kSubtitleTextStyle.copyWith(
//                   color:kWhiteColor,
//                //   color: kNeonColor,
//                   fontSize: 18.sp),
//         ),
//         leading: IconButton(
//           onPressed: () {
//             Get.back();
//           },
//           icon: const Icon(
//             Icons.arrow_back_ios_rounded,
//             // color: kNeonColor,
//             color: kWhiteColor,
//
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             //Image
//             Stack(
//               children: [
//                 Positioned(
//                   top: 0,
//                   right: 0,
//                   left: 0,
//                   child: Container(
//                     height: 150.h,
//                     width: 1.sw,
//                     decoration: const BoxDecoration(
//                       color: kPrimaryColor,
//                     ),
//                     child: ClipRRect(
//                       child: (fund.investmentFund.image != null)
//                           ? Image.network(
//                               fund.investmentFund.imageString,
//                               fit: BoxFit.cover,
//                               height: 80.h,
//                               errorBuilder: (context, error, stackTrace) =>
//                                   Padding(
//                                     padding: const EdgeInsets.all(22),
//                                     child: Image.asset(
//                                         "assets/icons/splash.png",
//                                         fit: BoxFit.contain,
//                                         height: 80.h,
//                                       ),
//                                   ),
//                             )
//                           : Padding(
//                             padding: const EdgeInsets.all(22.0),
//                             child: Image.asset(
//                                 "assets/icons/splash.png",
//                                 fit: BoxFit.contain,
//                                 height: 80.h,
//                               ),
//                           ),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 0.01.sh,
//                   left: 0.04.sw,
//                   child: Container(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                     decoration: BoxDecoration(
//                       color: getStatusColor(fund.status),
//                       borderRadius: BorderRadius.circular(5.r),
//                     ),
//                     child: Text(
//                       getStatusText(fund.status),
//                       style: TextStyle(
//                         color: kWhiteColor,
//                         fontSize: 12.sp,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                     child: Container(
//                   margin: EdgeInsets.only(
//                     top: 130.h,
//                   ),
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
//                   decoration: BoxDecoration(
//                     color: kWhiteColor,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(20.r),
//                       topRight: Radius.circular(20.r),
//                     ),
//                   ),
//                   child: Column(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 10, vertical: 10),
//                         decoration: const BoxDecoration(),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Flexible(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Flexible(
//                                         child: Text(
//                                           fund.investmentFund.name ?? "N/A",
//                                           style: TextStyle(
//                                             fontSize: 24.sp,
//                                             fontWeight: FontWeight.bold,
//                                             fontFamily: kFontFamily,
//                                           ),
//                                           maxLines: 2,
//                                           overflow: TextOverflow.ellipsis,
//                                         ),
//                                       ),
//                                       Directionality(
//                                         textDirection: TextDirection.ltr,
//                                         child: Row(
//                                           children: [
//                                             // Icon and viewcount
//                                             Icon(
//                                               Icons.remove_red_eye,
//                                               color: kPrimaryColor,
//                                               size: 20.r,
//                                             ),
//                                             SizedBox(width: 5.w),
//                                             Text(
//                                               "${fund.investmentFund.viewer ?? "0"}",
//                                               style:
//                                                   ksmallDescTextStyle.copyWith(
//                                                 color: kPrimaryColor,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                   SizedBox(
//                                     height: 10.h,
//                                   ),
//                                   Container(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 10, vertical: 5),
//                                     decoration: BoxDecoration(
//                                       color: kPrimaryColor,
//                                       borderRadius: BorderRadius.circular(5.r),
//                                     ),
//                                     child: Text(
//                                       categoryName,
//                                       style: ksmallDescTextStyle.copyWith(
//                                         color: kWhiteColor,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: 10.h,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(StringConstants.amountInvested,
//                                   style: ksmallHeadTextStyle),
//                               Text("SAR ${fund.amount}",
//                                   style: ksmallHeadTextStyle.copyWith(
//                                       color: kPrimaryColor,
//                                       fontWeight: FontWeight.bold)),
//                             ],
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Text(StringConstants.profit,
//                                   style: ksmallHeadTextStyle),
//                               Text('SR ${profit.toStringAsFixed(2)}',
//                                   style: ksmallHeadTextStyle.copyWith(
//                                       color: kPrimaryColor,
//                                       fontWeight: FontWeight.bold)),
//                             ],
//                           ),
//                         ],
//                       ),
//                       // SizedBox(
//                       //   height: 20.h,
//                       // ),
//                       // Row(
//                       //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       //   children: [
//                       //     Directionality(
//                       //       textDirection: TextDirection.ltr,
//                       //       child: Row(
//                       //         crossAxisAlignment: CrossAxisAlignment.center,
//                       //         children: [
//                       //           Text(
//                       //             "SAR ${fund.amountSum} ",
//                       //             style: ksmallDescTextStyle.copyWith(
//                       //               fontSize: 18.sp,
//                       //               color: kPrimaryColor,
//                       //               fontWeight: FontWeight.bold,
//                       //             ),
//                       //           ),
//                       //           Text(
//                       //             "(${StringConstants.collected})",
//                       //             style: ksmallDescTextStyle.copyWith(
//                       //               fontSize: 12.sp,
//                       //               color: kGreyColor,
//                       //               fontWeight: FontWeight.bold,
//                       //             ),
//                       //           ),
//                       //         ],
//                       //       ),
//                       //     ),
//                       //     Text(
//                       //       "${(progress * 100).toStringAsFixed(2)}%",
//                       //       style: ksmallDescTextStyle.copyWith(
//                       //         fontSize: 14.sp,
//                       //         color: kPrimaryColor,
//                       //         fontWeight: FontWeight.bold,
//                       //       ),
//                       //     ),
//                       //   ],
//                       // ),
//                       // SizedBox(
//                       //   height: 5.h,
//                       // ),
//                       // LinearProgressIndicator(
//                       //   value: progress,
//                       //   backgroundColor: kGreyColor.withOpacity(0.5),
//                       //   color: kPrimaryColor,
//                       //   minHeight: 10.h,
//                       //   borderRadius: BorderRadius.circular(5.r),
//                       // ),
//                       // //total fund required
//                       // Row(
//                       //   mainAxisAlignment: MainAxisAlignment.end,
//                       //   crossAxisAlignment: CrossAxisAlignment.center,
//                       //   children: [
//                       //     Text(
//                       //       "SAR ${fund.investmentFund.totalFunds} ",
//                       //       style: ksmallDescTextStyle.copyWith(
//                       //         fontSize: 14.sp,
//                       //         color: kPrimaryColor,
//                       //         fontWeight: FontWeight.bold,
//                       //       ),
//                       //     ),
//                       //     Text(
//                       //       "(${StringConstants.fundingRequired})",
//                       //       style: ksmallDescTextStyle.copyWith(
//                       //         fontSize: 12.sp,
//                       //         color: kGreyColor,
//                       //         fontWeight: FontWeight.bold,
//                       //       ),
//                       //     ),
//                       //   ],
//                       // ),
//                       // SizedBox(height: 30.h),
//                       Column(
//                         children: [
//                           SizedBox(
//                             height: 100.h,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 _buildGridItem(
//                                     Icons.category,
//                                     StringConstants.typeOfInvestment,
//                                     categoryName,
//                                     true),
//                                 Container(
//                                   width: 1.w,
//                                   color: kGreyColor.withOpacity(0.5),
//                                 ),
//                                 _buildGridItem(
//                                     Icons.access_time,
//                                     StringConstants.durationOfInvestment,
//                                     durationOfInvestment,
//                                     true),
//                                 Container(
//                                   width: 1.w,
//                                   color: kGreyColor.withOpacity(0.5),
//                                 ),
//                                 _buildGridItem(
//                                     Icons.percent,
//                                     StringConstants.profitPercentage,
//                                     profitPercentage,
//                                     true),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10.h,
//                           ),
//                           SizedBox(
//                             height: 100.h,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 _buildGridItem(
//                                     Icons.date_range,
//                                     StringConstants.startOfPeriod,
//                                     startDate,
//                                     false),
//                                 Container(
//                                   width: 1.w,
//                                   color: kGreyColor.withOpacity(0.5),
//                                 ),
//                                 _buildGridItem(Icons.event,
//                                     StringConstants.endOfPeriod, endDate, true),
//                                 Container(
//                                   width: 1.w,
//                                   color: kGreyColor.withOpacity(0.5),
//                                 ),
//                                 _buildGridItem(
//                                     Icons.monetization_on,
//                                     StringConstants.returnOfInvestment,
//                                     profitType,
//                                     false),
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                       SizedBox(
//                         height: 10.h,
//                       ),
//                       SizedBox(
//                         height: 10.h,
//                       ),
//                       Container(
//                         height: 1.h,
//                         color: kGreyColor.withOpacity(0.5),
//                       ),
//                       SizedBox(
//                         height: 10.h,
//                       ),
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: Text(StringConstants.companies,
//                             style: ksmallHeadTextStyle),
//                       ),
//                       SizedBox(
//                         height: 5.h,
//                       ),
//                       fund.investmentFund.investmentFundCompanies.isNotEmpty
//                           ? Container(
//                               padding: const EdgeInsets.symmetric(
//                                 vertical: 10,
//                                 horizontal: 15,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: kPrimaryColor.withOpacity(0.5),
//                                 borderRadius: BorderRadius.circular(15),
//                               ),
//                               child: ListView.separated(
//                                 shrinkWrap: true,
//                                 padding: EdgeInsets.zero,
//                                 separatorBuilder: (context, index) =>
//                                     const Divider(color: Colors.white),
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 itemCount: fund.investmentFund
//                                     .investmentFundCompanies.length,
//                                 itemBuilder: (context, index) {
//                                   final e = fund.investmentFund
//                                       .investmentFundCompanies[index];
//                                   return Padding(
//                                     padding:
//                                         const EdgeInsets.symmetric(vertical: 8),
//                                     child: GestureDetector(
//                                       // onTap: () => Navigator.push(
//                                       //   context,
//                                       //   MaterialPageRoute(
//                                       //     builder: (context) =>
//                                       //         CompanyDetailScreen(
//                                       //             fcompany: e.company),
//                                       //   ),
//                                       // ),
//                                       child: Row(
//                                         // mainAxisAlignment:
//                                         //     MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           //Circle with kPrimaryColor background and Icon office
//                                           Container(
//                                             height: 40.h,
//                                             width: 40.h,
//                                             decoration: BoxDecoration(
//                                               color: kPrimaryColor,
//                                               shape: BoxShape.circle,
//                                             ),
//                                             child: Icon(
//                                               Icons.business,
//                                               color: kWhiteColor,
//                                               size: 27.r,
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             width: 10.w,
//                                           ),
//                                           Text(
//                                             e.company.name,
//                                             style: ksmallDescTextStyle.copyWith(
//                                               color: kWhiteColor,
//                                               fontWeight: FontWeight.w600,
//                                               fontSize: 16.sp,
//                                             ),
//                                           ),
//                                           // Container(
//                                           //   padding: const EdgeInsets.symmetric(
//                                           //     horizontal: 15,
//                                           //     vertical: 10,
//                                           //   ),
//                                           //   decoration: BoxDecoration(
//                                           //     color: kPrimaryColor,
//                                           //     borderRadius:
//                                           //         BorderRadius.circular(5.r),
//                                           //   ),
//                                           //   child: Text(
//                                           //     StringConstants.viewMore,
//                                           //     style: TextStyle(
//                                           //       color: kWhiteColor,
//                                           //       fontSize: 12.sp,
//                                           //       fontWeight: FontWeight.bold,
//                                           //     ),
//                                           //   ),
//                                           // ),
//                                         ],
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             )
//                           : Text(
//                               "N/A",
//                               style: ksmallDescTextStyle,
//                             ),
//                       SizedBox(
//                         height: 10.h,
//                       ),
//                       SizedBox(
//                         height: 10.h,
//                       ),
//                       (fund.investmentFund.status == "0" ||
//                               fund.investmentFund.status == "3")
//                           ? CustomRoundedButton(
//                               height: 50.h,
//                               backgroundColor: kPrimaryColor,
//                               textColor: kWhiteColor,
//                               loading: false,
//                               text: StringConstants.makeAnInvestment,
//                               onPressed: () {
//                                 Get.to(() => const MakeInvestmentScreen());
//                               })
//                           : Container(),
//                       SizedBox(
//                         height: 10.h,
//                       ),
//                       SizedBox(
//                         height: 10.h,
//                       ),
//                     ],
//                   ),
//                 ))
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildGridItem(
//       IconData icon, String title, String value, bool divider) {
//     return SizedBox(
//       width: 0.9.sw / 3,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Icon(
//             icon,
//             color: kPrimaryColor,
//             size: 30.r,
//           ),
//           SizedBox(
//             height: 3.h,
//           ),
//           Text(
//             title,
//             style: ksmallHeadTextStyle,
//           ),
//           SizedBox(
//             height: 3.h,
//           ),
//           Flexible(
//             child: Text(
//               value,
//               style: ksmallDescTextStyle,
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
